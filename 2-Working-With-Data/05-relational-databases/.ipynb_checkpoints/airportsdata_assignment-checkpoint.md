## Assignment

Create queries to return the following information:

1. all city names in the `Cities` table
1. all cities in Ireland in the `Cities` table
1. all airport names with their city and country
1. all airports in London, United Kingdom

## Process

test sqlite
```bash
sqlite3 --help
sqlite3 --version
```

test db file
```bash
sqlite3 -table ~/touchgrass/introdatascience/data/airports.db "select * from cities limit 10"
```
+----+-------------------+----------------+
| id |       city        |    country     |
+----+-------------------+----------------+
| 2  | Belfast           | United Kingdom |
| 3  | Enniskillen       | United Kingdom |
| 5  | Londonderry       | United Kingdom |
| 6  | Birmingham        | United Kingdom |
| 7  | Coventry          | United Kingdom |
| 8  | Leicester         | United Kingdom |
| 9  | Golouchestershire | United Kingdom |
| 10 | Halfpenny Green   | United Kingdom |
| 11 | Pailton           | United Kingdom |
| 12 | Turweston         | United Kingdom |
+----+-------------------+----------------+

execute sql from a file
```sql
-- comments here
select * from cities limit 5;
select * from airports limit 5;
```

# stuff below this does not work

save to temp file
```vim
'<,'>!w /tmp/search.sql
```  

check saved temp file
```bash
cat /tmp/search.sql
```

execute the sql file for the sqlite database
```bash
# -echo will print input sql before execute.
sqlite3 -echo -table ~/touchgrass/introdatascience/data/airports.db < 
```
