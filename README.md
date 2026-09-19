# Global-E-commerce-Sales-Inventory-Returns-Analysis
An interactive power bi report analyzing yearly sales, inventory, and returns performance to identify revenue drivers, customer purchasing patterns, return trends, and potential inventory stockout risks.

## Tech Stack
I have used these tools or technologies to accomplish the report

PostgreSQL: Data import, validation, and exploratory analysis 

Power Bi Desktop: Data modelling, visualization and dashboard development

Dax: Aggregation, Time Intelligence Measures and KPI Calculations

## Data Source
[Kaggle](https://www.kaggle.com/datasets/parsakh/global-e-commerce-and-supply-chain-database?select=transactions.csv)

A global e-commerce retail dataset containing approximately 100,000 transactions from 2022 to 2024, sourced from Kaggle The dataset includes customer demographics, products information, inventory levels, returns, transaction details, shipping locations, and order status.

## Highlights
### Business Problem
The business operates across multiple products, customer segments, and warehouses, making it difficult to identify where performance is strong, where operational risks exist, and which areas require closer investigation.

Business Questions Answered

• How have revenue, gross profit and return rates changed year over year?

•	Which products generate the highest revenue and gross margin, and how do they compare with the performance of their product categories?

•	How does premium customer behavior differ from non-premium customers in terms of order value, and return rates?

•	What are the most common return reasons and how do they vary across product categories?

•	Which products are at risk of stockout before the next replenishment arrives, and which warehouses hold the highest number of at-risk products?

•	How does discounting affect sales volume and gross margin?

### Key findings
💡Generated approximately $53M in revenue across 2022-2024, with 2024 contributing $17M, a 0.3% increase from 2023.

💡Return rate remained largely stable year over year, declining from 7.10% to 7.09%.

💡Electronics was the highest-revenue category in 2024 at approximately $8M, with several of the top-performing products belonging to the category.

💡non-premium customers’ order value were more than the premium ones but the gap was very less Return rates for both of them were between 6- 8%.

💡Higher discount levels did not correspond to higher sales volume in the observed data. The 0–5% discount range accounted for a substantial share of sales volume while maintaining stronger gross-margin contribution.

💡 “Defective” and “Not as described” were the two leading return reasons across product categories, together accounting for the majority of returns.

💡416 of 500 products (83.2%) had fewer days of stock remaining than their expected lead time, indicating potential stockout risk. However, only 12% had already fallen below their reorder threshold.

## Business Impact
The findings highlight two areas requiring closer operational attention: inventory availability and product returns. Monitoring replenishment lead times alongside supplier performance can help reduce potential stockout exposure, while further investigation into product quality, fulfillment, and listing accuracy can help identify opportunities to address recurring return issues.

## Project Workflow

**Understanding the business**: Defined the business context, identified relevant analytical questions, and established the key metrics required to evaluate performance.

**SQL, Data Cleaning & Exploration**: Imported fact and dimension tables into PostgreSQL, validated data quality, checked for nulls and inconsistencies, evaluated derived columns, and created structured views containing the required fields for analysis

**Power BI, Dashboard Design**: Designed a three-page report with consistent navigation across sales, customer, inventory, and returns analysis.


##Dashboard Structure

**Performance Overview**
Revenue, transactions, gross profit, and return rate with year-over-year comparisons; top products and categories by revenue and margin; and revenue contribution by sales channel.

**Customer Behavior**
Average order value and return rates across premium and non-premium customers; discount levels versus sales volume and margin; revenue by customer location; and payment-type contribution to revenue.

**Inventory & Returns Risk**
Return reasons by product category; returned products resulting in write-offs; products at or below reorder thresholds; and products and warehouses exposed to stockout risk based on remaining stock versus replenishment lead time.

## Sample SQL: Creating structured views

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
