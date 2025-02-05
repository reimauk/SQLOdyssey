# Write your MySQL query statement below
WITH Sales2 AS(
SELECT
    LOWER(TRIM(product_name)) AS product_name,
    DATE_FORMAT(sale_date, '%Y-%m') AS sale_date
FROM
    Sales
)

SELECT
    product_name,
    sale_date,
    COUNT(product_name) AS total
FROM
    Sales2
GROUP BY
    product_name, sale_date
ORDER BY
    product_name, sale_date;