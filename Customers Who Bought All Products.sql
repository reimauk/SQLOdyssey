Table: Customer

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.
 

Table: Product

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.
 

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.


-- Option #1
# Write your MySQL query statement below
WITH Amount AS (
SELECT
    customer_id,
    COUNT(DISTINCT product_key) buying,
    (SELECT COUNT(*) FROM Product) AS product_all 
FROM
    Customer
GROUP BY
    customer_id
    HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)
)

SELECT
    customer_id
FROM
    Amount;


-- Option #2
# Write your MySQL query statement below
WITH Amount AS (
SELECT
    customer_id,
    COUNT(DISTINCT product_key)
FROM
    Customer
GROUP BY
    customer_id
    HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)
)

SELECT
    customer_id
FROM
    Amount