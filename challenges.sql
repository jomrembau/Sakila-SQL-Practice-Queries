-- 🧩 Join Challenge:
-- Zeige die Namen aller Schauspieler und die Titel der Filme, in denen sie mitgespielt haben.
-- Sortiere nach dem Schauspielernamen.

SELECT a.first_name, a.last_name, f.title  
FROM actor a                               
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id  
LEFT JOIN film f ON f.film_id = fa.film_id          
ORDER BY a.first_name, a.last_name ASC;     

-- 📊 Aggregation Challenge:
-- Finde die Top 5 Kunden, die den höchsten Gesamtzahlungsbetrag geleistet haben.
-- Zeige customer_id, first_name, last_name und total_amount_paid.

SELECT 
    c.customer_id,                     
    c.first_name,                       
    c.last_name,                         
    SUM(p.amount) as total_amount_paid  
FROM customer c                        
LEFT JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY c.customer_id, c.first_name, c.last_name    
ORDER BY total_amount_paid DESC          
LIMIT 5;                                 

-- 🕵️ Subquery/Intermediate Challenge:
-- Liste alle Filme auf, die von mehr als 5 Kunden ausgeliehen wurden.
-- Zeige Titel und Anzahl der Rentals.

SELECT f.title, COUNT(r.rental_id)      
FROM film f                             
LEFT JOIN inventory i ON f.film_id = i.film_id   
LEFT JOIN rental r ON r.inventory_id = i.inventory_id  
LEFT JOIN payment p ON p.rental_id = r.rental_id        
GROUP BY f.title                          
HAVING COUNT(r.rental_id) > 5;          
