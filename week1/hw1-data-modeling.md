# Homework 1 Data Modeling
Haylee Oyler

**Instructions**: Create a table definition for the Snow_survey table that is maximally expressive, that is, that captures as much of the semantics and characteristics of the data using SQL’s data definition language as is possible.

```{sql}
CREATE TABLE Snow_survey (
    Site TEXT NOT NULL 
    Year DATE NOT NULL,
    "Date" DATE NOT NULL,
    Plot TEXT NOT NULL,
    Location TEXT,
    Snow_cover REAL NOT NULL CHECK (Snow_cover BETWEEN 0 AND 100),
    Water_cover REAL NOT NULL CHECK (Water_cover BETWEEN 0 AND 100),
    Land_cover REAL NOT NULL CHECK (Land_cover BETWEEN 0 AND 100),
    Total_cover REAL NOT NULL CHECK (Total_cover = Snow_cover + Water_cover + Land_cover),
    Observer TEXT NOT NULL,
    Notes TEXT, 
    PRIMARY KEY(Site, Date, Plot),
    FOREIGN KEY (Site) REFERENCES Site(Code),
    FOREIGN KEY (Observer) REFERENCES Personnel(Abbreviation),
);
```

**Explanation**:

- I chose to make every variable `NOT NULL` except for `Plot` and `Notes`. Most of the `Notes` columnd is empty, it seems the observers rarely had notes to add. The plot column 

Snow_survey

Periodic records of snow cover remaining at the site

Column name	Definition
Site	Four-letter code of site at which data were collected
Year	Year in which data were collected
Date	Date on which data were collected
Plot	Name of study plot on which survey was conducted
Location	Name of dedicated snow-survey location, if applicable
Snow_cover	Percent cover of snow, including slush
Water_cover	Percent cover of water
Land_cover	Percent cover of exposed land
Total_cover	Total sum (to check the above percents; should always sum to 100)
Observer	Person who conducted the survey
Notes	Any relevant comments on the survey

Please consider:

the data types of columns (pick from TEXT, REAL, INTEGER, DATE for this exercise)
if the table has a primary key and what it might be
any foreign key(s)
whether NULL values are allowed
uniqueness constraints, on individual columns and across columns
other column value constraints, again, on individual columns and across columns
You may (or may not) want to take advantage of the Species, Site, Color_band_code, and Personnel supporting tables. These are also documented in the metadata, and SQL table definitions for them have already been created and are included below.

Please express your table definition in SQL, but don’t worry about getting the SQL syntax exactly correct. This assignment is just a thought exercise. If you do want to try to write correct SQL, though, your may find it helpful to consult the DuckDB CREATE TABLE documentation.

Finally, please provide some explanation for why you made the choices you did, and any questions or uncertainties you have. Don’t write an essay! Bullet points are sufficient. But do please explain your thought process.

