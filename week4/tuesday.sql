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

-- Let's add in the observer
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;
-- This throws a group by error for observer
-- we grouped by nest id which is the primary key
-- There can only be one value for observer because! nest id is the primary key
-- Other database systems are smart enough to recognize that, but not duckdb

SELECT * FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%';

-- DuckDB solution #1
SELECT Nest_ID, Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID, Observer;

-- DuckDB solution #2
SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;
-- pick any value for observer (because they're all the same)

-- Views: a virtual table
CREATE VIEW my_nests AS 
    SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;

.tables
SELECT * FROM my_nests;
SELECT Nest_ID, Name, Num_eggs
    FROM my_nests JOIN Personnel
    ON Observer = Abbreviation;

-- view
-- temp table
-- What's the difference?
CREATE TEMP TABLE my_nests_temp_table AS 
    SELECT Nest_ID, ANY_VALUE(Observer) AS Observer, COUNT(*) AS Num_eggs
    FROM Bird_nests JOIN Bird_eggs
    USING (Nest_ID)
    WHERE Nest_ID LIKE '13B%'
    GROUP BY Nest_ID;
.table

-- temp table: the database actually constructs the table. 
-- A view is always virtual. Executed dynamically everyone it gets called? Or when the source tables get changed. So if you change a table it's based on, the view will update. A temp table won't, it's more static. 

-- What about modifications (updates, inserts, deletes) on a view? possible?
-- it depends on how smart the datbase is, also whether it's theoretically possible. 

-- Last topic: set operations
-- UNION, UNION ALL, INTERSECT, EXCEPT
-- UNION removes duplicates, union all wont. intersect and except are like set differences
-- Mathematically, a table is a set of tuples. 

SELECT * FROM Bird_eggs LIMIT 5;


SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length*25.4 AS LENGTH, Width*25.4 AS Width
    FROM Bird_eggs
    WHERE Book_page LIKE 'b14%'
UNION
SELECT Book_page, Year, Site, Nest_ID, Egg_num, Length, Width
    FROM Bird_eggs
    WHERE Book_page NOT LIKE 'b14%';

-- Method 3 for running example
-- What species aren't in bird nest table
SELECT Code FROM Species
EXCEPT
SELECT DISTINCT Species FROM Bird_nests;