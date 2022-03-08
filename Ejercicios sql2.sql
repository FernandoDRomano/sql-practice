USE sakila;

/*
 * EJERCICIO #1:
 * 
 * Usa la función CHAR_LENGTH() en la tabla customer y calcula la longitud de la columna email.
 * Usa la función CONCAT() en la tabla customer y has un concatenado entre first_name, last_name y email.
 * Usa la función CONCAT_WS() en la tabla film y has un concatenado de todas las columnas.
 * Consulta la tabla payment y has un group by por customer_id para el promedio de amount, después usa la función ROUND() para redondear a cero decimales el promedio.
 * Usa la función UCASE() en la tabla city y convierte la columna city en mayúsculas.
 *
 **/

SELECT customer.email, CHAR_LENGTH(customer.email) as longitud FROM customer;

SELECT CONCAT(c.first_name, ' - ', c.last_name, ' - ', c.email) as concat FROM customer c; 

SELECT CONCAT_WS(' - ', f.film_id, f.title, f.description, f.release_year, f.language_id, f.original_language_id, f.rental_duration, f.rental_rate, f.`length`, f.replacement_cost, f.rating, f.special_features, f.last_update) from film f;

SELECT p.customer_id, AVG(p.amount) as promedio, ROUND(AVG(p.amount)) as redondeado 
FROM payment p
GROUP BY p.customer_id ;

SELECT c.city, UCASE(c.city) as uppercase FROM city c;

/*
 * EJERCICIO #2:
 * 
 * Usa la función INSER INTO y agrega un registro a la tabla actor.
 * Usa la función INSER INTO y agrega un registro a la tabla address.
 * Usa la función INSER INTO y agrega un registro a la tabla category.
 * Usa la función INSER INTO y agrega un registro a la tabla customer.
 * Usa la función INSER INTO y agrega un registro a la tabla film_text.
 * 
 **/

INSERT INTO actor (first_name, last_name) 
VALUES ('FERNANDO DANIEl', 'ROMANO');

INSERT INTO address (address, address2, district, city_id, postal_code, phone, location)
VALUES ('Gral. Lamadrid 1936', '---', 'S. M. de Tucuman', '424', '4000', '3815261309', ST_GeomFromText('LINESTRING(2 1, 6 6)'));

INSERT INTO category (name) 
VALUES ('Nueva Categoría');

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active, create_date)
VALUES ('2', 'Fernando', 'Romano', 'fer@gmail.com', '606', '1', now());

INSERT INTO film_text (film_id, title)
VALUES (1, 'ADAPTATION HOLES');

/*
 * EJERCICIO #3:
 * 
 * Usa la función UPDATE y ACTUALIZA un registro a la tabla actor.
 * Usa la función UPDATE y ACTUALIZA un registro a la tabla address.
 * Usa la función UPDATE y ACTUALIZA un registro a la tabla category.
 * Usa la función UPDATE y ACTUALIZA un registro a la tabla customer.
 * Usa la función UPDATE y ACTUALIZA un registro a la tabla film_text.
 *
 **/

UPDATE actor 
SET first_name = 'Fernando D.', last_name = 'Romano - Ibarra' 
WHERE actor_id = 201;

UPDATE address 
SET address = 'Pje. Lafinur 3367'
WHERE address_id = 607;

UPDATE category 
SET name = 'XXX'
WHERE category_id = 17;

UPDATE customer 
SET first_name = 'Evangelina', last_name = 'Ibarra', email = 'eva@gmail.com', active = 1
WHERE customer_id = 599;

UPDATE film_text 
SET description = 'Esto es una descripción'
WHERE film_id = 1;

/*
 * 	EJERCICIO #4:
 * 
 * Usa la función ALTER TABLE  y agrega la columna categoria a la tabla film_text, 
 * llena la columna de los primeros 10 film_id. 
 *
 **/

DESCRIBE film_text;

ALTER TABLE film_text 
ADD COLUMN category varchar(50) DEFAULT NULL 
AFTER description;

UPDATE film_text 
SET category = 'Nueva Categoría...'
WHERE film_id IN (1,2,3,4,5,6,7,8,9,10);

/*
 * EJERCICIO #5:
 * 
 * Usa la función CASE en la tabla film y calcula 3 casos, 
 * si rental_rate es menor que 1 ingresa "Pelicula Mala", 
 * si la calificacion esta dentro de 1 y 3 que muestre "Pelicula Buena", 
 * si es mayor que muestre "Pelicula Excelente" 
 *
 **/

