-- Week 3 - SQL problem 1
-- Haylee Oyler

-- Part 1
CREATE TEMP TABLE mytable (
    my_col REAL
);

INSERT INTO mytable VALUES (1),(2), (3), (NULL), (5);
SELECT * FROM mytable;

SELECT AVG(my_col) FROM mytable;
-- This code gives an average value of 2.75, which is the average if the NULL is ignored -->
-- (1+2+3+5) / 4 = 2.75
-- If the NULL wasn't ignored, the average value would be (1+2+3+5) / 5 = 2.2
-- The results of this little experiment tell us that the average function does indeed ignore NULL values in its calculation

-- Part 2

SELECT SUM(my_col)/COUNT(*) FROM mytable;
-- Gives 2.2
SELECT SUM(my_col)/COUNT(my_col) FROM mytable;
-- Gives 2.75

-- The bottom method is correct. Using COUNT(*) includes the NULL row in the calculation. However, using COUNT(my_col) does not include the NULL value. This matches the calculation outputted from AVG in part 1. 

DROP TABLE mytable;

