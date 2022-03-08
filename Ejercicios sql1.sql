/*
 * EJERCICIO #1:
 * 
 * Consulta store_id, first_name y last_name de la tabla customer de la base de datos sakila.
 * Cambia el nombre de las columnas store_id, first_name y last_name a Tienda, Nombre y Apellido respectivamente.
 * Ordena de manera descendente la columna Apellido
 * 
 **/

SELECT customer.store_id as Tienda, customer.first_name as Nombre, customer.last_name as Apellido 
FROM customer
ORDER BY Apellido DESC;

/*
 * EJERCICIO #2:
 * 
 * Consulta la tabla payment de la base de datos sakila.
 * ¿Cuál es la cantidad mas baja y mas alta de la columna amount?
 * 
 **/

SELECT DISTINCT MAX(amount) as Maximo, MIN(amount) as Minimo 
FROM payment
ORDER BY amount;

/**
 * EJERCICIO #3:
 * 
 * Consulta description, release_year de la tabla film de la base de datos sakila.
 * Filtra la información donde title sea IMPACT ALADDIN
 * 
 **/

SELECT film.title, film.description, film.release_year 
FROM film
WHERE film.title = "IMPACT ALADDIN";

/*
 * EJERCICIO #4:
 * 
 * Consulta la tabla payment de la base de datos sakila.
 * Filtra la información donde amount sea mayor a 0.99.
 * 
 **/

SELECT * FROM payment WHERE payment.amount > 0.99;

/*
 * EJERCICIO #5:
 * 
 * Consulta la tabla payment de la base de datos sakila.
 * Filtra la información donde customer_id sea igual a 36, amount sea mayor a 0.99 y staff_id sea igual a 1. 
 *
 **/

SELECT * FROM payment
WHERE payment.customer_id = 36 AND payment.amount > 0.99 AND payment.staff_id = 1;

/*
 * EJERCICIO #6:
 *
 * Consulta la tabla rental de la base de datos sakila.
 * Filtra la información donde staff_id no sea 1, customer_id sea mayor a 250 y inventory_id sea menor de 100.
 *
 **/

SELECT * FROM rental
WHERE NOT rental.staff_id = 1 AND rental.customer_id > 250 AND rental.inventory_id < 100;

/*
 * EJERCICIO #7:
 * 
 * Consulta la tabla film_text de la base de datos sakila.
 * Filtra la información donde title  sea ZORRO ARK, VIRGIN DAISY, UNITED PILOT
 *  
 **/

SELECT * FROM film_text 
WHERE film_text.title IN ('ZORRO ARK', 'VIRGIN DAISY', 'UNITED PILOT');

/*
 * EJERCICIO #8:
 * 
 * Consulta la tabla city de la base de datos sakila.
 * Filtra la información donde city sea Chiayi, Dongying, Fukuyama y Kilis. 
 *
 **/

SELECT * FROM sakila.city WHERE city IN ("Chiayi", "Dongying", "Fukuyama", "Kilis");

/*
 * EJERCICIO #9:
 * 
 * Consulta la tabla payment de la base de datos sakila.
 * Filtra la información donde amount esté entre 2.99 y 4.99,  staff_id sea igual a 2 y customer_id sea 1 y 2. 
 *
 **/

SELECT * FROM payment
WHERE (payment.amount BETWEEN 2.99 AND 4.99)  
      AND payment.staff_id = 2 
      AND (payment.customer_id BETWEEN 1 AND 2);

/*
 * EJERCICIO #10:
 * 
 * Consulta la tabla address de la base de datos sakila.
 * Filtra la información donde city_id esté entre 300 y 350,   
 *
 **/

SELECT * FROM address
WHERE address.city_id BETWEEN 300 AND 350;

/*
 * EJERCICIO #11:
 * 
 * Consulta la tabla film de la base de datos sakila.
 * Filtra la información donde rental_rate esté entre 0.99 y 2.99, length sea menor igual de 50  y replacement_cost sea menor de 20. 
 *
 **/

SELECT film.rental_rate, film.`length`, film.replacement_cost FROM film
WHERE (film.rental_rate BETWEEN 0.99 AND 2.99)
	  AND film.`length` <= 50
	  AND film.replacement_cost <= 20;

