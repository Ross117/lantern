WITH raw_transations AS (
    SELECT 
        *
    FROM 
        {{ source('transactions', 'transactions') }}
), 
    dim_company AS (
        SELECT
            *
        FROM
            {{ ref('dim_company') }}
    )

SELECT
    c.current_company_name AS company,
    t.date,
    CASE
        WHEN t.date BETWEEN '2024-01-01' AND '2024-03-31' 
            THEN '2024-01-01' 
        WHEN t.date BETWEEN '2024-04-01' AND '2024-06-30' 
            THEN '2024-04-01' 
        WHEN t.date BETWEEN '2024-07-01' AND '2024-09-30' 
            THEN '2024-07-01' 
        WHEN t.date BETWEEN '2024-10-01' AND '2024-12-31' 
            THEN '2024-10-01' 
    END as quarter,
    t.transaction_type,
    t.amount,
    t.number
FROM raw_transations t
INNER JOIN dim_company c
    ON t.company = c.previous_company_name