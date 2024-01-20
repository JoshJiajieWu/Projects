# Data Analysis

SElECT * FROM us_household_income;

SELECT * FROM us_household_income_statistics;

# Found the Top 10 Area's of Land by State
SELECT State_Name,SUM(ALand),SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(ALand)DESC
LIMIT 10;

# Found the Top 10 Area's of Water by State
SELECT State_Name,SUM(ALand),SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY SUM(AWater)DESC
LIMIT 10;


# Found the 10 highest states with average mean of income. Filtered out the mean's with 0 as those counties did not report their data
SELECT hi.State_Name, ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
WHERE Mean != 0
GROUP BY hi.State_Name
ORDER BY ROUND(AVG(Mean),2) DESC
LIMIT 10;

# Found the 10 lowest states with average mean of income. Filtered out the mean's with 0 as those counties did not report their data
SELECT hi.State_Name, ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
WHERE Mean != 0
GROUP BY hi.State_Name
ORDER BY ROUND(AVG(Mean),2)
LIMIT 10;

# Found the 10 highest states with average Median of income. Filtered out the medians's with 0 as those counties did not report their data
SELECT hi.State_Name, ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
WHERE Median != 0
GROUP BY hi.State_Name
ORDER BY ROUND(AVG(Median),2) DESC
LIMIT 10;

# Found the 10 Lowest states with average Median of income. Filtered out the medians's with 0 as those counties did not report their data
SELECT hi.State_Name, ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
WHERE Median != 0
GROUP BY hi.State_Name
ORDER BY ROUND(AVG(Median),2)
LIMIT 10;

# Found the average of the income depending on the type of district they are living in. Filtered out the ones that reported no data. Highest was Muncipality but only had one source of data for that.
SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
WHERE Mean != 0
GROUP BY Type
ORDER BY ROUND(AVG(Mean),2) DESC;

# Found the median of the income depending on the type of district they are living in. Filtered out the ones that reported no data.
SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),2), ROUND(AVG(Median),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
WHERE Mean != 0
GROUP BY Type
ORDER BY ROUND(AVG(Median),2) DESC;

#Noticed that the community 'Type' was very low. Found that they are all from Puerto Rico
SELECT *
FROM us_household_income
WHERE Type = 'Community';

# Looked at the highest average cities based on income. 
SELECT hi.State_Name, City, ROUND(AVG(Mean),2)
FROM us_household_income hi
INNER JOIN us_household_income_statistics his
ON hi.id = his.id
GROUP BY hi.State_Name, City
ORDER BY ROUND(AVG(Mean),2) DESC;


