-- I created a new table called "Trips_combined", to merge that data from the multiple years into a single data set. (2019 to 2023)
-- Using SELECT, INTO and UNION ALL

/*Data Commbination*/

SELECT * INTO Trips_Combined
FROM Trips_by_Distance2019

UNION ALL
SELECT * FROM [Trips_by_Distance 2020]

UNION ALL 
SELECT * FROM [Trips_by_Distance2021]

UNION ALL
SELECT * FROM [Trips_by_Distance 2022]

UNION ALL
SELECT * FROM [Trips_by_Distance 2023]
