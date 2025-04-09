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

- I chose to make every variable `NOT NULL` except for and `Notes`. Most of the `Notes` columnd is empty, it seems the observers rarely had notes to add. 
- I identified the primary key as a combination of `Site` `Date` and `Plot`. This seemed to be the minimum number of variables to have a unique identifier for each observation. 
- I also identified two foreign keys of `Site` for referencing the Site's dataframe `code` and `Observer` for referencing the Personnel's dataframe `abbreviation`.
- I added a check constraint to ensure that the `Snow_cover`, `Water_cover`, and `Land_cover` columns are all between 0 and 100. I also added a check constraint to ensure that the `Total_cover` column is equal to the sum of the other three columns.



