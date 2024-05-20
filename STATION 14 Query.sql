# Query the greatest value of the Northern Latitudes (LAT_N) from STATION that is less than 137. 2345Truncate your answer to 4 decimal place.

 SELECT TRUNCATE(MAX(LAT_N), 4) AS Greatest_Latitude
FROM STATION
WHERE LAT_N < 137.2345;

# Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N) in STATION that is less than 137.2345 Round your answer to 4 decimal places.

SELECT ROUND(LONG_W, 4) AS Rounded_Longitude
FROM STATION
WHERE LAT_N = (
    SELECT MAX(LAT_N)
    FROM STATION
    WHERE LAT_N < 137.2345
);


# Query the smallest Northern Latitude (LAT_N) from STATION that is greater than 38.7880 Round your answer to 4 decimal places.

SELECT ROUND(MIN(LAT_N), 4) AS Smallest_Latitude
FROM STATION
WHERE LAT_N > 38.7880;


# Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38. 7880 Round your answer to 4 decimal places.

SELECT ROUND(LONG_W, 4) AS Rounded_Longitude
FROM STATION
WHERE LAT_N = (
    SELECT MIN(LAT_N)
    FROM STATION
    WHERE LAT_N > 38.7880
);

# Consider P1(a, b) and P2(a, b) to be two points on a 2D plane.

#a happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
#b happens to equal the minimum value in Western Longitude (LONG_W in STATION).
#c happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
#d happens to equal the maximum value in Western Longitude (LONG_W in STATION).
# Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.


SELECT ROUND(
    ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)),
    4
) AS Manhattan_Distance
FROM STATION;

# Consider P1(a, c) and P2(b, d) to be two points on a 2D plane where (a, b) are the respective minimum and maximum values of Northern Latitude (LAT_N) and (c, d) are the respective minimum and maximum values of Western Longitude (LONG_W) in STATION.

Query the Euclidean Distance between points P1 and P2  and format your answer to display  4 decimal digits.

SELECT ROUND(
    SQRT(
        POW((MAX(LAT_N) - MIN(LAT_N)), 2) + POW((MAX(LONG_W) - MIN(LONG_W)), 2)
    ),
    4
) AS Euclidean_Distance
FROM STATION;



# A median is defined as a number separating the higher half of a data set from the lower half. 
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.


WITH OrderedLatitudes AS (
    SELECT LAT_N,
           ROW_NUMBER() OVER (ORDER BY LAT_N) AS RowAsc,
           ROW_NUMBER() OVER (ORDER BY LAT_N DESC) AS RowDesc
    FROM STATION
),
MedianCalculation AS (
    SELECT LAT_N
    FROM OrderedLatitudes
    WHERE RowAsc = RowDesc
       OR RowAsc + 1 = RowDesc
)
SELECT ROUND(AVG(LAT_N), 4) AS Median_Latitude
FROM MedianCalculation;

# You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. 
It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.



SELECT Start_Date, min(End_Date)
FROM 
 (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a ,
 (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b
WHERE Start_Date < End_Date
GROUP BY Start_Date
ORDER BY DATEDIFF(min(End_Date), Start_Date) ASC, Start_Date ASC;


# You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. 
Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).


SELECT S.Name
FROM Students S
JOIN Friends F ON S.ID = F.ID
JOIN Packages P1 ON S.ID = P1.ID
JOIN Packages P2 ON F.Friend_ID = P2.ID
WHERE P2.Salary > P1.Salary
ORDER BY P2.Salary;




