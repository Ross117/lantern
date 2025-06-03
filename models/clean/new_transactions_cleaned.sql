WITH new_transactions AS (
    SELECT
        *
    FROM
        {{ source('transactions', 'new_transactions') }}
), 
    dim_company AS (
        SELECT
            *
        FROM
            {{ ref('dim_company') }}
    )

SELECT
    c.company_id,
    Company AS company,
    date,
    CASE
        WHEN date BETWEEN '2025-01-01' AND '2025-03-31' 
            THEN '2025-01-01' 
        WHEN date BETWEEN '2025-04-01' AND '2025-06-30' 
            THEN '2025-04-01' 
        WHEN date BETWEEN '2025-07-01' AND '2025-09-30' 
            THEN '2025-07-01' 
        WHEN date BETWEEN '2025-10-01' AND '2025-12-31' 
            THEN '2025-10-01' 
    END as quarter,
    "Transaction Type" AS transaction_type,
    amount,
    number
FROM new_transactions nt
INNER JOIN dim_company c
    ON nt.company = c.current_company_name