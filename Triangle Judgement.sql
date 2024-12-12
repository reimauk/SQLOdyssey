Table: Triangle

+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
 

Report for every three line segments whether they can form a triangle.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Triangle table:
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
Output: 
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+


-- Option #1
# Write your MySQL query statement below
SELECT
    x,
    y,
    z,
    CASE
        WHEN (x + y > z) AND (x + z > y) AND (y + z > x)
        THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM
    Triangle


-- Option #2
# Write your MySQL query statement below
SELECT
    x,
    y,
    z,
    IF((x + y > z) AND (y + z > x) AND (x + z > y), 'Yes', 'No') AS triangle
FROM
    Triangle


-- Option #3
# Write your MySQL query statement below
WITH department_count AS
    (
    SELECT
        employee_id,
        COUNT(department_id) AS number_of_department
    FROM
        Employee
    GROUP BY 1
    )   

SELECT
    E.employee_id,
    department_id
FROM   
    Employee E
    JOIN
        department_count D
    ON E.employee_id = D.employee_id
 WHERE
    primary_flag = 'Y' OR
    number_of_department = 1;


-- Option #4
-- Write your PostgreSQL query statement below
WITH department_count AS
    (SELECT
        employee_id,
        COUNT(department_id) AS number_of_departments
    FROM
        Employee
    GROUP BY
        employee_id
    )

SELECT
    E.employee_id,
    department_id
FROM
    Employee E
    JOIN
        department_count D
    ON E.employee_id = D.employee_id
WHERE
    primary_flag = 'Y' OR
    number_of_departments = 1;


-- Option #5
/* Write your T-SQL query statement below */
WITH department_count AS
    (SELECT
        employee_id,
        COUNT(department_id) AS number_of_departments
    FROM
        Employee
    GROUP BY
        employee_id
    )

SELECT
    E.employee_id,
    department_id
FROM
    Employee E
    JOIN
        department_count D
    ON E.employee_id = D.employee_id
WHERE
    primary_flag = 'Y' OR
    number_of_departments = 1;


-- Option #6
/* Write your PL/SQL query statement below */
WITH department_count AS
    (SELECT
        employee_id,
        COUNT(department_id) AS number_of_departments
    FROM
        Employee
    GROUP BY
        employee_id
    )

SELECT
    E.employee_id,
    department_id
FROM
    Employee E
    JOIN
        department_count D
    ON E.employee_id = D.employee_id
WHERE
    primary_flag = 'Y' OR
    number_of_departments = 1;