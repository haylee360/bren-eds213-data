-- Week 3 - SQL problem 2
-- Haylee Oyler

-- Part 1
SELECT Site_name, MAX(Area) FROM Site;

-- We want to see the name of the sites with the largest areas. However, MAX(Area) returns only one value which would just be the largest Area in the entire Site table. DuckDB doesn't know which site name to return with that area! This is why we need to give it some method of aggregating/grouping (like what the error message says). Then, it will have a clearer idea of what site to return

-- Part 2
SELECT Site_name, Area, FROM Site
    ORDER BY Area DESC
    LIMIT 1;

-- Part 3
-- Find max area
SELECT MAX(Area) FROM Site

-- Nest that query to find site name of area that equals that max
SELECT Site_name, Area FROM Site 
    WHERE Area = (SELECT MAX(Area) FROM Site);

