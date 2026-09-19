--CREATING TABLES
--1. Customers
DROP TABLE IF EXISTS customers;
CREATE TABLE customers(
    customer_id	VARCHAR(20) PRIMARY KEY,
	first_name	VARCHAR(10),
	last_name	VARCHAR(10),
	country	VARCHAR(20),
	currency	VARCHAR(5),
	age	SMALLINT,
	gender	VARCHAR(10),
	registration_date	DATE,
	is_premium	BOOLEAN,
	email_verified	BOOLEAN,
	email	VARCHAR(50)

);

--2.products
DROP TABLE IF EXISTS products;
CREATE TABLE products(
    product_id	VARCHAR(20) PRIMARY KEY,
	name	VARCHAR(40),
	category	VARCHAR(20),
	brand	VARCHAR(20),
	unit_price_usd	DECIMAL(10,2),
	unit_cost_usd	DECIMAL(10,2),
	weight_kg	DECIMAL(5,2),
	is_active	BOOLEAN,
	launch_date	DATE
)

--3. inventory
DROP TABLE IF EXISTS inventory;
CREATE TABLE inventory(
	 product_id	VARCHAR(20) PRIMARY KEY,
	category	VARCHAR(20),
	stock_units	SMALLINT,
	reorder_point	SMALLINT,
	warehouse_location	VARCHAR(20),
	last_restock_date	DATE,
	supplier_lead_days SMALLINT
);

--4. transactions
DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions(
	 transaction_id	VARCHAR(20) PRIMARY KEY,
	customer_id	VARCHAR(20) REFERENCES customers(customer_id),
	product_id	VARCHAR(20) REFERENCES products(product_id),
	date	DATE,
	quantity	SMALLINT,
	unit_price_usd	DECIMAL(10,2),
	discount_pct	DECIMAL(10,2),
	revenue_usd	DECIMAL(10,2),
	cost_usd	DECIMAL(10,2),
	profit_usd	DECIMAL(10,2),
	shipping_cost_usd	DECIMAL(10,2),
	channel	VARCHAR(20),
	payment_method	VARCHAR(20),
	status	VARCHAR(20),
	country	VARCHAR(20),
	category	VARCHAR(20)

)

--5.returns
DROP TABLE IF EXISTS returns;
CREATE TABLE returns(
    return_id	VARCHAR(20) PRIMARY KEY,
	transaction_id	VARCHAR(20) REFERENCES transactions(transaction_id),
	customer_id	VARCHAR(20) REFERENCES customers(customer_id),
	product_id	VARCHAR(20) REFERENCES products(product_id),
	return_date	DATE,
	reason	VARCHAR(30),
	refund_amount_usd	DECIMAL(10,2),
	restocked	BOOLEAN
)

--6. price_history
DROP TABLE IF EXISTS price_history;
CREATE TABLE price_history(
     product_id	VARCHAR(20) REFERENCES products(product_id),
	category	VARCHAR(20),
	year_month	VARCHAR(20),
	listed_price_usd	DECIMAL(10,2),
	base_price_usd	DECIMAL(10,2),
	competitor_price_usd	DECIMAL(10,2),
	price_index	DECIMAL(10,2),
	is_promotional	BOOLEAN,
	price_elasticity	DECIMAL(5,2),
	units_sold	SMALLINT,
	revenue_usd	DECIMAL(10,2),
	margin_pct	DECIMAL(5,2)
)

-- INSERTING DATA INTO TABLES
--customers
COPY customers
FROM 'E:\Projects\Portfolio_Projects\sql, power bi\Global_ecommerce & suplly chain database\customers.csv'
DELIMITER ','
CSV HEADER;

-- SELECT * FROM customers;

--products
COPY products
FROM 'E:\Projects\Portfolio_Projects\sql, power bi\Global_ecommerce & suplly chain database\products.csv'
DELIMITER ','
CSV HEADER;

-- SELECT * FROM products;

--inventory
COPY inventory
FROM 'E:\Projects\Portfolio_Projects\sql, power bi\Global_ecommerce & suplly chain database\inventory.csv'
DELIMITER ','
CSV HEADER;

-- SELECT * FROM inventory;

--transactions
COPY transactions
FROM 'E:\Projects\Portfolio_Projects\sql, power bi\Global_ecommerce & suplly chain database\transactions.csv'
DELIMITER ','
CSV HEADER;

-- SELECT * FROM transactions;

--RETURNS
COPY returns
FROM 'E:\Projects\Portfolio_Projects\sql, power bi\Global_ecommerce & suplly chain database\returns.csv'
DELIMITER ','
CSV HEADER;

-- SELECT * FROM returns;

--PRICE_HISTORY
COPY price_history
FROM 'E:\Projects\Portfolio_Projects\sql, power bi\Global_ecommerce & suplly chain database\price_history.csv'
WITH (FORMAT csv, DELIMITER ',', HEADER);

-- SELECT * FROM price_history;