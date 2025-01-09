Table: Logs

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| log_id        | int     |
+---------------+---------+
log_id is the column of unique values for this table.
Each row of this table contains the ID in a log Table.
 

Write a solution to find the start and end number of continuous ranges in the table Logs.

Return the result table ordered by start_id.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+------------+
| log_id     |
+------------+
| 1          |
| 2          |
| 3          |
| 7          |
| 8          |
| 10         |
+------------+
Output: 
+------------+--------------+
| start_id   | end_id       |
+------------+--------------+
| 1          | 3            |
| 7          | 8            |
| 10         | 10           |
+------------+--------------+
Explanation: 
The result table should contain all ranges in table Logs.
From 1 to 3 is contained in the table.
From 4 to 6 is missing in the table
From 7 to 8 is contained in the table.
Number 9 is missing from the table.
Number 10 is contained in the table.


-- Option #1 Partly works! (4 from 13 samples)
# Write your MySQL query statement below
WITH Logs_with_id AS(
SELECT
    log_id,
    ROW_NUMBER() OVER() AS id
FROM
    Logs
),

Logs2 AS(
SELECT
    L1.log_id,
    ROW_NUMBER() OVER() AS new_id
FROM
    Logs_with_id L1
    LEFT JOIN
        Logs_with_id L2
    ON L1.id = L2.id + 1
        LEFT JOIN
            Logs_with_id L3
        ON L1.id = L3.id - 1
WHERE L1.id = 1 OR L1.Log_id = (SELECT MAX(log_id) FROM Logs)
    OR NOT((L1.log_id - L2.log_id) = 1 AND (L3.log_id - L1.log_id) = 1)
),

Logs3 AS(
SELECT
    CASE WHEN MOD(new_id, 2) = 1 THEN log_id END AS start_id,
    CASE
        WHEN
            MOD(new_id, 2) = 0 OR log_id = (SELECT MAX(log_id) FROM Logs)
            THEN log_id
        END AS end_id,
    new_id
FROM
    Logs2
)

SELECT
    N1.start_id,
    CASE
        WHEN N2.end_id IS NULL
        THEN N1.end_id
        ELSE N2.end_id
    END AS end_id
FROM
    Logs3 N1
    LEFT JOIN
        Logs3 N2
    ON N1.new_id = N2.new_id-1
WHERE
    N1.start_id IS NOT NULL;


-- Option #2. It works!
WITH Grps AS(
SELECT
    log_id,
    log_id - ROW_NUMBER() OVER(ORDER BY log_id) AS grp
FROM
    Logs
)

SELECT
    MIN(log_id) AS start_id,
    MAX(log_id) AS end_id
FROM
    Grps
GROUP BY
    grp;