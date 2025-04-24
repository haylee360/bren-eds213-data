-- Views are often useful when you need a "function". For example, if you need to do a join over and over again, you might as well just use a view. 

CREATE TABLE Snow_cover(
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018),
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130), 
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY (Site, Plot, Date, Location),
    FOREIGN KEY (Site) REFERENCES Site (Code),
    -- FOREIGN KEY (Observer) REFERENCES Personnel (Abbreviation)
);

COPY Snow_cover FROM "../week1/ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA");
-- Set what the NULL values are when reading in

SELECT * FROM Snow_cover LIMIT 10;

-- Question 1: What is the average snow cover at each site?

SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover 
    GROUP BY Site;

-- Ask 2: Modify query to give me the top 5 most snowy site
SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover 
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5;

-- Ask 3: save this as a view
CREATE VIEW Site_avg_snowcover AS(
    SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover 
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5
);

SELECT * FROM Site_avg_snowcover;

CREATE TEMP TABLE Site_avg_snowcover_table AS(
    SELECT Site, AVG(Snow_cover) AS Avg_snow_cover FROM Snow_cover 
    GROUP BY Site
    ORDER BY avg_snow_cover DESC
    LIMIT 5
);

SELECT * FROM Site_avg_snowcover_table;

-- If we change the data, the view will update but the temp table won't!
-- Danger zone! AKA updating data
-- Always make copies of the data so you don't accidentally lose things
-- We found that 0s at plot = 'brw0' with snow_cover  == 0 are actually no data (NULL)

CREATE TEMP TABLE Snow_cover_backup AS (SELECT * FROM Snow_cover);

UPDATE Snow_cover_backup SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;

SELECT Snow_cover FROM Snow_cover_backup WHERE Plot = 'brw0';

-- Update real data
UPDATE Snow_cover SET Snow_cover = NULL WHERE Plot = 'brw0' AND Snow_cover = 0;
