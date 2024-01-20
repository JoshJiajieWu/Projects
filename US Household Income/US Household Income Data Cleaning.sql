SELECT *
FROM us_household_income;

SELECT * FROM us_household_income_statistics;

SELECT id,COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id)>1;

#Finding duplicates in the data set
SELECT * 
	FROM(
		SELECT row_id, id, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
		FROM us_household_income
	) as duplicates
    WHERE row_num > 1
    ;
    
SELECT * 
	FROM(
		SELECT id, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
		FROM us_household_income_statistics
	) as duplicates
    WHERE row_num > 1
    ;
    
#Deleting duplicates from the data set
DELETE FROM us_household_income
WHERE row_id IN(
SELECT row_id
	FROM(
		SELECT row_id, id, ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as row_num
		FROM us_household_income
	) as duplicates
        WHERE row_num > 1);

#Updated missing 'place' with surround counties and cities        
UPDATE us_household_income
SET Place = 'Autaugaville'
Where County = 'Autauga County'
AND City = 'Vinemont';

#Find and replace mistyped 'Type' of district
SELECT Type, count(Type)
FROM us_household_income
GROUP BY Type;

UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs';

UPDATE us_household_income
SET Type = 'CDP'
WHERE Type = 'CPD';

#Checking to make sure at least one of land or water had data
SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 or AWater = '' or AWater IS NULL)
AND (ALAND = 0 or ALAND = '' or ALAND IS NULL);