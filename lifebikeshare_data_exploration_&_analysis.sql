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
SELECT  COUNT(*) AS total_rides,
    SUM(CASE WHEN ride_id IS NULL OR TRIM(ride_id) = '' THEN 1 ELSE 0 END) AS blank_or_null_ride_id,
    SUM(CASE WHEN started_at IS NULL THEN 1 ELSE 0 END) AS blank_or_nul_start_time,
    SUM(CASE WHEN ended_at IS NULL THEN 1 ELSE 0 END) AS blank_or_null_end_duration,
    SUM(CASE WHEN start_station_name IS NULL or TRIM(start_station_name) = '' THEN 1 ELSE 0 END) AS Total_Nulls_start_station,
    SUM(CASE WHEN end_station_name IS NULL OR TRIM(end_station_name)= '' THEN 1 ELSE 0 END) AS Total_nulls_end_station,
    SUM(CASE WHEN member_casual IS NULL OR TRIM(member_casual) ='' THEN 1 ELSE 0 END) AS total_member_casual_null_count
FROM combined_baywheels cb ;
--- 1006382 blank spaces in sattrt_station - need to explore this column 
--- 1159846 blank spaces in end station column --- cehcking discrepancies in this column 
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
    COUNT(*) AS total_rides
FROM combined_baywheels cb 
GROUP BY rideable_type, member_casual;
---exploring different rider member utilization accross different rideable type 
