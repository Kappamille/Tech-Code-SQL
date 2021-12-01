USE sql_store;
#Select - slide 34
SELECT * from customers;
SELECT birth_date from customers;
SELECT customer_id, first_name, last_name from customers;
SELECT customer_id, points from customers;
#Where - Slide 38
SELECT * from customers where city != 'paris';
SELECT * from customers where points > 1500;
SELECT * from customers where birth_date < '1986-10-25';
SELECT phone from customers where city != 'paris';
SELECT city from customers where points > 2000;
#AND-OR-NOT - Slide 42
Select * from products where unit_price >= 10 and unit_price <= 30;
SELECT * from customers where city = 'paris' and points>=1000;
SELECT address_name,postal_code from customers where postal_code = '75013' or postal_code ='75014';
select phone from customers where birth_date <= '1986-10-25' and birth_date >= '1966-10-25';
SELECT product_id from products where quantity_in_stock > 20 and quantity_in_stock <100;
select * from customers where (birth_date <= '1986-10-25' and birth_date >= '1966-10-25') and points >= 1000;
select * from customers where (birth_date <= '1986-10-25' and birth_date >= '1966-10-25') and not city = 'paris';
#BETWEEN - Slide 45
-- SELECT phone from customers where datediff(curdate(), birth_date) / 365 BETWEEN 35 AND 55;
select phone from customers where birth_date BETWEEN '1966-10-25' and '1986-10-25';
SELECT product_id from products where quantity_in_stock BETWEEN 20 and 100;
SELECT * from products where unit_price between 20 and 50;
-- SELECT first_name from customers where first_name between 'A' and 'M';
-- Between inclut les valeurs

#IN
SELECT * from customers where city in ('paris', 'lyon', 'grenoble');
Select name, unit_price from products where unit_price in (15.99, 19.99, 29.99);
SELECT name, product_id, quantity_in_stock from products where quantity_in_stock in (0, 1, 2, 3);
select * from customers where postal_code in ('75005', '75006', '75007', '75015', '75014', '75013');
#IS NULL/NOT NULL 
SELECT * from customers where phone is null;
SELECT * from customers where phone is not null;
SELECT * from orders where shipped_date is not null;
#Exercices globaux - Slide 52
SELECT * from customers where birth_date between '1966-10-25' and '1986-10-25' and city in ('Paris', 'lyon', 'grenoble');
SELECT * from products where unit_price > 25.0 and quantity_in_stock > 0;
SELECT first_name, phone from customers where birth_date is null;
SELECT first_name, address_number from customers where points > 1500 and city != "paris";
#AS - Slide 55
SELECT concat(address_number, ' ', address_name, ' ', postal_code) AS adresse from customers;
SELECT concat( first_name,  ' ', last_name,' ') AS nom from customers;
SELECT customer_id, concat(address_number, ' ', address_name, ' ', postal_code) AS adresse, concat( first_name,  ' ', last_name,' ') AS nom from customers; 
SELECT *, 0.05* quantity_in_stock AS prix_stockage from products;
#LIKE - Slide 59
SELECT * from customers where last_name LIKE "%y%" or last_name LIKE "%z%" or last_name like "%x%";
SELECT * from products where name NOT LIKE "%coussin%";
SELECT * from products where name LIKE "%housse%";
SELECT * from customers where first_name LIKE "%a%a%";
SELECT * from customers where first_name LIKE "_____a" or first_name LIKE "_____e" or first_name LIKE "_____i" or first_name LIKE "_____o" or first_name LIKE "_____u";
SELECT * from customers where phone LIKE "01%" or phone LIKE "02%" or phone LIKE "03%" or phone LIKE "04%" or phone LIKE "05%";
SELECT * from customers where phone LIKE "06%"  or phone LIKE "07%" or phone LIKE "08%" or phone LIKE "09%";
#REGEXP - SLIDE 62
SELECT * from customers where last_name regexp 'x|y|z';
SELECT * from products where name regexp 'housse|coussin';
SELECT * from customers where last_name regexp 'a$|e$|i$|o$|u$'; ## or SELECT * from customers where last_name regexp '(a|e|i|o|u)$';
SELECT * from customers where phone regexp '^0(1|2|3|4|5)';
SELECT * from customers where phone regexp '^0(6|7|8|9)';
#Exercices globaux - Slide 63
USE sql_pays;
SELECT * from countries where name like "Y%";
SELECT * from countries where name like "%y";
SELECT * from countries where name like "%x%";
SELECT * from countries where name like "%land";
SELECT * from countries where name like "C%ia";
SELECT * from countries where name like "%oo%";
SELECT * from countries where name like "%a%a%a";
SELECT * from countries where name like "_t%";
SELECT * from countries where name like "____";
SELECT * from countries where name = capital_city;
SELECT * from countries where population > 10000000;
SELECT * from countries where name like "%land" and population > 5000000;
SELECT * from countries where area < 1000000;
SELECT * from countries where population_density >100 and population_density < 500 and name regexp 'ai|en|am|al|ag';
#Order by - Slide 66
USE sql_store;
Select * from products order by name;
Select * from products order by unit_price;
Select * from products order by unit_price DESC;
Select * from customers order by points desc;
Select * from customers order by city, last_name;
#LIMIT - Slide 69
Select * from products order by unit_price LIMIT 10;
Select * from customers order by points LIMIT 5;
Select * from customers order by points desc LIMIT 1;
# Aggregate functions - Slide 80
SELECT count(*) from products where quantity_in_stock > 0;
SELECT count(*) from products where quantity_in_stock > 0 and name LIKE "%lin%";
SELECT count(*) from products where quantity_in_stock > 0 and name LIKE "%coton%";
SELECT count(*) from customers where phone is not null;
SELECT count(distinct postal_code) from customers;
SELECT count(distinct unit_price) from products;
SELECT max(unit_price) from products;
SELECT min(unit_price) from products;
SELECT max(quantity_in_stock) from products;
SELECT min(quantity_in_stock) from products;
SELECT avg(quantity_in_stock) from products;
SELECT avg(unit_price) from products;
#CASE - Slide 84
Select *, 
CASE 
WHEN quantity_in_stock > 50 THEN "suffisant"
WHEN quantity_in_stock < 20 THEN "critique"
ELSE "normal"
END AS "stock_state"
From products;

Select *, 
CASE 
WHEN city = 'paris' THEN points*0.8
WHEN city = 'grenoble' or city = 'lyon' THEN points*0.9
ELSE points
END AS "adapted_points"
From customers;

#Exercice globaux - Sldie 90
SELECT order_id, SUM(quantity) as item_numbers
from order_items
group by order_id
having item_numbers > 4;

SELECT status, count(status)
from orders
group by status;

SELECT product_id, COUNT(order_id)
from order_items
group by product_id;

SELECT * from products
where unit_price > (select avg(unit_price) from products);

SELECT city, count(customer_id) from customers
group by city;

Select *, 
CASE 
WHEN name LIKE "%lin%" THEN 'lin'
WHEN name LIKE "%coton%" THEN 'coton'
ELSE ""
END 
From products;

SELECT order_id, SUM(quantity) as item_numbers
from order_items
group by order_id
order by item_numbers desc;

SELECT * from customers
where points >1000
order by last_name, first_name;

SELECT * from customers
order by city, points desc;

SELECT avg(quantity_in_stock) from products
where quantity_in_stock > 10;

