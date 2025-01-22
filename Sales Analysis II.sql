# Write your MySQL query statement below
WITH Buy_iPhone AS(
SELECT
    buyer_id
FROM
    Sales S
    JOIN
        Product P
    ON S.product_id = P.product_id
WHERE
    product_name = 'iPhone'
)

SELECT
    DISTINCT buyer_id
FROM
    Sales S
    JOIN
        Product P
    ON S.product_id = P.product_id
WHERE
    product_name = 'S8' AND
    buyer_id NOT IN (SELECT buyer_id FROM Buy_iPhone);