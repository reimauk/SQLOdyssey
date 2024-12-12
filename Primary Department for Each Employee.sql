Table: Employee

+---------------+---------+
| Column Name   |  Type   |
+---------------+---------+
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |
+---------------+---------+
(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.
 

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-------------+---------------+--------------+
| employee_id | department_id | primary_flag |
+-------------+---------------+--------------+
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |
+-------------+---------------+--------------+
Output: 
+-------------+---------------+
| employee_id | department_id |
+-------------+---------------+
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |
+-------------+---------------+
Explanation: 
- The Primary department for employee 1 is 1.
- The Primary department for employee 2 is 1.
- The Primary department for employee 3 is 3.
- The Primary department for employee 4 is 3.

| employee_id | department_id | primary_flag | employee_id | department_id | number_of_department |
| ----------- | ------------- | ------------ | ----------- | ------------- | -------------------- |
| 1           | 1             | N            | 1           | 1             | 1                    |
| 2           | 1             | Y            | 2           | 1             | 2                    |
| 2           | 2             | N            | 2           | 1             | 2                    |
| 3           | 3             | N            | 3           | 3             | 1                    |
| 4           | 2             | N            | 4           | 2             | 3                    |
| 4           | 3             | Y            | 4           | 2             | 3                    |
| 4           | 4             | N            | 4           | 2             | 3                    |


-- Option #1
# Write your MySQL query statement below
SELECT
    E2.employee_id,
    CASE
        WHEN number_of_department = 1
        THEN E2.department_id
        ELSE E1.department_id
    END AS department_id
FROM   
    Employee E1
    JOIN
    (
    SELECT
        employee_id,
        department_id,
        COUNT(department_id) AS number_of_department
    FROM
        Employee
    GROUP BY 1
    ) AS E2
    ON E1.employee_id = E2.employee_id
 WHERE
    primary_flag = 'Y' OR
    (primary_flag = 'N' AND number_of_department = 1)


-- Option #2
# Write your MySQL query statement below
SELECT
    E1.employee_id,
    E1.department_id
FROM   
    Employee E1
    JOIN
    (
    SELECT
        employee_id,
        COUNT(department_id) AS number_of_department
    FROM
        Employee
    GROUP BY 1
    ) AS E2
    ON E1.employee_id = E2.employee_id
 WHERE
    primary_flag = 'Y' OR
    (primary_flag = 'N' AND number_of_department = 1)


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