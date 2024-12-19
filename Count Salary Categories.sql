Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.


-- Option #1
# Write your MySQL query statement below
With Caterogies AS(
SELECT
    account_id,
    CASE
        WHEN income < 20000
            THEN 'Low Salary'
        WHEN income >= 20000 AND income <= 50000
            THEN 'Average Salary'
        ELSE 'High Salary'
    END AS category,
    IF(income < 20000, 1, 0) AS low_salary,
    IF(income >= 20000 AND income <= 50000, 1, 0) AS average_salary,
    IF(income < 20000, 1, 0) AS high_salary
FROM
    Accounts
),

AllCategories AS(
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)

SELECT
    AC.category AS category,
    COUNT(C.category) AS accounts_count
FROM
    Caterogies C
    RIGHT JOIN
        AllCategories AC
    ON C.category = AC.category
GROUP BY category;


-- Option #2
# Write your MySQL query statement below
With Caterogies AS(
SELECT
    account_id,
    CASE
        WHEN income < 20000
            THEN 'Low Salary'
        WHEN income >= 20000 AND income <= 50000
            THEN 'Average Salary'
        ELSE 'High Salary'
    END AS category
FROM
    Accounts
),

AllCategories AS(
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)

SELECT
    AC.category AS category,
    COUNT(C.category) AS accounts_count
FROM
    Caterogies C
    RIGHT JOIN
        AllCategories AC
    ON C.category = AC.category
GROUP BY category;


-- Option #3
# Write your MySQL query statement below
With Caterogies AS(
SELECT
    account_id,
    CASE
        WHEN income < 20000
            THEN 'Low Salary'
        WHEN income > 50000
            THEN 'High Salary'
        ELSE 'Average Salary'
    END AS category
FROM
    Accounts
),

AllCategories AS(
    SELECT 'Low Salary' AS category
    UNION ALL
    SELECT 'Average Salary'
    UNION ALL
    SELECT 'High Salary'
)

SELECT
    AC.category AS category,
    COUNT(C.category) AS accounts_count
FROM
    Caterogies C
    RIGHT JOIN
        AllCategories AC
    ON C.category = AC.category
GROUP BY category;


-- Option #4
# Write your MySQL query statement below
SELECT 
    'Low Salary' AS category,
    SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS accounts_count
FROM 
    Accounts
    
UNION
SELECT  
    'Average Salary' category,
    SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END) 
    AS accounts_count
FROM 
    Accounts

UNION
SELECT 
    'High Salary' category,
    SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS accounts_count
FROM 
    Accounts

-- Option #5
SELECT
    'Low Salary' AS category,
    SUM(income < 20000) AS accounts_count
FROM
    Accounts

UNION
SELECT
    'Average Salary' AS category,
    SUM(income >= 20000 AND income <= 50000) AS accounts_count
FROM
    Accounts

UNION
SELECT
    'High Salary' AS category,
    SUM(income > 50000) AS accounts_count
FROM
    Accounts