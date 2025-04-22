-- Week 3 - SQL problem 3

--To calculate the volume of an egg, use the simplified formula
-- pi/6 W^2L
-- A good place to start is just to group bird eggs by nest (i.e., Nest_ID) and compute average volumes:
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG(...) AS Avg_volume
        FROM ...
        GROUP BY ...;

-- You can now join that table with Bird_nests, so that you can group by species, and also join with the Species table to pick up scientific names. To do just the first of those joins, you could say something like
SELECT Species, MAX(...)
    FROM Bird_nests JOIN Averages USING (Nest_ID)
    GROUP BY ...;

-- (Notice how, if the joined columns have the same name, you can more compactly say USING (common_column) instead of ON column_a = column_b.)

-- That’s not the whole story, we want scientific names not species codes. Another join is needed. A couple strategies here. One, you can modify the above query to also join with the Species table (you’ll need to replace USING with ON …). Two, you can save the above as another temp table and join it to Species separately.

-- Don’t forget to order the results. Here it is convenient to give computed quantities nice names so you can refer to them.

-- Please submit all of the SQL you used to solve the problem. Bonus points if you can do all of the above in one statement.

