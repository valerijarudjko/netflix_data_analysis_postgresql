-- Netflix db project

DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
   show_id VARCHAR (40),
   type VARCHAR (50),
   title VARCHAR (150),
   director VARCHAR (220),
   casts VARCHAR (1000),
   country VARCHAR (150),
   date_added VARCHAR (50),
   release_year INT,
   rating VARCHAR (10),
   duration VARCHAR (20),
   listed_in VARCHAR (300),
   description VARCHAR (250)
);
-- inserting data

SELECT * FROM netflix;

-- double-check

SELECT
  DISTINCT type
FROM netflix;



-- << Solving 15 Business Problems>> - part 1


-- task 1: Count the Number of Movies vs TV Shows

SELECT * FROM netflix;

SELECT 
    type,
	COUNT(*) as total_content
FROM netflix
GROUP BY type



 -- task 2: Find the Most Common Rating for Movies and TV Shows

SELECT 
     type,
     rating
FROM
(
  SELECT
     type,
	 rating,
	 COUNT(*),
     RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
  FROM netflix
  GROUP BY 1, 2

) as t1
WHERE
  ranking = 1



-- task 3: List All Movies Released in a Specific Year (e.g., 2020)

--filter 2020
--movies

SELECT * FROM netflix;

SELECT 
      release_year,
	  COUNT(*) as total_new
FROM netflix
WHERE release_year = 2021
GROUP BY 1;
-- << (only totals)

SELECT * FROM netflix
WHERE
      type = 'Movie'
	  AND
      release_year = 2020;
	  
-- << (the list of movies)


-- task 5: Find the Top 5 Countries with the Most Content on Netflix

SELECT * FROM netflix;

SELECT 
      UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
	  COUNT(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--<< writing a function >>
SELECT 
     UNNEST(STRING_TO_ARRAY(country, ',')) as new_country
FROM netflix;



-- task 6: Identify the Longest Movie

SELECT * FROM netflix
WHERE
     type = 'Movie'
ORDER BY duration DESC
LIMIT 10;

-- as a result full movie data including NULL
-- or 

SELECT * FROM netflix
WHERE 
       type = 'Movie'
	   AND
       duration = (SELECT MAX(duration) FROM netflix);



-- task 6: Find Content Added in the Last 5 Years

SELECT
      *
FROM netflix
WHERE 
      TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';


--SELECT CURRENT_DATE - INTERVAL '5 years'



-- task 7: Find All Movies/TV Shows by Director 'Rajiv Chilaka'

SELECT * FROM netflix
WHERE director LIKE '%Rajiv Chilaka%';


-- task 8: List All TV Shows with More Than 5 Seasons

SELECT
     type as total_shows,
	 duration
FROM netflix
WHERE 
     type = 'TV Show'
	 duration > '5 Seasons'



SELECT
     *
FROM netflix
WHERE 
     type = 'TV Show'
	 AND
	 SPLIT_PART(duration, ' ', 1)::numeric > 5;


-- task 9: Count the Number of Content Items in Each Genre

SELECT 
	 UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	 COUNT(show_id) as total_content
FROM netflix
GROUP by 1 

-- task 10: Find each year and the average numbers of content release in India on Netflix

SELECT 
      EXTRACT (YEAR FROM TO_DATE(date_added,'Month DD, YYYY')) as date,
	  COUNT(*),
	  ROUND (
	  COUNT(*):: numeric / (SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100, 2) as avg_content_year
FROM netflix
WHERE country = 'India'
GROUP BY 1



---- <<end of part 1>>
