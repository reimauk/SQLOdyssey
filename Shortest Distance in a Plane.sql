# Write your MySQL query statement below
SELECT
    ROUND(MIN(SQRT(POW(P1.x - P2.x, 2) + POW(P1.y - P2.y, 2))), 2) AS shortest
FROM
    Point2D P1
    JOIN
        Point2D P2
    ON P1.x != P2.x OR P1.y != P2.y