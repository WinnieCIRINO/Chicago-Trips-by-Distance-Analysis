-- **Data Cleaning**
-- We shall clean the data aiming at identifying issues that could affect the quality of the data. Issues such as duplicates, null or missing values, and unstandardized datatypes. 
-- This is to help create a suitable and reliable data for analysis. 

/* Let's confirm that the column "Number_of_Trips" is the same as the sum of the trips per record.*/

SELECT 
Number_of_Trips
,Number_of_Trips_1 + Number_of_Trips_1_3 + 
Number_of_Trips_10_25 + Number_of_Trips_100_250 + 
Number_of_Trips_25_50 + Number_of_Trips_250_500 +
Number_of_Trips_3_5 + Number_of_Trips_5_10 + Number_of_Trips_50_100 + Number_of_Trips_500 AS Total_Trips
FROM Trips_Combined;

/* Confirm the columns with NULL or missing values.*/

SELECT * FROM Combined_Trips_by_Distance
WHERE Level IS NULL

# Data Quality Assessment 
- The following data quality issues were identified.
  Null Values: Empty cells were observed in some columns including:
-State_FIPS
-State Postal Code
-County_FIPS
-County_Name
-Population_staying_at_home
-Population_not_staying_at_home
-Number_of_Trips
-Number_of_Trips_1
-Number_of_Trips_1_3
-Number_of_Trips_3_5
-Number_of_Trips_5_10
-Number_of_Trips_10_25
-Number_of_Trips_25_50
-Number_of_Trips_50_100
-Number_of_Trips_100_250
-Number_of_Trips_250_500
-Number_of_Trips_500
