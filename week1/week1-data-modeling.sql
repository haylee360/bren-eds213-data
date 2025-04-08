CREATE TABLE Species (
    Code TEXT PRIMARY KEY,
    Common_name TEXT UNIQUE NOT NULL,
    Scientific_name TEXT,
    Relevance TEXT
);

-- Insert data from CSV
INSERT INTO Species
SELECT * FROM read_csv_auto('ASDN_csv/species.csv');

CREATE TABLE Site (
    Code TEXT PRIMARY KEY,
    Site_name TEXT UNIQUE NOT NULL,
    Location TEXT NOT NULL,
    Latitude REAL NOT NULL CHECK (Latitude BETWEEN -90 AND 90),
    Longitude REAL NOT NULL CHECK (Longitude BETWEEN -180 AND 180),
    "Total_Study_Plot_Area_(ha)" REAL NOT NULL
        CHECK ("Total_Study_Plot_Area_(ha)" > 0),
    UNIQUE (Latitude, Longitude)
);
-- Insert data from CSV
INSERT INTO Site
SELECT * FROM read_csv_auto('ASDN_csv/site.csv');

CREATE TABLE Color_band_code (
    Code TEXT PRIMARY KEY,
    Color TEXT NOT NULL UNIQUE
);
-- Insert data from CSV
INSERT INTO Color_band_code
SELECT * FROM read_csv_auto('ASDN_csv/color_band_code.csv');


CREATE TABLE Personnel (
    Abbreviation TEXT PRIMARY KEY,
    Name TEXT NOT NULL UNIQUE
);
-- Insert data from CSV
INSERT INTO Personnel
SELECT * FROM read_csv_auto('ASDN_csv/personnel.csv');


CREATE TABLE Snow_survey (
    Site TEXT NOT NULL,
    Year DATE NOT NULL, -- Or should this be integer?
    "Date" DATE NOT NULL,
    Plot TEXT,
    Location TEXT NOT NULL,
    Snow_cover REAL NOT NULL,
    Water_cover REAL NOT NULL,
    Land_cover REAL NOT NULL,
    Total_cover REAL NOT NULL,
    Observer TEXT NOT NULL,
    Notes TEXT, -- IDK how to demarcate when it's okay for null values 
);
-- Insert data from CSV
INSERT INTO Snow_survey
SELECT * FROM read_csv_auto('ASDN_csv/ASDN_Snow_survey.csv');