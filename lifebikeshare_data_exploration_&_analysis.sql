-- STEP 1: First inspection of the Baywheels dataset 
-- Purpose: Understand the variables to guide preprocessing and set actiona
SELECT * 
FROM combined_baywheels cb
LIMIT 10;--- to understand each variables in this dataset to preproccessing data and set an objective for this analysis to provdie actionable insight 

-- STEP 2: Null and blank analysis on end stations
-- Insight: Classic bikes require physical docking; missing stations could imply unreturned/stolen bikes.
-- Electric bikes support dockless parking, explaining their higher missing station rates.
SELECT 
    rideable_type,
    member_casual,
    COUNT(*) as missing_end_station_count
FROM combined_baywheels cb 
WHERE cb.end_station_id IS NULL 
   OR cb.end_station_id = '' -- This checks for blank text spaces
GROUP BY rideable_type, member_casual;
--- electric bike missing end point is much higher but they have dockless parking feature, which allow users to return the bike anywhere.
--- this strastegy was implemented to help reduce traffic when returning bikes in high traffic area 
--- casual member- missing end station point = 422832 vs electric bike - missing station: 739570 
--- 8 missing end station for electric scooter 

-- STEP 3: Comprehensive health check for the rest of the dataset
--- Total rows: 12591198 rows
--- actual row with no duplication = 12,591,093
SELECT  COUNT(*) AS total_rides, 
    COUNT (DISTINCT ride_id )AS unique_ride_id, --- checking for dulicate values ,
    SUM(CASE WHEN ride_id IS NULL OR TRIM(ride_id) = '' THEN 1 ELSE 0 END) AS blank_or_null_ride_id,
    SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS blank_or_nul_start_time,
    SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS blank_or_null_end_duration,
    SUM(CASE WHEN start_station_name IS NULL or TRIM(start_station_name) = '' THEN 1 ELSE 0 END) AS Total_Nulls_start_station,
    SUM(CASE WHEN end_station_name IS NULL OR TRIM(end_station_name)= '' THEN 1 ELSE 0 END) AS Total_nulls_end_station,
    SUM(CASE WHEN member_casual IS NULL OR TRIM(member_casual) ='' THEN 1 ELSE 0 END) AS total_member_casual_null_count
FROM combined_baywheels cb ;
--- 1006382 blank spaces in sattrt_station - need to explore this column 
--- 1159846 blank spaces in end station column --- checking discrepancies in this column 
--- exploring the dataset  

-- STEP 4: User distribution exploration (2023 - 2026)
-- Insight: ~75% of total riders hold an active membership
SELECT member_casual, COUNT  (DISTINCT cb.ride_id) AS total_membership
FROM combined_baywheels cb 
GROUP BY cb.member_casual ;
--- Total ride from 2023 to 2026 is 12,591,198 total riders including 3,118,482 casual riders and 9,472,611 members. approximately 75 % riders have membership 

-- STEP 5: Rideable type utilization split
-- Insight: Electric bikes dominate user preference with over 9.6M rides. S
SELECT  rideable_type , COUNT (DISTINCT cb.ride_id ) AS total_ride
FROM combined_baywheels cb 
GROUP BY cb.rideable_type ;

---Lyft provides 3 different rideable type including class bike, electric bike and electric scooter to users accross bay area. User prefers eletric bike with 9659659 users 
--- 2931430 users utilized class bike and only 8 use electric scooter 
-- STEP 6: Breakdown of rider type by vehicle type
SELECT 
    rideable_type, 
    member_casual, 
    COUNT(cb.ride_id ) AS total_rides
FROM combined_baywheels cb 
GROUP BY rideable_type, member_casual;
---exploring different rider member utilization accross different rideable type 

SELECT DISTINCT(rideable_type)
FROM combined_baywheels cb ;

---STEP 6 : Checking null values for end station name, end lattitude and longtitude 
SELECT end_station_name, end_lat, end_lng, rideable_type 
FROM combined_baywheels
WHERE end_station_name is NULL OR end_station_name = '' AND end_lat ='' AND rideable_type = 'classic_bike';
--- most rows that does not have values in end_station_name, end lattitude and end long longtitude are mostly from class bike 
--- As mentioned above, classic bike required to dock to end trip 
--- check classis bike that do have end station and location 
SELECT end_station_name, cb.end_lat, cb.end_lng, cb.rideable_type 
FROM combined_baywheels cb 
WHERE end_station_name is NOT NULL AND cb.end_station_name != '' AND cb.rideable_type = 'classic_bike'; 

