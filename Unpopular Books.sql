# Write your MySQL query statement below
SELECT
    B.book_id,
    name
FROM
    Books B
    LEFT JOIN
        Orders O
    ON O.book_id = B.book_id
WHERE
    available_from < '2019-05-24'
GROUP BY
    B.book_id
    HAVING SUM(IF(quantity IS NULL OR dispatch_date < '2018--6-24', 0, quantity)) < 10;