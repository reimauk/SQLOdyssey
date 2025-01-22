# Write your MySQL query statement below
WITH NotIn1Quarter AS(
SELECT
    S.product_id,
    product_name
FROM
    Sales S
    JOIN
        Product P
    ON S.product_id = P.product_id
WHERE
    sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31'
)

SELECT
    DISTINCT S.product_id,
    product_name
FROM
    Sales S
    JOIN
        Product P
    ON S.product_id = P.product_id
WHERE
    sale_date BETWEEN '2019-01-01' AND '2019-03-31'
    AND S.product_id NOT IN (SELECT product_id FROM NotIn1Quarter);