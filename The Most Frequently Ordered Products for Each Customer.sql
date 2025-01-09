-- Option #1. It works, but it wasn't optimized.
# Write your MySQL query statement below
WITH Orders2 AS(
SELECT
    customer_id,
    product_id,
    COUNT(product_id) AS amount
FROM
    Orders
GROUP BY
    customer_id, product_id
),
Orders3 AS(
SELECT
    customer_id,
    product_id,
    DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY amount DESC) AS rnk
FROM
    Orders2
)

SELECT
    customer_id,
    O.product_id,
    product_name
FROM
    Orders3 O
    JOIN
        Products P
    ON O.product_id = P.product_id
WHERE
    rnk = 1;


-- Option #2. Optimized!
# Write your MySQL query statement below
WITH Orders2 AS(
SELECT
    customer_id,
    product_id,
    DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY COUNT(product_id) DESC) AS rnk
FROM
    Orders
GROUP BY
    customer_id, product_id
)

SELECT
    customer_id,
    O.product_id,
    product_name
FROM
    Orders2 O
    JOIN
        Products P
    ON O.product_id = P.product_id
WHERE
    rnk = 1;