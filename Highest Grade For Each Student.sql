Table: Enrollments

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| course_id     | int     |
| grade         | int     |
+---------------+---------+
(student_id, course_id) is the primary key (combination of columns with unique values) of this table.
grade is never NULL.
 

Write a solution to find the highest grade with its corresponding course for each student. In case of a tie, you should find the course with the smallest course_id.

Return the result table ordered by student_id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Enrollments table:
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 2          | 2         | 95    |
| 2          | 3         | 95    |
| 1          | 1         | 90    |
| 1          | 2         | 99    |
| 3          | 1         | 80    |
| 3          | 2         | 75    |
| 3          | 3         | 82    |
+------------+-----------+-------+
Output: 
+------------+-------------------+
| student_id | course_id | grade |
+------------+-----------+-------+
| 1          | 2         | 99    |
| 2          | 2         | 95    |
| 3          | 3         | 82    |
+------------+-----------+-------+


-- Option #1
# Write your MySQL query statement below
WITH Max_grade AS(
SELECT
    student_id,
    MAX(grade) AS max_grade    
FROM
    Enrollments
GROUP BY
    student_id
ORDER BY
    student_id
)

SELECT
    E.student_id,
    MIN(course_id) AS course_id,
    MAX(max_grade) AS grade
FROM
    Max_grade M
    JOIN
        Enrollments E
    ON M.student_id = E.student_id AND grade = max_grade
GROUP BY
    E.student_id
ORDER BY
    E.student_id;