# Write your MySQL query statement below

WITH RECURSIVE Managers AS(
SELECT
    employee_id,
    manager_id
FROM
    Employees
WHERE
    manager_id = 1

UNION
SELECT
    E.employee_id,
    E.manager_id
FROM
    Employees E
    JOIN
        Managers M
    ON E.manager_id = M.employee_id
)

SELECT
    DISTINCT employee_id
FROM
    Managers
WHERE
    employee_id != 1
ORDER BY
    employee_id;