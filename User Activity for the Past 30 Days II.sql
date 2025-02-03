# Write your MySQL query statement below
WITH Sessions AS(
SELECT
    user_id,
    session_id,
    COUNT(activity_type) AS amount
FROM
    Activity
WHERE
    activity_date BETWEEN '2019-06-28' AND '2019-07-27'
GROUP BY
    user_id, session_id
)


SELECT
    IFNULL(ROUND(COUNT(user_id) / COUNT(DISTINCT user_id), 2), 0) AS average_sessions_per_user
FROM
    Sessions;