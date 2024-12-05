Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+

-- Option #1
# Write your MySQL query statement below
SELECT
    name
FROM
    (
    SELECT
        managerId AS manId,
        COUNT(managerId) AS number_of_employees
    FROM Employee
    GROUP BY 1
    ) AS managers_wih_5_employees
    INNER JOIN
        employee
    ON id = manId
WHERE number_of_employees >= 5;


-- Option #2
# Write your MySQL query statement below
SELECT
    name
FROM
    (
    SELECT
        managerId AS manId
    FROM Employee
    GROUP BY 1
        HAVING
            COUNT(managerId) >= 5
    ) AS managers_wih_5_employees
    INNER JOIN
        employee
    ON id = manId;