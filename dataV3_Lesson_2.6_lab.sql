-- # Lab | SQL Queries - Lesson 2.6

-- 1. Get release years.
select distinct release_year from sakila.film;

-- 2. Get all films with ARMAGEDDON in the title.
select * from sakila.film
where title like '%armageddon%';

-- 3. Get all films which title ends with APOLLO.
select * from sakila.film
where title like '%apollo';

-- 4. Get 10 the longest films.
select * from sakila.film
order by length desc
limit 10;

-- 5. How many films include **Behind the Scenes** content?
select * from sakila.film
where special_features like '%behind the scenes%';

-- 6. Drop column `picture` from `staff`.
alter table sakila.staff
drop column picture;

select * from sakila.staff;

-- 7. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
select * from sakila.customer
where first_name = 'tammy' and last_name = 'sanders';

insert into sakila.staff (staff_id, first_name, last_name, address_id, email, store_id, username, last_update)
values (3, 'Tammy', 'Sanders', 79, 'TAMMY.SANDERS@sakilacustomer.org', 2, 'Tammy', current_date); 

select * from sakila.staff;

-- 8. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. You can use current date for
-- the `rental_date` column in the `rental` table.
--    **Hint**: Check the columns in the table rental and see what information you would need to add there. You can query those
-- pieces of information. For eg., you would notice that you need `customer_id` information as well. To get that you can use the following query:
-- ```sql
-- select customer_id from sakila.customer
-- where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
-- ```
select max(rental_id) from sakila.rental;

select film_id from sakila.film
where title = 'Academy Dinosaur';

select inventory_id from sakila.inventory
where film_id = 1;

select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

insert into sakila.rental (rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)
values (16050, current_date, 1, 130, null, 1, current_date);
# rental_id can be empty as it's on autofill

select * from sakila.rental
order by rental_id desc
limit 10;

-- Use similar method to get `inventory_id`, `film_id`, and `staff_id`.

-- 9. Delete non-active users, but first, create a _backup table_ `deleted_users` to store `customer_id`, `email`, and the `date` for the users that would be deleted. Follow these steps:
--    - Check if there are any non-active users
--    - Create a table _backup table_ as suggested
--    - Insert the non active users in the table _backup table_
--    - Delete the non active users from the table _customer_
select * from sakila.customer
where active = 0;

drop table if exists deleted_users;

create table sakila.deleted_users (
customer_id int unique not null,
email varchar(255) unique not null,
delete_date date
);

insert into sakila.deleted_users
select customer_id, email, curdate()
from sakila.customer
where active = 0;

select * from sakila.deleted_users;
