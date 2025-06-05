# Homework 9 Part 1
 
 Haylee Oyler

 1. When I run the command `PRAGMA index_list('Bird_nests');`, I can see that there is one existing index in this table that comes from the primary key, which is Nest_ID. This index does not get used in the query because we are not explicitly filtering on the Nest_ID column itself, we are filtering based on the specifications in the WHERE clause. Additionally, when I run the command `EXPLAIN QUERY PLAN [query from assignment]`, sqlite3 returns `--SCAN Bird_nests`. This confirms that no, an index is not being used in this query. These queries were run after reading [sqlite3 documentation](https://www.sqlitetutorial.net/sqlite-index/).

 2. Adding an index to a column not in there WHERE clause will not be used in the database. This is because the database does not need to perform a search on a column not used in the WHERE clause, so there is no reason for it to use that index to narrow down to the selected query results. 


