--checking duplicates and nulls
SELECT * FROM customers
  where  customer_id is null or
	first_name	is null or
	last_name	is null or
	country	is null or
	currency	is null or
	age	is null or
	gender	is null or
	registration_date	is null or
	is_premium	is null or
	email_verified	is null or
	email is null;


select customer_id,
     count(*)
from customers
group by customer_id
having count(*) >1

select registration_date from customers where registration_date is null
---------------------------
SELECT * FROM products

select count(distinct product_id),
      count(distinct name) 
from products

SELECT * FROM products
  where  product_id is null or
	  name	is null or
	  category is null or
	brand	is null or
	unit_price_usd	is null or
	unit_cost_usd	is null or
	weight_kg	is null or
	is_active	is null or
	launch_date	is null;
----------------
SELECT * FROM inventory

select product_id,
     count(*)
from inventory
group by product_id
having count(*) >1

SELECT * FROM inventory
  where  product_id is null or
	  category	is null or
	stock_units	is null or
	reorder_point	is null or
	warehouse_location	is null or
	last_restock_date	is null or
	supplier_lead_days	is null;
	
----------------
SELECT * FROM transactions;

select transaction_id,
     count(*)
from transactions
group by transaction_id
having count(*) >1

SELECT count(*) FROM transactions
  where  transaction_id is null or
	  customer_id	is null or
	product_id	is null or
	date	is null or
	quantity	is null or
	unit_price_usd	is null or
	discount_pct	is null or
	revenue_usd	is null or
	cost_usd is null or
	profit_usd is null or
	shipping_cost_usd is null or
	channel is null or
	payment_method is null or
	status is null or
	country is null or
	category is null;
	
-----------
SELECT * FROM returns;

select return_id,
     count(*)
from returns
group by return_id
having count(*) >1

select count(*)
from returns 
where return_id is null or
      transaction_id is null or
	  customer_id is null or
	  product_id is null or
	  return_date is null or
	  reason is null or
	  refund_amount_usd is null or
	  restocked is null
	
---------
select * from price_history

select product_id,
     count(*)
from price_history
group by product_id
having count(*) =1

SELECT * FROM price_history
  where  product_id	is null or
	category	is null or
	year_month	is null or
	listed_price_usd	is null or
	base_price_usd	is null or
	competitor_price_usd	is null or
	price_index	is null or
	is_promotional	is null or
	price_elasticity	is null or
	units_sold	is null or
	revenue_usd	is null or
	margin_pct	is null;

	
--check unneccessary columns respect to tables and verify them
--checking the date in customers tbl
select registration_date 
from customers
where LENGTH(registration_date :: TEXT) !=10

select distinct date_part('year',registration_date) from customers

SELECT MIN(registration_date), MAX(registration_date) FROM customers
---------------------
--checking the products no
(select count(distinct product_id) from inventory) = (select count(distinct product_id) from products)
----------------
--checking the launch date 
select launch_date 
from products
where LENGTH(launch_date :: TEXT) != 10

select distinct date_part('year',launch_date) from products
---------------------------
select product_id, reorder_point, stock_units 
from inventory 
where reorder_point > stock_units
--there are 40 products of which stock units are less than the reorder point
--------------------------
--checking the last restock date 
select last_restock_date 
from inventory
where LENGTH(last_restock_date :: TEXT) !=10

select distinct date_part('year',last_restock_date) 
from inventory
---------------------
select * from transactions


select distinct date_part('year',date) 
from transactions

select * from transactions

SELECT revenue_usd,
       ROUND(quantity * unit_price_usd * (1 - discount_pct),2)
from transactions
where (ROUND(quantity * unit_price_usd * (1 - discount_pct),2) - revenue_usd) > 0.01

--revenue comes from deducing discount from the price got by multipling unit price with quantity

select transaction_id,
       quantity,
	   cost_usd,
	   unit_price_usd,
	   revenue_usd,
	   profit_usd
from transactions
where profit_usd != (quantity * unit_price_usd * (1 - discount_pct)) - (quantity * cost_usd) 
-- profit column derived deducting revenue from product_cost

select t.transaction_id,
       t.product_id,
	   t.quantity,
	   p.unit_cost_usd,
	   t.cost_usd,
	   (p.unit_cost_usd * t.quantity) as new_cost
from transactions t
left join products p
on p.product_id = t.product_id
where p.product_id is not null and t.cost_usd != (p.unit_cost_usd * t.quantity)
-- cost_usd in transactions table is derived from multiplying the quantity by products unit cost


SELECT DISTINCT STATUS FROM TRANSACTIONS

select c.customer_id,tr.country, c.country
from transactions tr
left join customers c
on c.customer_id = tr.customer_id
where c.country is not null and tr.country != c.country
-- the customer home country and the delivery country are same

select *from transactions

select transaction_id,
     revenue_usd,
	 profit_usd,
	 revenue_usd - shipping_cost_usd - cost_usd
--------------------------
select * from returns
--checking the return_date
select return_date
from returns
where LENGTH(return_date :: TEXT) !=10
---------------------------
select * from PRICE_HISTORY
---------
