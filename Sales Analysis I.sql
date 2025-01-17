# Write your MySQL query statement below
WITH Sales2 AS(
SELECT
    seller_id,
    SUM(price) sales
FROM
    Sales
GROUP BY
    seller_id
)

SELECT
    seller_id
FROM
    Sales2
WHERE
    sales = (SELECT MAX(sales) FROM Sales2);