# Write your MySQL query statement below
SELECT
    Q.id,
    Q.year,
    IFNULL(N.npv, 0) AS npv
FROM
    Queries Q
    LEFT JOIN
        NPV N
    ON N.id = Q.id AND N.year = Q.year
GROUP BY
    Q.id, Q.year;