
-- OPTION #1 Code without comments

# Write your MySQL query statement below
WITH RECURSIVE DateRange AS(
SELECT
    '2019-01-01' AS date
UNION ALL
SELECT
    DATE_ADD(date, INTERVAL 1 DAY)
FROM
    DateRange
WHERE
    date < '2019-12-31'
),

DailyStatus AS(
SELECT
    date,
    CASE
        WHEN fail_date IS NOT NULL
            THEN 'failed'
        WHEN success_date IS NOT NULL
            THEN 'succeeded'
        ELSE 'unkown' 
    END AS period_state
FROM
    DateRange D
    LEFT JOIN
        Failed F
    ON date = fail_date
    LEFT JOIN
        Succeeded S
    ON date = success_date
WHERE
    date BETWEEN '2019-01-01' AND '2019-12-31'
),

StatusGroups AS(
SELECT
    date,
    period_state,
    ROW_NUMBER() OVER (ORDER BY date) - 
        ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY date) AS grp
FROM
    DailyStatus
)

SELECT
    period_state,
    MIN(date) AS start_date,
    MAX(date) AS end_date
FROM
    StatusGroups
WHERE
    period_state != 'unkown'
GROUP BY
    period_state, grp
ORDER BY
    start_date;



-- OPTION #2. The same code with comments

WITH RECURSIVE DateRange AS (
    -- Начальный запрос для рекурсивного CTE: начинаем с самой первой даты, 2019-01-01.
    SELECT DATE('2019-01-01') AS date
    UNION ALL
    -- Рекурсивное добавление дней, увеличиваем дату на 1 день на каждой итерации
    SELECT DATE_ADD(date, INTERVAL 1 DAY)
    FROM DateRange
    -- Условие остановки: ограничиваем даты 2019-12-31
    WHERE date < '2019-12-31'
),

DailyStatus AS (
    -- Определяем статус задач для каждой даты в 2019 году, используя таблицу DateRange
    SELECT 
        dr.date,
        -- Присваиваем статус 'failed' или 'succeeded' в зависимости от того, присутствует ли дата в соответствующей таблице
        CASE 
            WHEN f.fail_date IS NOT NULL THEN 'failed'           -- Дата находится в таблице Failed
            WHEN s.success_date IS NOT NULL THEN 'succeeded'     -- Дата находится в таблице Succeeded
            ELSE 'unknown'                                       -- Дата отсутствует в обеих таблицах (на всякий случай)
        END AS period_state
    FROM DateRange dr
    -- LEFT JOIN с таблицей Failed по дате для получения провальных дней
    LEFT JOIN Failed f ON dr.date = f.fail_date
    -- LEFT JOIN с таблицей Succeeded по дате для получения успешных дней
    LEFT JOIN Succeeded s ON dr.date = s.success_date
    -- Убедимся, что мы работаем только в пределах 2019 года
    WHERE dr.date BETWEEN '2019-01-01' AND '2019-12-31'
),

StatusGroups AS (
    -- Присваиваем каждой дате группу для определения непрерывных интервалов одинакового состояния
    SELECT 
        date,
        period_state,
        -- Первое выражение ROW_NUMBER() OVER (ORDER BY date) присваивает уникальный номер каждой дате подряд, без разделения на состояния.
        ROW_NUMBER() OVER (ORDER BY date) AS overall_row,
        
        -- Второе выражение ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY date)
        -- присваивает номер каждой дате, но только внутри одного состояния (succeeded или failed).
        ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY date) AS state_row,
        
        -- Вычисляем разницу между двумя номерами. Эта разница останется постоянной для каждого непрерывного интервала одинакового состояния.
        -- Когда состояние меняется, разница тоже изменится, что создаст новый интервал (группу).
        ROW_NUMBER() OVER (ORDER BY date) - ROW_NUMBER() OVER (PARTITION BY period_state ORDER BY date) AS grp
    FROM DailyStatus
)

-- Финальный запрос для получения начальной и конечной даты каждого интервала
SELECT 
    period_state,
    MIN(date) AS start_date,    -- Определяем начальную дату для каждой группы одинакового состояния
    MAX(date) AS end_date       -- Определяем конечную дату для каждой группы одинакового состояния
FROM StatusGroups
WHERE period_state != 'unknown' -- Исключаем даты без состояния (unknown), если такие есть
GROUP BY period_state, grp      -- Группируем по состоянию и значению grp, чтобы выделить интервалы
ORDER BY start_date;            -- Сортируем по начальной дате для наглядности
