# Write your MySQL query statement below

WITH RECURSIVE Numbers AS(
SELECT
    1 AS n
UNION ALL
SELECT
    n + 1
FROM
    Numbers
WHERE n < (SELECT MAX(subtasks_count) FROM Tasks)
),

AllSubtasks AS(
SELECT
    task_id,
    N.n AS subtask_id
FROM
    Tasks T
    JOIN
        Numbers N
    ON N.n <= T.subtasks_count
ORDER BY
    task_id, subtask_id
)

SELECT
    A.task_id,
    A.subtask_id
FROM
    AllSubtasks A
    LEFT JOIN
        Executed E
    ON A.task_id = E.task_id AND A.subtask_id = E.subtask_id
WHERE
    E.subtask_id IS NULL
ORDER BY
    A.task_id, A.subtask_id;