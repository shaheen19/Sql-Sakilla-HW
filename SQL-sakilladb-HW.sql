show databases;
use sakila;
show tables;
-- Question 1a,b --
select * from  actor;   
select first_name, last_name from actor;
Alter table actor add column Actor_name varchar(50);
update actor set Actor_name = upper(concat(first_name," ", last_name));



-- Question 2a---
-- You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
SELECT * FROM actor;
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Joe';

-- Question 2b---
SELECT last_name
FROM actor
WHERE last_name LIKE '%GEN%';

-- Question 2c---
SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name, first_name;

-- Question 2d---
SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');


-- Question 3a---
ALTER TABLE actor
ADD COLUMN Description BLOB;

-- Question 3b---
ALTER TABLE actor
DROP COLUMN Description;


-- Question 4a---
SELECT last_name, COUNT(last_name) as "Count of Last Name"
FROM actor
GROUP BY last_name;

-- Question 4b---
SELECT last_name, COUNT(last_name) as "Count of Last Name"
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) >=2;

-- Question 4c---
UPDATE actor
SET first_name = 'Harpo'
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';


-- Question 4d --each actor has unique ID so to make correction one can find Harpo ID and execute command using this ID.

SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Harpo' AND last_name = 'WILLIAMS';
UPDATE actor
 SET first_name = 
 CASE 
 WHEN first_name = 'HARPO' 
 THEN 'GROUCHO'
 ELSE 'MUCHO GROUCHO'
 END
 WHERE actor_id = 172;



-- Question 5a---
SHOW CREATE TABLE sakila.address;


-- Question 6a---
Use Sakila;
SELECT first_name, last_name, address
FROM staff s
INNER JOIN address a
ON s.address_id = a.address_id;


-- Question 6b---
Use Sakila;
SELECT first_name, last_name, SUM(amount)
FROM staff s
INNER JOIN payment p
ON s.staff_id = p.staff_id
GROUP BY p.staff_id
ORDER BY last_name ASC;

-- Question 6c---
SELECT title, COUNT(actor_id)
FROM film f
INNER JOIN film_actor fa
ON f.film_id = fa.film_id
GROUP BY title;

-- Question 6d---
SELECT title, COUNT(inventory_id)
FROM film f
INNER JOIN inventory i 
ON f.film_id = i.film_id
WHERE title = "Hunchback Impossible";

-- Question 6e---
SELECT last_name, first_name, SUM(amount)
FROM payment p
INNER JOIN customer c
ON p.customer_id = c.customer_id
GROUP BY p.customer_id
ORDER BY last_name ASC;


-- Question 7a---
USE Sakila;
SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");

-- Question 7b---
use Sakila;
SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));

-- Question 7c---
Use Sakila;
SELECT country, last_name, first_name, email
FROM country c
	LEFT JOIN customer cu
	ON c.country_id = cu.customer_id
		WHERE country = 'Canada';


-- Question 7d---
SELECT title, category
	FROM film_list
		WHERE category = 'Family';



-- Question 7e---
use sakila;
SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

-- Question 7f---
use Sakila;
SELECT store.store_id, SUM(amount)
FROM store
INNER JOIN staff
ON store.store_id = staff.store_id
INNER JOIN payment p 
ON p.staff_id = staff.staff_id
GROUP BY store.store_id
ORDER BY SUM(amount);


-- Question 7g---

USE Sakila;
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);




-- Question 7h---
USE Sakila;
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- Question 8a---
use sakila;
Create view Top_Five_Genres AS
SELECT c.name AS "Top_Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- Question 8b----
SELECT * FROM Top_Five_Genres;


-- Question 8c---
DROP VIEW Top_Five_Genres;