SELECT f.film_id, f.title, f.rental_rate,
	CASE 
		WHEN f.rental_rate < 1 THEN 'Pelicula Mala'
		WHEN f.rental_rate BETWEEN 1 AND 3 THEN 'Pelicula Buena'
		ELSE 'Pelicula Excelente'
	END as response
FROM film f;

/*
 * EJERCICIO #6:
 * 
 * ¿Quién ha vendido más del STAFF en Agosto del 2005? 
 *
 **/

SELECT s.staff_id, s.first_name, s.last_name, SUM(p.amount) AS total
FROM staff s 
INNER JOIN payment p ON s.staff_id = p.staff_id
WHERE p.payment_date BETWEEN '2005-08-01' AND '2005-08-30'
GROUP BY s.staff_id
ORDER BY total DESC
LIMIT 1;

/*
 * EJERCICIO #7:
 * 
 * Haga una lista de cada pelicula y el número de actores que figuran en esa pelicula.
 * Utiliza tablas film_actor y film
 *
 **/

SELECT f.film_id, f.title, COUNT(fa.actor_id) as count_actors 
FROM film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id
GROUP BY f.film_id;

/*
 * EJERCICIO #8:
 * 
 * ¿Cuántas copias de la pelicula 'Hunchback impossible' existen en el sistema de inventario?
 *
 **/

SELECT f.title, COUNT(f.title) as total 
FROM inventory i 
INNER JOIN film f ON i.film_id = f.film_id 
WHERE f.title = 'Hunchback impossible';

/*
 * EJERCICIO #9:
 * 
 * Anote el total pagado por cada cliente. Listar los clientes alfabeticamente por apellido.
 *
 **/

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) as total 
FROM customer c 
INNER JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id 
ORDER BY c.last_name, total;

/*
 * EJERCICIO #10:
 * 
 * Resuelve el siguiente problema:
 * Encuentra DVD vencidos
 * Muchas tiendas de DVD producen una lista diaria de alquileres vencidos 
 * para que los clientes puedan ser contactados y se les pida que devuelvan sus DVD vencidos.
 * 
 * Para crear una lista de este tipo, busque películas en la tabla de alquiler 
 * con una fecha de retorno NULA y donde la fecha de alquiler sea más antigua 
 * que la duración del alquiler especificada en la tabla de películas. 
 * Si es así, la película está atrasada y debemos producir 
 * el nombre de la película junto con el nombre del cliente y el número de teléfono. 
 *
 **/

SELECT * from address;

SELECT f.title, CONCAT(c.last_name , ', ' ,c.first_name) as full_name, a.phone
FROM rental r 
INNER JOIN customer c ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id 
INNER JOIN film f ON i.film_id  = f.film_id 
INNER JOIN address a ON c.address_id = a.address_id
WHERE r.return_date IS NULL;

/*
 * EJERCICIO #11:
 * 
 * Encuentre el nombre completo y la dirección de correo electrónico de todos los clientes 
 * que hayan alquilado una película de acción.
 * 
 * Todos los pagos que exceden el promedio para cada cliente 
 * junto con el recuento total de pagos que exceden el promedio. 
 * 
 **/

SELECT c.first_name, c.last_name, c.email 
FROM customer c
WHERE c.customer_id IN (
	SELECT r.customer_id FROM rental r WHERE r.inventory_id IN (
		SELECT i.inventory_id FROM inventory i WHERE i.film_id IN(
			SELECT fc.film_id FROM film_category fc WHERE fc.category_id IN (
				SELECT ct.category_id FROM category ct WHERE ct.name = 'Action'
			)
		)
	)
);

SELECT c.customer_id, c.first_name, c.last_name, AVG(p.amount) as total 
FROM customer c 
INNER JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING total > (
	SELECT AVG(amount) FROM payment
);

/*
 * EJERCICIO #12
 * 
 * La vista "lista de clientes" proporciona una lista de clientes, 
 * con el nombre y el apellido concatenados juntos y direcciones de información 
 * combinadas en una sola vista. 
 * La vista "lista de clientes" incorpora datos de las tablas de clientes, 
 * direcciones, ciudades y países. 
 *
 **/

CREATE VIEW list_of_customers AS 
SELECT 
	CONCAT(c.first_name, ' ', c.last_name) AS full_name,
	CONCAT_WS(', ', ad.address, ad.district, ct.city, cty.country) as address 
FROM customer c
INNER JOIN address ad ON c.address_id = ad.address_id 
INNER JOIN city ct ON ad.city_id = ct.city_id 
INNER JOIN country cty ON ct.country_id = cty.country_id;

DROP VIEW list_of_customers;

SELECT * FROM list_of_customers;





