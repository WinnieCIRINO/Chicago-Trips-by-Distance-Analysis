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


/* Handling Missing Values or Columns with NULL*/
-- Let us identify missing values.

SELECT * FROM Combined_Trips_by_Distance
WHERE Month IS NULL

/* Alternatively*/
SELECT 
SUM(CASE WHEN Level IS NULL THEN 1 ELSE 0 END) AS NullCount_Level,
SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS NullCount_Date,
SUM(CASE WHEN State_FIPS IS NULL THEN 1 ELSE 0 END) AS NullCount_State_FIPS,
SUM(CASE WHEN State_Postal_Code IS NULL THEN 1 ELSE 0 END) AS NullCount_State_Postal_Code,
SUM(CASE WHEN County_FIPS IS NULL THEN 1 ELSE 0 END) AS NullCount_County_FIPS,
SUM(CASE WHEN County_Name IS NULL THEN 1 ELSE 0 END) AS NullCount_County_Name,
SUM(CASE WHEN Population_Staying_at_Home IS NULL THEN 1 ELSE 0 END) AS NullCount_Population_StayingHome,
SUM(CASE WHEN Population_Not_Staying_at_Home IS NULL THEN 1 ELSE 0 END) AS NullCount_Population_Not_Staying_at_Home,
SUM(CASE WHEN Number_of_Trips IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips,
SUM(CASE WHEN Number_of_Trips_1 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_1,
SUM(CASE WHEN Number_of_Trips_1_3 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_1_3,
SUM(CASE WHEN Number_of_Trips_5_10 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_5_10,
SUM(CASE WHEN Number_of_Trips_10_25 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_10_25,
SUM(CASE WHEN Number_of_Trips_25_50 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_25_50,
SUM(CASE WHEN Number_of_Trips_50_100 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_50_100,
SUM(CASE WHEN Number_of_Trips_100_250 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_100_250,
SUM(CASE WHEN Number_of_Trips_250_500 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_250_500,
SUM(CASE WHEN Number_of_Trips_500 IS NULL THEN 1 ELSE 0 END) AS NullCount_Number_of_Trips_500,
SUM(CASE WHEN Row_ID IS NULL THEN 1 ELSE 0 END) AS Row_ID,
SUM(CASE WHEN Week IS NULL THEN 1 ELSE 0 END) AS NullCount_Week,
SUM(CASE WHEN Month IS NULL THEN 1 ELSE 0 END) AS NullCount_Month
FROM Combined_Trips_by_Distance;

# Data Quality Assessment 
- The following data quality issues were identified.
  Null Values: Empty cells were observed in some columns including:
-State_FIPS
-State_Postal_Code
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

** Created a new table, "Trips_Prep" **
/*Replaced the missing values */
  
  SELECT Level
	, DATENAME(MONTH, Date) AS Months
	, [Month]
	, [Week]
	, DATENAME(WEEKDAY, Date) AS Day_name
    , CASE
      WHEN DATENAME(WEEKDAY, Date) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Weekday'
      WHEN DATENAME(WEEKDAY, Date) IN ('Saturday', 'Sunday') THEN 'Weekend'
      ELSE 'NA' 
	   END AS 'Weekday_Weekend'
	, ISNULL(State_FIPS, 0) AS State_FIPS_Full
	, ISNULL(State_Postal_Code, 'Unknown') AS State_Postal_Code_Full
	, ISNULL(County_FIPS, 0) AS County_FIPS_Full
	, ISNULL(County_Name, 'NA') AS County_Name_Full
	, ISNULL(Population_Staying_at_Home, 0) AS Population_Staying_Home_Full
	, ISNULL(Population_Not_Staying_at_Home, 0) AS Population_Not_Staying_Home_Full
	, CASE
			WHEN MONTH IN (12,1,2) THEN 'Winter'
			WHEN MONTH IN (3,4,5) THEN 'Spring'
			WHEN MONTH IN (6,7,8) THEN 'Summer'
			WHEN MONTH IN (9,10,11) THEN 'Fall'
			ELSE 'NA'
		END AS 'Seasons'
	, Number_of_Trips
    ,[Number_of_Trips_1] AS 'Trips < 1 mile'
    ,[Number_of_Trips_1_3] AS 'Trips 1-3 miles'
    ,[Number_of_Trips_3_5] AS 'Trips 3-5 miles'
    ,[Number_of_Trips_5_10] AS 'Trips 5-10 miles'
    ,[Number_of_Trips_10_25] AS 'Trips 10-25 miles'
   ,[Number_of_Trips_25_50] AS 'Trips 25-50 miles'
   ,[Number_of_Trips_50_100] AS 'Trips 50-100 miles'
   ,Number_of_Trips_100_250 AS 'Trips 100-250 miles'
   ,[Number_of_Trips_250_500] AS 'Trips 250-500 miles'
   ,[Number_of_Trips_500] AS 'Trips >= 500 miles'
   ,[Row_ID]
INTO Trips_Prep
FROM Combined_Trips_by_Distance
   WHERE Number_of_trips IS NOT NULL;
	
