# Write your MySQL query statement below

SELECT
    'bull' AS word,
    (SELECT
        SUM(content LIKE '% bull %')
    FROM
        Files
    ) AS count

UNION ALL
SELECT
    'bear' AS word,
    (SELECT
        SUM(content LIKE '% bear %')
    FROM
        Files
    ) AS count;