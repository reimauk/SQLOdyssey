-- OPTION #1
# Write your MySQL query statement below
WITH Rates AS(
SELECT
    question_id,
    SUM(IF(action='answer',1,0)) / SUM(IF(action='show', 1, 0)) AS rate
FROM
    SurveyLog
GROUP BY
    question_id
ORDER BY
    rate DESC
),

Sorted_rates AS(
SELECT
    question_id,
    rate,
    DENSE_RANK() OVER (ORDER BY rate DESC, question_id ASC) AS rnk
FROM
    Rates
) 

SELECT
    question_id AS survey_log
FROM
    Sorted_rates
WHERE
    rnk = 1;


-- OPTION #2
SELECT
    question_id AS survey_log
FROM
    SurveyLog
GROUP BY
    question_id
ORDER BY
    SUM(IF(action='answer', 1, 0)) / SUM(IF(action='show', 1,0)) DESC,
    question_id ASC
LIMIT 1;