-- Netflix db project (part2)

SELECT * FROM netflix;

-- task 11: List All Movies that are Documentaries.

SELECT * FROM netflix
WHERE  
	 listed_in LIKE '%Documentaries%';



-- task 12: Find All Content Without a Director

SELECT * FROM netflix
WHERE director is NULL;



-- task 13: Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

SELECT* FROM netflix
WHERE 
	 casts ILIKE '%Salman Khan%'
	 AND
	 release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;



-- task 14: Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

SELECT 
	  UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
	  COUNT(*) as total_content
FROM netflix
WHERE country ILIKE '%India%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10



-- task 15: Categorise Content Based on the Presence of 'Kill' and 'Violence' Keywords

WITH new_table
AS
(
SELECT
*,
     CASE
	 WHEN 
	        description ILIKE '%Kill%' OR
	        description ILIKE '%Violence%' THEN 'bad_content'
		    ELSE 'good_content'
	 END category
FROM netflix
)
SELECT 
     category,
	 COUNT(*) as total_content
FROM new_table
GROUP BY 1







---- <<end of part 2>>



---- <<end of part 2>>