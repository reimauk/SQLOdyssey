# Write your MySQL query statement below
WITH Project2 AS(
SELECT
    project_id,
    COUNT(project_id) AS amount
FROM
    Project
GROUP BY
    project_id
)

SELECT
    project_id
FROM
    Project2
WHERE
    amount = (SELECT MAX(amount) FROM Project2);