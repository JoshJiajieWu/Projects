# Date Cleaning

# Removed Duplicates by combing country with their year and counting if any had more than 1
SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country,Year)
HAVING COUNT(CONCAT(Country, Year)) > 1;

SELECT*
FROM(
	SELECT Row_ID,
	CONCAT(Country,Year),
	row_number() OVER(PARTITION BY CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) as Row_Num
	FROM world_life_expectancy
    ) AS Row_table
    WHERE Row_Num > 1;

DELETE FROM world_life_expectancy
WHERE
	Row_ID IN (
    SELECT Row_ID
FROM(
	SELECT Row_ID,
	CONCAT(Country,Year),
	row_number() OVER(PARTITION BY CONCAT(Country,Year) ORDER BY CONCAT(Country,Year)) as Row_Num
	FROM world_life_expectancy
    ) AS Row_table
    WHERE Row_Num > 1
    );

# Filled out the status of some missing data by looking at the status of those countries in the surrounding years.    
SELECT * FROM world_life_expectancy
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status = 'Developing';

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1. Status =''
AND t2.Status != ''
AND t2.Status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1. Status =''
AND t2.Status != ''
AND t2.Status = 'Developed'
;

# Filled out the life expectancy of some missing countries by getting their average of the following and previous year
SELECT * FROM world_life_expectancy
WHERE STATUS = '';

SELECT * FROM world_life_expectancy
WHERE `Life expectancy` = '';

SELECT t1.Country, t1.Year, t1.`Life expectancy`, t2.`Life expectancy`,t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`)/2,1)
WHERE t1.`Life expectancy` = ''
;

SELECT * FROM world_life_expectancy
WHERE STATUS = '';

SELECT * FROM world_life_expectancy
;