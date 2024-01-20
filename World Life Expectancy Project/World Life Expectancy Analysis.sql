# Data analysis 

SELECT * 
FROM world_life_expectancy;

# Last 15 years of life expectancy and to see who has had the biggest change. A lot of low life expectancy countries had a big increase over the years. 
# This seems to be case because they started out with such a low life expectancy like Haiti, which had a 36.3 minimum life expectancy and ended with a maximum of 65 causing Haiti to have the biggest change of life expectancy.
SELECT Country, 
MIN(`Life expectancy`), 
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`)-MIN(`Life expectancy`),1) AS life_changes
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) != 0
AND MAX(`Life expectancy`) != 0
ORDER BY life_changes DESC;

# Averaged out the life expectancy of every country from 2007-2022.There was a steady increase every year as 2007 had a life expectancy of 66.75 and 2022 had a life expectancy of 71.62
SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
WHERE `Life expectancy` != 0
AND `Life expectancy` != 0
GROUP BY Year
ORDER BY Year;

# Looked at the life expectancy vs the GDP. With 1326 countries over 1500 GDP having a 74.2 life expectancy and 1612 countries less than 1500 GDP having 64.7 GDP.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp != 0
AND
GDP != 0
ORDER BY GDP DESC;

SELECT 
	SUM(CASE WHEN GDP >= 1500 THEN 1
    ELSE 0 END) as High_GDP_Count,
    ROUND(AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy`
    ELSE NULL END),1) as High_Life_Expectancy_GDP,
    SUM(CASE WHEN GDP <= 1500 THEN 1
    ELSE 0 END) as Low_GDP_Count,
	ROUND(AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy`
    ELSE NULL END),1) as Low_Life_Expectancy_GDP
FROM world_life_expectancy;

# Looked at life expectancy for a country that is developed vs developing. With developed countries having a 79.2 life expectancy vs a 66.8 for developing. 
# Sample size of developed is a lot smaller as there was only 32 countries with that label and 161 having the developing label.
SELECT Status,COUNT(DISTINCT Country),Round(AVG(`Life expectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

# Looked at life expectancy vs BMI. Saw that countries with above a 50 BMI had a life expectancy of around 70 or higher. Could be the case because there's more food available to eat for those countries.
SELECT Country, ROUND(AVG(`Life expectancy`),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM world_life_expectancy
GROUP BY country
HAVING Life_Exp != 0
AND
BMI != 0
ORDER BY BMI DESC;

# Looked at the countries that contained 'United' to see the rolling total of their adult mortalities. Found that United States, United Kingdom and United Arab Emirates were all pretty low compared to United Republic of Tanzania with around a rolling total of 1000 vs 5000. 
# The smaller life expectancy of Tanzania vs the higher ones of the other 'United' countries seems to be a factor.
SELECT Country, Year, `Life expectancy`, `Adult Mortality`, 
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;

