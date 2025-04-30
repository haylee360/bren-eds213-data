-- Week 4 - Who’s the culprit?
-- Haylee Oyler

SELECT Name, COUNT(*) AS Num_floated_nests
    FROM Bird_nests B JOIN Personnel P
    ON B.Observer = P.Abbreviation
    WHERE Site = 'nome'
        AND Year BETWEEN 1998 AND 2008
        AND ageMethod = 'float'
    GROUP BY Name
    HAVING COUNT(*) = 36;