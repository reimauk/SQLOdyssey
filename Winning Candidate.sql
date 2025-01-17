# Write your MySQL query statement below
WITH Winner AS(
SELECT
    candidateId,
    COUNT(candidateId) AS voted
FROM
    Vote V
GROUP BY
    candidateId
ORDER BY
    voted DESC
LIMIT 1
)

SELECT
    name
FROM
    Winner
    JOIN
        candidate
    ON id = candidateId;