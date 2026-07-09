-- first inpsection of the baywheel dataset 
SELECT * 
FROM combined_baywheels cb
LIMIT 10;--- to understand each variables in this dataset to preproccessing data and set an objective for this analysis to provdie actionable insight 

--- check for nulls 
SELECT 
    rideable_type,
    member_casual,
    COUNT(*) as missing_end_station_count
FROM combined_baywheels cb 
WHERE cb.end_station_id IS NULL 
   OR cb.end_station_id = '' -- This checks for blank text spaces
GROUP BY rideable_type, member_casual;
---Note:  electric bike dockless parking feature 
--- Note: classic bike does not have dockless parking feature which idicate that users either did not return the bike to the designated station or stolen bikes 


--- exploring the dataset  
SELECT member_casual, COUNT  (DISTINCT cb.ride_id) AS total_membership
FROM combined_baywheels cb 
GROUP BY cb.member_casual ;
--- Total ride from 2023 to 2026 is 12,591,198 total riders including 3,118,482 casual riders and 9,472,611 members. approximately 75 % riders have membership 

--- split ratio of different bike usage 
SELECT  rideable_type , COUNT (DISTINCT cb.ride_id ) AS total_ride
FROM combined_baywheels cb 
GROUP BY cb.rideable_type ;

---Lyft provides 3 different rideable type including class bike, electric bike and electric scooter to users accross bay area. User prefers eletric bike with 9659659 users 
--- 2931430 users utilized class bike and only 8 use electric scooter 

---exploring different rider member utilization accross different rideable type 
SELECT 
    rideable_type,
    member_casual,
    COUNT(*) as total_rides
FROM combined_baywheels cb 
WHERE rideable_type = 'electric_bike' -- Use the exact string from Step 1
GROUP BY rideable_type, member_casual;--- member = 7,259,992, casual = 2399741

SELECt rideable_type, member_casual,
COUNT(*) as total_rides
FROM combined_baywheels cb 
WHERE cb.rideable_type = "electric_scooter"; --- 8 casual riders 

SELECT rideable_type, member_casual , COUNT (*) AS total_rides
FROM combined_baywheels cb 
WHERE cb.rideable_type = "classic_bike"
GROUP BY rideable_type, member_casual ;
--- 718,781 casual riders utulize class bike and 2212678 member utulize class bike 

