-- Continuing with SQL
SELECT Species, COUNT(*) AS Nest_count
FROM Bird_nests
WHERE Site = 'nome'
GROUP BY Species
HAVING Nest_count > 10
ORDER BY Species
LIMIT 2;

-- We can nest queries!
SELECT Scientific_name, Nest_count FROM(
    SELECT Species, COUNT(*) AS Nest_count
    FROM Bird_nests
    WHERE Site = 'nome'
    GROUP BY Species
    HAVING Nest_count > 10
    ORDER BY Species
    LIMIT 2) JOIN Species
    ON Species = Code;

-- Outer joins
CREATE TEMP TABLE a (
    cola INTEGER,
    common INTEGER
);
INSERT INTO a VALUES (1, 1), (2, 2), (3, 3);
SELECT * FROM a;

CREATE TEMP TABLE b (
    colb INTEGER,
    common INTEGER
);
INSERT INTO b VALUES (2, 2), (3, 3), (4, 4), (5, 5);
SELECT * FROM b;

-- The joins we've been doing so far have been "inner" joins
SELECT * FROM a JOIN b USING (common);
SELECT * FROM a JOIN b ON a.common = b.common;

-- By doing an outer join, either left or right, we'll add certain missing rows
SELECT * FROM a LEFT JOIN b ON a.common = b.common;

-- a running example, what speces do NOT have any nest data
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Species) FROM Bird_nests;
-- Method 1
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);
SELECT Code FROM Species
    WHERE Code NOT IN (SELECT Species FROM Bird_nests);
-- Does this give the same answer? Yes?? 

-- Method 2
SELECT * FROM Species LEFT JOIN Bird_nests
    ON Code = Species
    WHERE Species IS NULL;

-- It's also possible to join a table with itself (self join)

-- Understanding a limitation of duckdb
SELECT Nest_ID, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;