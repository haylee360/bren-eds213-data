-- Week 5 - Create a trigger
-- Haylee Oyler

-- Part 1 
.mode table
.nullvalue -NULL-

CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        UPDATE Bird_eggs
        SET Egg_num = (
            SELECT IFNULL(MAX(Egg_num), 0) + 1
            FROM Bird_eggs
            WHERE Nest_ID = new.Nest_ID AND Egg_num IS NOT NULL
        )
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
    END;

-- Test out trigger by inserting new data
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.7', 2015, 'eaba', '14eabaage01', 12.34, 56.78);

SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01' ORDER BY Egg_num DESC;

-- Also check for a new nest_ID
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.6', 2014, 'eaba', 'test_id', 12.34, 56.78);

SELECT * FROM Bird_eggs WHERE Nest_ID = 'test_id'; 


-- Part 2
DROP TRIGGER egg_filler;

-- Create trigger for additional columns
CREATE TRIGGER egg_filler
    AFTER INSERT ON Bird_eggs
    FOR EACH ROW
    BEGIN
        -- Egg_num
        UPDATE Bird_eggs
        SET Egg_num = (
            SELECT IFNULL (MAX(Egg_num), 0) + 1 
            FROM Bird_eggs
            WHERE Nest_ID = new.Nest_ID AND Egg_num IS NOT NULL)
        WHERE Nest_ID = new.Nest_ID AND Egg_num IS NULL;
        -- Book_page
        UPDATE Bird_eggs
        SET Book_page = (
            SELECT Book_page
            FROM Bird_nests
            WHERE Nest_ID = NEW.Nest_ID) 
        WHERE Nest_ID = NEW.Nest_ID AND Book_page IS NULL;
        -- Year
        UPDATE Bird_eggs
        SET Year = (
            SELECT Year
            FROM Bird_nests
            WHERE Nest_ID = NEW.Nest_ID) 
        WHERE Nest_ID = NEW.Nest_ID AND Year IS NULL;
        -- Site
        UPDATE Bird_eggs
        SET Site = (
            SELECT Site
            FROM Bird_nests
            WHERE Nest_ID = NEW.Nest_ID) 
        WHERE Nest_ID = NEW.Nest_ID AND Site IS NULL;
    END;

-- Do the same checks as above
-- Test out trigger by inserting new data
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.7', 2015, 'eaba', '14eabaage01', 12.34, 56.78);

SELECT * FROM Bird_eggs WHERE Nest_ID = '14eabaage01' ORDER BY Egg_num DESC;

-- Also check for a new nest_ID
INSERT INTO Bird_eggs
    (Book_page, Year, Site, Nest_ID, Length, Width)
    VALUES ('b14.6', 2014, 'eaba', 'test_id', 12.34, 56.78);

SELECT * FROM Bird_eggs WHERE Nest_ID = 'test_id'; 