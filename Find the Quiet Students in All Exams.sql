# Write your MySQL query statement below
WITH Exam2 AS(
SELECT
    exam_id,
    MIN(score) AS min_score,
    MAX(score) AS max_score
FROM
    Exam
GROUP BY
    exam_id
),

Exam3 AS(
SELECT
    DISTINCT student_id
FROM
    Exam E1
    JOIN
        Exam2 E2
    ON E1. exam_id = E2.exam_id AND (score = min_score OR score = max_score)
)

SELECT
    DISTINCT E.student_id,
    student_name
FROM
    Exam E
    JOIN
        Student S
    ON E.student_id = S.student_id
WHERE
    E.student_id NOT IN (SELECT student_id FROM Exam3)
ORDER BY
    student_id;