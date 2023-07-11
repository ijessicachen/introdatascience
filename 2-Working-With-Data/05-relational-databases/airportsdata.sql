-- SQLite
-- Changed run to Q-shift+Q so it wouldn't conflict with 
--  built-in mac shortcuts

-- Return all city names in the Cities table
SELECT city
FROM Cities;

-- Return all cities in Ireland in the Cities table
SELECT city
FROM Cities
WHERE country = 'Ireland';

-- Return all airport names with their city and country
--  Just to visualize the ids
SELECT id
FROM Cities;
SELECT city_id
FROM Airports;
--  Actual display
SELECT Airports.name, Cities.city, Cities.country
-- Order for SELECT will be order the columns are displayed
-- You can do FROM Airports OR FROM Cities. Both ways work
FROM Airports
    INNER JOIN Cities ON Airports.city_id = Cities.id;

-- Return all airports in London, United Kingdom
SELECT Airports.name
-- To demonstrate that both ways work
FROM Cities
    INNER JOIN Airports ON Cities.id = Airports.city_id
WHERE Cities.city = 'London' AND Cities.country = 'United Kingdom';
-- Just curious to see if there's a London not in the UK in this db
SELECT Airports.name
FROM Cities
    INNER JOIN Airports ON Cities.id = Airports.city_id
WHERE Cities.city = 'London';