SELECT * INTO Combined_Trips_by_Distance
FROM Trips_by_Distance2019

UNION ALL
SELECT * FROM [Trips_by_Distance 2020]

UNION ALL 
SELECT * FROM [Trips_by_Distance2021]

UNION ALL
SELECT * FROM [Trips_by_Distance 2022]

UNION ALL
SELECT * FROM [Trips_by_Distance 2023]


SELECT * FROM Combined_Trips_by_Distance

/* Confirm that the column "Number_of_Trips" is the same as the sum of the trips per record.*/

SELECT 
Number_of_Trips
,Number_of_Trips_1 + Number_of_Trips_1_3 + 
Number_of_Trips_10_25 + Number_of_Trips_100_250 + 
Number_of_Trips_25_50 + Number_of_Trips_250_500 +
Number_of_Trips_3_5 + Number_of_Trips_5_10 + Number_of_Trips_50_100 + Number_of_Trips_500 AS Total_Trips
FROM Combined_Trips_by_Distance;


/* Confirm the columns with NULL or missing values.*/
SELECT * FROM Combined_Trips_by_Distance
WHERE State_FIPS IS NULL

/*  An alternative way of confirming columns with NULL values . */
SELECT 
    SUM(CASE WHEN Level IS NULL THEN 1 ELSE 0 END) AS NullCount_Level,
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS NullCount_Date,
    SUM(CASE WHEN State_FIPS IS NULL THEN 1 ELSE 0 END) AS NullCount_State_FIPS,
	SUM(CASE WHEN State_Postal_Code IS NULL THEN 1 ELSE 0 END) AS NullState_Postal_Code,
    SUM(CASE WHEN County_FIPS IS NULL THEN 1 ELSE 0 END) AS NullCounty_FIPS,
    SUM(CASE WHEN County_Name IS NULL THEN 1 ELSE 0 END) AS NullCounty_Name,
	 SUM(CASE WHEN Population_Staying_at_Home IS NULL THEN 1 ELSE 0 END) AS NullPopulation_Staying_at_Home,
	SUM(CASE WHEN Population_Not_Staying_at_Home IS NULL THEN 1 ELSE 0 END) AS NullPopulation_Not_Staying_at_Home
FROM Combined_Trips_by_Distance;

/* Let's replace the NULL values, and create a new table where Number of trips is not NULL */
SELECT
	Level,
-- Date
	DATENAME(WEEKDAY, Date) AS Weekday,
	DATENAME(MONTH, Date) AS Month,
	DATENAME(YEAR, Date) AS Year,
--Weekend/Weekday
	CASE	
		WHEN DATENAME(WEEKDAY, Date) IN ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') THEN 'Weekday'
		WHEN DATENAME(WEEKDAY, Date) IN ('Saturday', 'Sunday') THEN 'Weekend'
		ELSE 'NA'
	END AS 'Weekday_Weekend',
--Seasons
	CASE
		WHEN MONTH IN (12,1,2) THEN 'Winter'
		WHEN MONTH IN (3,4,5) THEN 'Spring'
		WHEN MONTH IN (6,7,8) THEN 'Summer'
		WHEN MONTH IN (9,10,11) THEN 'Fall'
		ELSE 'NA'
	END AS Seasons,
--State_FIPS
	ISNULL(State_FIPS, 0) AS State_FIPS_Full,
--State_Postal_Code
	ISNULL(State_Postal_Code, 'Unknown') AS State_Postal_Code_Full,
--County_FIPS
	ISNULL(County_FIPS, 0) AS County_FIPS_Full,
--County_Name
	ISNULL(County_Name, 'NA') AS County_Name_Full
	  ,[Number_of_Trips]
      ,[Number_of_Trips_1]
      ,[Number_of_Trips_1_3]
      ,[Number_of_Trips_3_5]
      ,[Number_of_Trips_5_10]
      ,[Number_of_Trips_10_25]
      ,[Number_of_Trips_25_50]
      ,[Number_of_Trips_50_100]
      ,[Number_of_Trips_100_250]
      ,[Number_of_Trips_250_500]
      ,[Number_of_Trips_500]
      ,[Row_ID]
      ,[Week]
INTO Trips_by_Distance_Prep
FROM Combined_Trips_by_Distance
-- Consider where there are trips only
	WHERE Number_of_Trips IS NOT NULL

	
SELECT *
FROM Trips_by_Distance_Prep



