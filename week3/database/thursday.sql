-- From last time, wound up:
SELECT DISTINCT Location
FROM Site
ORDER BY Location ASC
LIMIT 3;

-- Filtering 
SELECT * FROM Site WHERE Area < 200;
-- Can be arbitrary expressions
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60;
-- Not equa, classic operator is <>, but nowadays most databases support !=
SELECT * FROM Site WHERE Location <> 'Alaska, USA';
-- LIKE for string matching, uses % as wildcard character (not *)
SELECT * FROM Site WHERE Location LIKE '%Canada';
-- Any site that ends in Canada
-- Is this case sensitive matchin or not? Depends on the batabase 
SELECT * FROM Site WHERE Location LIKE '%canada';
-- LIKE is primitive matching, but nowadays everyone supports regex
-- Common pattern databases provide tons of functions
-- Regex for selecting any location that has 'west' in it
SELECT * FROM Site WHERE regexp_matches(Location, '.*west.*');

-- Select expression; i.e. you can do computation
SELECT Site_name, Area FROM Site;
Select Site_name, Area * 2.47 FROM Site;
-- convert to acres
SELECT Site_name, Area * 2.47 AS Area_acres FROM Site;
-- Can rename the column!
-- You can use your database as a calculator
SELECT 2 + 2;

-- String concatenation operator: classic one is ||, others via functions
SELECT Site_name || 'in' || Location FROM Site;
-- Aggregation and grouping
SELECT COUNT(*) FROM Species; -- 99
-- ^^ * means number of rows
SELECT COUNT(Scientific_name) FROM Species; --97
-- We lost two rows because there are two null values in scientific name column
-- ^^ Counts the number of non-null values 

-- Can also count # of distinct values
SELECT DISTINCT Relevance FROM Species;
SELECT COUNT(DISTINCT Relevance) FROM Species; -- 7


-- Moving on to arithmetic operations
SELECT AVG(Area) FROM Site;
SELECT AVG(Area) FROM Site WHERE Location LIKE '%Alaska%';
-- Min max
-- Quiz: what happens when you do this?
-- Suppose we want the largest site and its name
SELECT Site_name, MAX(Area) FROM Site;
-- Introduction to grouping
SELECT Location, MAX(AREA) FROM Site GROUP BY Location;
-- Group rows by location, then give me max area for the rows within that group. 
SELECT Location,
    COUNT(*),
    MAX(Area)
FROM Site
GROUP BY Location;
-- Can also see how many sites are in each location
SELECT Location,
    COUNT(*),
    MAX(Area)
FROM Site
WHERE Location LIKE '%Canada'
GROUP BY Location;
-- Only wanted to look at canadian locations


-- A WHERE clause limits the rows that are going into the expression at the beginning
-- a HAVING clause filters the groups 
SELECT Location,
    COUNT(*) AS Count,
    MAX(Area) AS Max_area
FROM Site
WHERE Location LIKE '%Canada'
GROUP BY Location
HAVING Count > 1;
-- Picks up just the group has more than one site

-- NULL processing
-- NULL indicates the absence of data in a table
-- But in an expression, it means unknown
SELECT COUNT(*) FROM Bird_nests;
-- Number of rows in bird nests, 1547
SELECT COUNT(*) FROM Bird_nests WHERE floatAge > 5; --70
SELECT COUNT(*) FROM Bird_nests WHERE floatAge <= 5; --97
-- We have a lot of NAs

-- How can we find out which rows are null?
SELECT COUNT(*) FROM Bird_nests WHERE floatAge = NULL;
-- The only way to find null values:
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NULL;
SELECT COUNT(*) FROM Bird_nests WHERE floatAge IS NOT NULL;

-- Joins
SELECT * FROM Camp_assignment LIMIT 10;
SELECT * FROM Personnel;
SELECT * FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation
    LIMIT 10;