WITH total_trip AS (
    SELECT DISTINCT 
        cb.started_at, 
        cb.member_casual,
        cb.rideable_type,
        cb.start_station_name, cb.end_station_name,
        (JULIANDAY(cb.ended_at) - JULIANDAY(cb.started_at)) * 1440 AS duration_minute 
FROM combined_baywheels cb 
)
SELECT member_casual , rideable_type,
(start_station_name || ' to ' || end_station_name ) AS route,
COUNT ( *) AS trips,
ROUND(AVG(duration_minute),2) AS duration 
FROM total_trip 
WHERE rideable_type = 'classic_bike' AND start_station_name = ''  AND end_station_name = '' 
   --- added WHERE rideable_type = 'classic_bike' AND start_station_name = ""  AND end_station_name = ''  to find anomolies 
   --- WHERE rideable_type = 'electric_bike' AND start_station_name = "" AND end_station_name = "", found that 378,474 rows are empty on both (expected behavior), no need to drop
   ---added WHERE rideable_type = 'electric_bike' AND start_station_name = "" OR end_station_name = "", found that many was picked up at random palces or dropped off at random places (valuable analysis)
GROUP BY start_station_name , end_station_name , member_casual 
ORDER BY trips DESC;
--- classic bike where start and end location nulls (anomolies consisder dropping) no dockless feature, drop 44 rows form this finding 
--- some of the trip started at random location (nulls start and end station) mostly because of dockless feature 

---STEP 7: DROP anomolies - 44 rows 
DELETE FROM combined_baywheels 
WHERE rideable_type = 'classic_bike' AND start_station_name = ''  AND end_station_name = '' ;
--- ALL 44 rows have been removed 


--- Data Analysis 
---What is the average duration for different memeber type throughout the week? 
WITH total_trip AS (
    SELECT DISTINCT 
        cb.started_at, 
        cb.member_casual,
        cb.rideable_type,
        (JULIANDAY(cb.ended_at) - JULIANDAY(cb.started_at)) * 1440 AS duration_minute,
        -- '0' is Sunday, '6' is Saturday
        CASE WHEN strftime('%w', cb.started_at) IN ('0', '6') 
             THEN 'Weekend' 
             ELSE 'Weekday' 
        END AS day_type
    FROM combined_baywheels cb 
    WHERE cb.started_at IS NOT NULL   
      AND cb.ended_at IS NOT NULL     
      AND (JULIANDAY(cb.ended_at) - JULIANDAY(cb.started_at)) > 0 
)
SELECT 
    member_casual AS member_type,
    day_type,
    rideable_type,
    ROUND(AVG(duration_minute), 2) AS avg_duration_minutes,
    COUNT(*) AS total_trips
FROM total_trip 
GROUP BY member_casual, day_type, rideable_type 
ORDER BY member_casual, day_type DESC; -- Keeps members/casuals together, Weekday first

 -- Using CTE to calculate duration first before aggregations first to make reduce the risk of making mistake 

WITH total_trip AS (
    SELECT DISTINCT 
        cb.started_at, 
        cb.member_casual,
        cb.rideable_type,
        cb.start_station_name, cb.end_station_name,
        (JULIANDAY(cb.ended_at) - JULIANDAY(cb.started_at)) * 1440 AS duration_minute 
FROM combined_baywheels cb 
)
SELECT member_casual ,
(start_station_name || ' to ' || end_station_name ) AS route,
COUNT ( *) AS trips,
ROUND(AVG(duration_minute),2) AS duration 
FROM total_trip 
WHERE start_station_name != "" AND end_station_name != "" 
GROUP BY start_station_name , end_station_name , member_casual 
ORDER BY trips DESC
LIMIT 20;


SELECT *
FROM combined_baywheels cb 
WHERE NOT (
    rideable_type = 'classic_bike' 
    AND (
        start_station_name = '' OR start_station_name IS NULL 
        OR end_station_name = '' OR end_station_name IS NULL
    )
);

WITH total_trip AS (
    SELECT DISTINCT 
        cb.started_at, 
        cb.member_casual,
        cb.rideable_type,
        cb.start_station_name, cb.end_station_name,
        (JULIANDAY(cb.ended_at) - JULIANDAY(cb.started_at)) * 1440 AS duration_minute 
FROM combined_baywheels cb 
)
SELECT member_casual ,
(start_station_name || ' to ' || end_station_name ) AS route,
COUNT ( *) AS trips,
ROUND(AVG(duration_minute),2) AS duration 
FROM total_trip 
WHERE start_station_name != "" AND end_station_name != "" 
GROUP BY start_station_name , end_station_name , member_casual 
ORDER BY trips DESC
LIMIT 20;
