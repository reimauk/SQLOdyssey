# Write your MySQL query statement below
WITH Traffic2 AS(
SELECT
    user_id,
    MIN(activity_date) login_date
FROM
    Traffic
WHERE activity = 'login'
GROUP BY
    user_id
)

SELECT
    login_date,
    COUNT(login_date) AS user_count
FROM
    Traffic2
WHERE
    login_date BETWEEN DATE_SUB('2019-06-30', INTERVAL 90 DAY) AND '2019-06-30' 
GROUP BY
    login_date;