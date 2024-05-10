-- Rank films by length (filter out the rows with nulls or zeros in length column). 
-- Select only columns title, length and rank in your output.
SELECT TITLE, LENGTH, RANK() OVER (ORDER BY LENGTH) AS 'RANK'
FROM SAKILA.FILM
WHERE LENGTH IS NOT NULL AND LENGTH > 0;

-- Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
-- In your output, only select the columns title, length, rating and rank.
SELECT TITLE, LENGTH, RATING, RANK() OVER (PARTITION BY RATING ORDER BY LENGTH) AS 'RANK'
FROM SAKILA.FILM
WHERE LENGTH IS NOT NULL AND LENGTH > 0;

-- How many films are there for each of the categories in the category table? 
-- Hint: Use appropriate join between the tables "category" and "film_category".
SELECT C.NAME AS CATEGORY, COUNT(FC.FILM_ID) AS FILM_COUNT
FROM SAKILA.CATEGORY C
LEFT JOIN SAKILA.FILM_CATEGORY FC ON C.CATEGORY_ID = FC.CATEGORY_ID
GROUP BY 1;

-- Which actor has appeared in the most films? Hint: You can create a join between the tables 
-- "actor" and "film actor" and count the number of times an actor appears.
SELECT A.FIRST_NAME, A.LAST_NAME, COUNT(FA.FILM_ID) AS FILM_COUNT
FROM SAKILA.ACTOR A
LEFT JOIN SAKILA.FILM_ACTOR FA ON A.ACTOR_ID = FA.ACTOR_ID
GROUP BY A.ACTOR_ID
ORDER BY 3 DESC
LIMIT 1;

-- Which is the most active customer (the customer that has rented the most number of films)? 
-- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.
SELECT C.FIRST_NAME, C.LAST_NAME, COUNT(R.RENTAL_ID) AS RENTAL_COUNT
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.RENTAL R ON C.CUSTOMER_ID = R.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID
ORDER BY 3 DESC
LIMIT 1;

-- !!!!BONUS!!!! Which is the most rented film? (The answer is Bucket Brotherhood).
SELECT F.TITLE, COUNT(R.RENTAL_ID) AS RENTAL_COUNT
FROM SAKILA.FILM F
LEFT JOIN SAKILA.INVENTORY I ON F.FILM_ID = I.FILM_ID
LEFT JOIN SAKILA.RENTAL R ON I.INVENTORY_ID = R.INVENTORY_ID
GROUP BY F.FILM_ID
ORDER BY 2 DESC
LIMIT 1;





