USE sakila;

-- ========================================
-- Easy Queries
-- ========================================

-- 1. Show all actors
SELECT * FROM actor;

-- 2. Show only first and last names of actors
SELECT first_name,last_name FROM actor;

-- 3. Show first 5 films
SELECT * FROM film
LIMIT 5;

-- 4. Show films longer than 120 minutes
SELECT * FROM film
WHERE length > 120;

-- 5. Show films with rating PG
SELECT * FROM film
WHERE rating = 'PG';

-- 6. Show active customers
SELECT * FROM customer
WHERE active = 1;

-- 7. Show all cities in ascending order
SELECT * FROM city
ORDER BY city ASC;

-- 8. Show payments with amount greater than 5
SELECT * FROM payment
WHERE amount > 5;

-- 9. Show first 10 rentals
SELECT * FROM rental
LIMIT 10;

-- 10. Show actor with first name Penelope
SELECT * FROM actor
WHERE first_name = 'PENELOPE';


-- ========================================
-- Medium Queries
-- ========================================

-- 11. Count all films
SELECT COUNT(*) FROM film;

-- 12. Show top 5 longest films
SELECT * FROM film
ORDER BY length DESC
LIMIT 5;

-- 13. Count films by rating
SELECT rating,COUNT(*) FROM film
GROUP BY rating;

-- 14. Show countries of active customers
SELECT cnty.country FROM customer c 
JOIN address a ON a.address_id = c.address_id
JOIN city ct ON ct.city_id = a.city_id
JOIN country cnty ON cnty.country_id = ct.country_id
WHERE c.active = 1;

-- 15. Show all films of actor with ID = 2
SELECT f.title FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON a.actor_id = fa.actor_id
WHERE a.actor_id = 2;

-- 16. Show average payment amount
SELECT ROUND(AVG(amount),2) FROM payment;

-- 17. Show total payments per customer
SELECT c.first_name,c.last_name, SUM(p.amount) 
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.first_name,c.last_name;

-- 18. Show top 5 most active actors by film count
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) 
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY COUNT(*) DESC
LIMIT 5;

-- 19. Show total payments collected per staff member
SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) 
FROM payment p
JOIN staff s ON s.staff_id = p.staff_id
GROUP BY s.staff_id, s.first_name, s.last_name;

-- 20. Show top 3 countries with most customers
SELECT cnty.country,COUNT(c.customer_id) 
FROM customer c 
JOIN address a ON a.address_id = c.address_id
JOIN city ct ON ct.city_id = a.city_id
JOIN country cnty ON cnty.country_id = ct.country_id
GROUP BY cnty.country
ORDER BY COUNT(c.customer_id) DESC
LIMIT 3;


-- ========================================
-- Hard Queries
-- ========================================

-- 21. Show top 5 customers by payment amount
SELECT c.first_name,c.last_name, SUM(p.amount) 
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.first_name,c.last_name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 22. Count films per rating
SELECT rating, COUNT(title) FROM film
GROUP BY rating;

-- 23. Show customers who paid more than 100 total
SELECT c.first_name,c.last_name, SUM(p.amount) 
FROM customer c
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.first_name,c.last_name
HAVING SUM(p.amount) > 100;

-- 24. Show all payments sorted by amount (desc)
SELECT c.first_name, c.last_name, p.amount  
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id
ORDER BY p.amount DESC;

-- 25. Show average rental duration per customer
SELECT c.customer_id, c.first_name, c.last_name, 
       ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)),2)  
FROM customer c
JOIN rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id;

-- 26. Show PG-rated Comedy films
SELECT * FROM film
WHERE description LIKE '%Comedy%' AND rating = 'PG';

-- 27. Show actors with more than 20 films
SELECT a.actor_id, a.first_name, a.last_name, COUNT(*) 
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(*) > 20;

-- 28. Show films ordered by rental duration (desc)
SELECT * FROM film
ORDER BY rental_duration DESC;
