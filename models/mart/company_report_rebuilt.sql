WITH transactions_cleaned AS (
    SELECT
        *
    FROM {{ ref('transactions_cleaned')  }}
),
    dim_company AS (
        SELECT
            *
        FROM
            {{ ref('dim_company') }}
    )

SELECT
    dc.company_id,
    tc.company,
    tc.quarter,
    SUM(CASE
            WHEN tc.transaction_type = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as sales_amount,
    SUM(CASE
            WHEN tc.transaction_type = 'Buy Item Cost'
            THEN amount
            ELSE 0
        END) as buy_cost_amount,
    SUM(CASE
            WHEN tc.transaction_type IN ('Buy Item Cost', 'Upkeep Cost')
            THEN amount
            ELSE 0
        END) as total_cost,
    SUM(CASE
            WHEN tc.transaction_type = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as total_revenue,
FROM transactions_cleaned tc
INNER JOIN dim_company dc
    ON tc.company = dc.current_company_name
GROUP BY
    1, 2, 3
ORDER BY
    1, 3
