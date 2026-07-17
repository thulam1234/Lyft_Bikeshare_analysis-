# Lyft Bikshare User Analysis 
### Utitlize Python, SQL and Tableau to analyze and present fidnings
### By : Lily (Thu) Lam

## Business Case & Objective 
Analyze Lyft BayWheel data from 2023 to 2026 to diagnose demands throughout the year from different user types, supply imbalances quantify system growth, and build short term forecast, which will help operational recommendations for bike rebalancing, and station capacity planning. 

## Goals
1. Identify how ridership varies throughout the years and by station.
2. Determine the frequency and severity of station-level imbalances. 
3. Measure demand based on member type. 
4. Analyze the docking pattern to identify popular docking stations where bikes accumulate over time. 
5. Forecast system-wide total rides using time series forecasting to predict demand for the next 90 days.

## Executive Summary
##Key Insights 
## Data Source & Data Dictionary 
Each trip is anonymized and includes:

Trip Duration (seconds): This represents the total time taken by the user to begin and end their trip, expressed in seconds. 

Start Time and Date:The date and time when the user began their trip.

End Time and Date: The date and time when the user ended their trip. 

Start Station ID:the starting point for the trip 

Start Station Name: The name of the location where the trip begins. 

Start Station Latitude:  The latitude of the starting location 

Start Station Longitude: The longitude of the end location 

End Station ID: A unique identifier for the terminal. 

End Station Name: The name of the station where the user parks their bicycle. 

End Station Latitude:Latitude of the end  station 

End Station Longitude: Longtitude of the end station 

Rideable Type: The type of ride users use for their trip (electric bike, classic bike and electric scooter )

Ride ID: A unique identifier for each ride recorded in this dataset. 

User Type (Subscriber or Customer – “Subscriber” = Member or “Customer” = Casual):  This indicates whether the user is a member or a casual customer.  

## Analytical Workflow 
## Repository Structure 
