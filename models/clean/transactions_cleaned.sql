WITH raw_transations AS (
    SELECT 
        *
    FROM 
        {{ source('transactions', 'transactions') }}
)

SELECT
    *,
    CASE
        WHEN date BETWEEN '2024-01-01' AND '2024-03-31' 
            THEN '2024-01-01' 
        WHEN date BETWEEN '2024-04-01' AND '2024-06-30' 
            THEN '2024-04-01' 
        WHEN date BETWEEN '2024-07-01' AND '2024-09-30' 
            THEN '2024-07-01' 
        WHEN date BETWEEN '2024-10-01' AND '2024-12-31' 
            THEN '2024-10-01' 
    END as quarter
FROM raw_transations