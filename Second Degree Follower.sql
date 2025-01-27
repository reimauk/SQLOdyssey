# Write your MySQL query statement below
SELECT
    DISTINCT followee AS follower,
    COUNT(followee) AS num
FROM
    Follow
WHERE
    followee IN (SELECT follower FROM Follow)
GROUP BY
    followee
ORDER BY
    follower;