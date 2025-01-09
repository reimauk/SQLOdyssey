
 # Write your MySQL query statement below
WITH UserVisits2 AS(
SELECT
    user_id,
    DATEDIFF(LEAD(visit_date, 1, '2021-1-1') OVER (PARTITION BY user_id ORDER BY visit_date), visit_date) AS date_diff
FROM
    UserVisits
)

SELECT
    user_id,
    MAX(date_diff) AS biggest_window
FROM
    UserVisits2
GROUP BY
    user_id;