/*
 * EJERCICIO #12:
 * 
 * Consulta la tabla film de la base de datos sakila.
 * Filtra la información donde release_year sea igual a 2006  y title empiece con ALI. 
 *
 **/
	 
SELECT * FROM film
WHERE film.release_year = 2006 
      AND film.title LIKE 'ALI%';

/*
 * EJERCICIO #13:
 * 
 * Consulta la tabla address de la base de datos sakila.
 * Realiza un INNER JOIN con las tablas city y country
 * Mostrar las columnas address, city, country 
 *
 **/

SELECT a.address, c.city, cy.country 
FROM address a 
INNER JOIN city c ON a.city_id = c.city_id 
INNER JOIN country cy ON c.country_id = cy.country_id;

/*
 * EJERCICIO #14:
 * 
 * Consulta la tabla customer de la base de datos sakila.
 * Realiza un LEFT JOIN con las tablas store y address
 * Mostrar las columnas first_name, address, store_id 
 *
 **/

SELECT c.first_name, a.address, s.store_id 
FROM customer c
LEFT JOIN store s ON c.store_id = s.store_id
LEFT JOIN address a ON s.address_id = a.address_id;

/*
 * EJERCICIO #15:
 * 
 * Consulta la tabla rental de la base de datos sakila.
 * Realiza un INNER JOIN con la tabla staff
 * Mostrar las columnas rental_id, first_name 
 *
 **/

SELECT r.rental_id, s.first_name 
FROM rental r 
INNER JOIN staff s ON r.staff_id = s.staff_id;

/*
 * EJERCICIO #16:
 * 
 * Consulta la tabla rental de la base de datos sakila.
 * Realiza un COUNT de  la columna rental_id 
 *
 **/

SELECT COUNT(rental.rental_id) as total FROM rental;

/*
 * EJERCICIO #17:
 * 
 * Consulta la tabla payment de la base de datos sakila.
 * Realiza un MAX de  la columna amount
 * 
 **/

SELECT MAX(payment.amount) as Maximo FROM payment;

/*
 * EJERCICIO #18:
 * 
 * Consulta la tabla rental de la base de datos sakila.
 * Realiza un MAX de  la columna rental_date y agrupar por customer_id
 *
 **/

SELECT rental.customer_id, MAX(rental.rental_date) AS Maximo 
FROM rental
GROUP BY rental.customer_id;

/*
 * EJERCICIO #19:
 * 
 * Consulta la tabla actor de la base de datos sakila.
 * Realiza un COUNT de  last_name
 * Mostrar cuando el COUNT sea mayor de 2 
 *
 **/

SELECT actor.last_name, COUNT(*) as total 
FROM actor
GROUP BY actor.last_name
HAVING total > 2
ORDER BY total DESC;

/*
 * EJERCICIO #20: 
 * 
 * ¿Qué actores tienen el primer nombre 'Scarlett'?
 * ¿Qué actores tienen el apellido "Johansson"?
 * ¿Cuántos apellidos de actores distintos hay?
 * ¿Qué apellidos no se repiten?
 * ¿Qué actor ha aparecido en la mayoría de las películas?
 * ¿Se puede alquilar ‘Academy Dinosaur’ en la tienda 1?
 *
 **/

SELECT * FROM actor WHERE actor.first_name = 'Scarlett';
SELECT * FROM actor WHERE actor.last_name = 'Johansson';
SELECT COUNT(DISTINCT(actor.last_name)) FROM actor;

SELECT last_name, COUNT(*) AS repite
FROM actor 
GROUP BY last_name
HAVING repite = 1
ORDER BY last_name;

SELECT a.actor_id, CONCAT(a.last_name, ' ' ,a.first_name) as full_name, COUNT(*) as total_peliculas 
FROM film_actor fa
INNER JOIN actor a ON fa.actor_id = a.actor_id
INNER JOIN film f ON fa.film_id = f.film_id
GROUP BY a.actor_id 
ORDER BY total_peliculas DESC
LIMIT 1;

SELECT f.film_id, f.title, s.store_id, COUNT(*) as total
FROM inventory i
INNER JOIN film f ON f.film_id = i.film_id
INNER JOIN store s ON s.store_id = i.store_id
WHERE f.title = 'Academy Dinosaur' AND s.store_id = 1
GROUP BY f.film_id 
ORDER BY f.film_id
