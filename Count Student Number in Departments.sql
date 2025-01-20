# Write your MySQL query statement below
WITH Student2 AS(
SELECT
    dept_id,
    COUNT(dept_id) AS student_number
FROM
    Student
GROUP BY
    dept_id
)

SELECT
    dept_name,
    IFNULL(student_number, 0) AS student_number
FROM
    Department D
    LEFT JOIN
        Student2 S
    ON D.dept_id = S.dept_id
ORDER BY
    student_number DESC,
    dept_name ASC;