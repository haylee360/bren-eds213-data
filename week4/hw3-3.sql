-- Week 3 - SQL problem 3
-- Haylee Oyler

-- The all-in-one version:
FROM (
    SELECT Species, MAX(Avg_volume) AS Max_avg_volume
    FROM Bird_nests JOIN (
        SELECT Nest_ID, AVG((3.14/6)*Width^2*Length) AS Avg_volume
        FROM Bird_eggs
        GROUP BY Nest_ID
    ) USING (Nest_ID)
    GROUP BY Species
) AS Averages
    JOIN Species ON Species.Code = Averages.Species
    SELECT Scientific_name, Max_avg_volume
    ORDER BY Max_avg_volume DESC;


-- The piece by piece version
--To calculate the volume of an egg, use the simplified formula
-- pi/6 W^2L
-- A good place to start is just to group bird eggs by nest (i.e., Nest_ID) and compute average volumes:
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14/6)*Width^2*Length) AS Avg_volume
        FROM Bird_eggs
        GROUP BY Nest_ID;

-- You can now join that table with Bird_nests, so that you can group by species, and also join with the Species table to pick up scientific names. To do just the first of those joins, you could say something like

CREATE TEMP TABLE Species_avg AS
SELECT Species, MAX(Avg_volume) AS Max_avg_volume
    FROM Bird_nests JOIN Averages USING (Nest_ID)
    GROUP BY Species
    ORDER BY Max_avg_volume DESC;

-- (Notice how, if the joined columns have the same name, you can more compactly say USING (common_column) instead of ON column_a = column_b.)

-- That’s not the whole story, we want scientific names not species codes. Another join is needed. A couple strategies here. One, you can modify the above query to also join with the Species table (you’ll need to replace USING with ON …). Two, you can save the above as another temp table and join it to Species separately.

SELECT Scientific_name, Max_avg_volume 
    FROM Species_avg JOIN Species
    ON Species.Code = Species_avg.Species
    ORDER BY Max_avg_volume DESC;

