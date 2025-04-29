-- Week 4 - Missing data
-- Haylee Oyler
-- Which sites have no egg data?

-- Method 1
SELECT Code FROM Site
    WHERE Code NOT IN (SELECT Site FROM Bird_eggs)
    ORDER BY Code ASC;

-- Method 2
SELECT Code FROM Site LEFT JOIN Bird_eggs
    ON Code = Site
    WHERE Site IS NULL
    ORDER BY Code ASC;

-- Method 3
SELECT Code FROM Site
EXCEPT
SELECT DISTINCT Site FROM Bird_eggs
ORDER BY Code ASC;