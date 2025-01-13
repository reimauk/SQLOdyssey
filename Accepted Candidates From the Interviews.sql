# Write your MySQL query statement below
WITH Rounds2 AS(
SELECT
    interview_id,
    SUM(score) AS all_score
FROM
    Rounds
GROUP BY
    interview_id
)

SELECT
    candidate_id
FROM
    Candidates C
    JOIN
        Rounds2 R
    ON C.interview_id = R.interview_id
WHERE
    years_of_exp >= 2
    AND all_score > 15;