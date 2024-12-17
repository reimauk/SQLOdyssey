Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+


-- Option #1
# Write your MySQL query statement below
WITH Two_salaries AS(
SELECT
    DISTINCT salary
FROM
    Employee
ORDER BY
    salary DESC
LIMIT 2
)

SELECT
    IF ((SELECT COUNT(*) FROM Employee) < 2 OR MAX(salary) = MIN(salary), NULL, MIN(salary)) AS SecondHighestSalary
FROM
    Two_salaries
ORDER BY SecondHighestSalary
    ASC
LIMIT 1;


-- Option #2
# Write your MySQL query statement below
WITH Two_salaries AS(
SELECT
    DISTINCT salary
FROM
    Employee
ORDER BY
    salary DESC
LIMIT 2
)

SELECT
    IF ((SELECT COUNT(*) FROM Employee) < 2 OR MAX(salary) = MIN(salary), NULL, MIN(salary)) AS SecondHighestSalary
FROM
    Two_salaries;


-- Option #3
SELECT
    IFNULL(
        (SELECT
            DISTINCT salary
        FROM
            Employee
        ORDER BY
            salary DESC
        LIMIT 1 OFFSET 1
        ),
        NULL)
    AS SecondHighestSalary
