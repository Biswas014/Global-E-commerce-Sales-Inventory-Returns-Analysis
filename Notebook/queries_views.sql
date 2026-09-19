--creating views
CREATE VIEW dim_customers AS(
 SELECT customer_id, 
	first_name,	
	last_name,
	age,
	gender,	
	country,
	registration_date,
	currency,
	is_premium,	
	email_verified
FROM customers
)

--SELECT * FROM dim_customers
---------------------
CREATE VIEW dim_products AS
SELECT  product_id, 
	    name AS product_name,	
	    category, 
		brand,
		unit_cost_usd,	
		unit_price_usd,
		is_active,	
		launch_date
FROM products;

-----------------------
CREATE VIEW dim_inventory AS
SELECT  product_id,
		stock_units,
		reorder_point,
		warehouse_location,
		last_restock_date,
		supplier_lead_days
FROM inventory;

select * from inventory
--------------
select * from transactions

CREATE VIEW fact_sales AS
SELECT  transaction_id,
	    customer_id,
		product_id,
		date as order_date, 
		quantity as sales_unit,
		unit_price_usd,
		discount_pct,
		shipping_cost_usd,
		channel,
		payment_method,
		status
FROM transactions;
-----------

CREATE VIEW dim_returns AS
 SELECT return_id,
      transaction_id,
	  customer_id,
	  product_id,
	  return_date,
	  reason,
	  refund_amount_usd,
	  restocked
 FROM returns;
-----------------

--creating a calendar table

CREATE VIEW dim_calendar AS
  SELECT DATE(GENERATE_SERIES(first_order_date :: DATE,
   						last_order_date :: DATE,
						'1 DAY' :: INTERVAL
    ))
  FROM(
        SELECT MAX(DATE) AS last_order_date,
		      MIN(DATE) AS first_order_date
	    FROM transactions
  )