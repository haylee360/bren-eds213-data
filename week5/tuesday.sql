-- Exporting data from a database

-- The whole database
-- creates folder and dumps tables as separate csv files. Also saves schema. Writes script to reload data in database. Only a duckdb thing.
EXPORT DATABASE 'export_adsn';

-- One table
COPY Species to 'species_test.csv' (HEADER, DELIMITER ',');

-- Specific query
COPY (SELECT COUNT(*) FROM Species) TO 'species_count.csv' (HEADER, DELIMITER ',');

-- Exploring why scientific name isn't correct
SELECT * FROM Species LIMIT 3;
SELECT COUNT(*) FROM Species;
SELECT COUNT(DISTINCT Scientific_name) FROM Species;
SELECT Scientific_name, COUNT(*) AS Num_name_occurences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurences > 1;

CREATE TEMP TABLE t AS (
    SELECT Scientific_name, COUNT(*) AS Num_name_occurences
    FROM Species
    GROUP BY Scientific_name
    HAVING Num_name_occurences > 1
);

SELECT * FROM t;
SELECT * FROM Species s JOIN t
    ON s.Scientific_name = t.Scientific_name
    -- or join where they're both null
    OR (s.Scientific_name IS NULL AND t.Scientific_name IS NULL);
-- One place it's called bewick's swan, another place the tundra swan!
-- unidentified falcon, unidentified raptor: no scientific name. 
-- This is why you can't group by sci name. Needs to be species code. 

-- inserting data
-- this is a fragile statement because it's assuming this is the order of the columns. 
INSERT INTO Species VALUES ('abcd', 'thing', 'scientific_name', NULL);
SELECT * FROM Species;
-- you can explicitly label columns
INSERT INTO Species
    (Common_name, Scientific_name, Code, Relevance)
    VALUES
    ('thing2', 'another sci name', 'efgh', NULL);
SELECT * FROM Species;

-- can take advantage of default values
-- Can say default value for relevance is 'study species' or whatever
INSERT INTO Species
    (Common_name, Code)
    VALUES
    ('thing 3', 'ijkl');
SELECT * FROM Species;

-- UPDATEs and DELETEs will demolish the entire table unless limited by a WHERE clause
DELETE FROM Bird_eggs WHERE Nest_ID...

-- strategies to save yourself
-- doing a SELECT first
SELECT * FROM Bird_eggs WHERE Nest_ID LIKE 'z%';
-- then change select * from to delete from

-- create a copy of hte table
CREATE TABLE nest_temp AS (SELECT * FROM Bird_nests);
DELETE FROM nest_temp WHERE Site = 'chur';
-- other ideas
xDELETE FROM ... WHERE ...;
