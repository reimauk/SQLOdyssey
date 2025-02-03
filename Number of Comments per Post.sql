-- OPTION #2 (from GPT)
SELECT
    S1.sub_id AS post_id,
    COUNT(DISTINCT S2.sub_id) AS number_of_comments
FROM
    Submissions S1
    LEFT JOIN
        Submissions S2
    ON S1.sub_id = S2.parent_id
WHERE
    S1.parent_id IS NULL
GROUP BY
    S1.sub_id
ORDER BY
    S1.sub_id;


-- OPTION #1
# Write your MySQL query statement below
WITH Posts AS(
SELECT
    DISTINCT sub_id
FROM
    Submissions
WHERE
    parent_id IS NULL
),

Submissions2 AS(
SELECT
    sub_id,
    parent_id
FROM
    Submissions
WHERE parent_id IS NOT NULL
GROUP BY
    sub_id, parent_id
)

SELECT
    P.sub_id AS post_id,
    SUM(IF(S.parent_id IS NULL, 0, 1)) AS number_of_comments
FROM
    Posts P
    LEFT JOIN
        Submissions2 S
    ON P.sub_id = S.parent_id
GROUP BY
    P.sub_id
ORDER BY
    p.sub_id;