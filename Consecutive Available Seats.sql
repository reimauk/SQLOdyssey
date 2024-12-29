Table: Cinema

+-------------+------+
| Column Name | Type |
+-------------+------+
| seat_id     | int  |
| free        | bool |
+-------------+------+
seat_id is an auto-increment column for this table.
Each row of this table indicates whether the ith seat is free or not. 1 means free while 0 means occupied.
 

Find all the consecutive available seats in the cinema.

Return the result table ordered by seat_id in ascending order.

The test cases are generated so that more than two seats are consecutively available.

The result format is in the following example.

 

Example 1:

Input: 
Cinema table:
+---------+------+
| seat_id | free |
+---------+------+
| 1       | 1    |
| 2       | 0    |
| 3       | 1    |
| 4       | 1    |
| 5       | 1    |
+---------+------+
Output: 
+---------+
| seat_id |
+---------+
| 3       |
| 4       |
| 5       |
+---------+


-- Option #1
# Write your MySQL query statement below
SELECT
    C1.seat_id
FROM
    Cinema C1
    LEFT JOIN
        Cinema C2
    ON C1.seat_id = C2.seat_id - 1
        LEFT JOIN
            Cinema C3
        ON C1.seat_id = C3.seat_id + 1    
WHERE
   (SELECT COUNT(*) FROM Cinema) > 1 AND
   ((C1.free = 1 AND C2.free = 1)
   OR (C1.free = 1 AND C3.free = 1));

-- Option #2
# Write your MySQL query statement below
SELECT
    C1.seat_id
FROM
    Cinema C1
    LEFT JOIN
        Cinema C2
    ON C1.seat_id = C2.seat_id - 1
        LEFT JOIN
            Cinema C3
        ON C1.seat_id = C3.seat_id + 1    
WHERE
   ((C1.free = 1 AND C2.free = 1)
   OR (C1.free = 1 AND C3.free = 1));


-- Option #3
# Write your MySQL query statement below
SELECT
    DISTINCT C1.seat_id
FROM
    Cinema C1
    JOIN
        Cinema C2
    ON ((C1.seat_id - C2.seat_id = 1) OR (C2.seat_id - C1.seat_id = 1))
    AND (C1.free = 1 AND C2.free = 1)
ORDER BY C1.seat_id;


-- Option #4
# Write your MySQL query statement below
SELECT
    DISTINCT C1.seat_id
FROM
    Cinema C1
    JOIN
        Cinema C2
    ON (C1.seat_id - C2.seat_id = 1 OR C2.seat_id - C1.seat_id = 1)
    AND C1.free = 1 AND C2.free = 1
ORDER BY C1.seat_id;


-- Option #5
-- Option #4
# Write your MySQL query statement below
SELECT
    DISTINCT C1.seat_id
FROM
    Cinema C1
    JOIN
        Cinema C2
    ON ABS(C1.seat_id - C2.seat_id) = 1
    AND C1.free = 1 AND C2.free = 1
ORDER BY C1.seat_id;


| seat_id | free | seat_id | free |
| ------- | ---- | ------- | ---- |
| 1       | 1    | 2       | 0    |
| 2       | 0    | 1       | 1    |
| 2       | 0    | 3       | 1    |
| 3       | 1    | 2       | 0    |
| 3       | 1    | 4       | 1    |
| 4       | 1    | 3       | 1    |
| 4       | 1    | 5       | 1    |
| 5       | 1    | 4       | 1    |


| seat_id | free | seat_id | free |
| ------- | ---- | ------- | ---- |
| 2       | 0    | 1       | 1    |
| 3       | 1    | 2       | 0    |
| 4       | 1    | 3       | 1    |
| 5       | 1    | 4       | 1    |