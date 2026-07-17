# Lyft Bikshare User Analysis 
### Utitlize Python, SQL and Tableau to analyze and present fidnings
### By : Lily (Thu) Lam

## Business Case & Objective 
The goal of this project is to analyze Lyft Bay Wheels data from 2023 to 2026 to diagnose seasonal demand trends across different user types, evaluate supply imbalances, and quantify overall system growth. By building a short-term demand forecast, this analysis will deliver actionable, data-driven operational recommendations for fleet rebalancing and station capacity planning.

## Goals and Questions 
Goal 1: Fleet Distribution & Ridership Trends

Optimize vehicle availability by mapping out geographic and temporal demand across the network.

    Q1.1: What are the top 10 most popular start stations across the Bay Wheels network?
  
    Q1.2: What are the peak demand hours throughout the week, and how do they shift between weekdays and weekends?

    Q1.3: How has annual ridership volume grown or shifted between 2023, 2024, 2025, and 2026?

    Q1.4: What does the month-over-month ridership curve look like, and when do the sharpest seasonal drops occur?

Goal 2: Operational Downtime & Imbalance 

MitigationMinimize critical system bottlenecks by identifying when and where stations run out of bikes or open docks.

    Q2.1: Which specific stations experience the highest frequency of net-negative trip imbalances (more departures than arrivals) during morning commute hours?

    Q2.2: What is the average duration a high-traffic station remains in a critical imbalance state before naturally resetting or being manually rebalanced?

Goal 3: Targeted User Experience & Segmentation

Tailor system services and infrastructure to meet the distinct habits of casual riders versus subscribers.

    Q3.1: How does the weekly usage distribution (ride counts and peak hours) differ between Subscribers (Members) and Customers (Casual riders)?

    Q3.2: What is the variance in average trip duration and choice of vehicle type (classic bike, electric bike, scooter) between the two user segments?

Goal 4: Station Accumulation & Capacity 

MappingIdentify popular "sink" stations where bikes pile up over time, risking overcapacity.

    Q4.1: What are the top 10 most popular end stations where trips consistently terminate?

    Q4.2: Which stations show a multi-year trend of net-positive accumulation, signaling a need for physical dock expansion?

Goal 5: Proactive Resource & Labor Planning

Shift operations from reactive troubleshooting to proactive scheduling using predictive analytics.

    Q5.1: What is the system-wide baseline ridership forecast for the next 90 days?

    Q5.2: What are the expected upper and lower confidence intervals for daily ridership, factoring in seasonal trends and holidays?


## Executive Summary
## Key Insights 
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
