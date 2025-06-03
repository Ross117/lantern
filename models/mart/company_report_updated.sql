WITH company_report_rebuilt AS (
    SELECT
        *
    FROM
        {{ ref('company_report_rebuilt') }}
), 
    new_transactions AS (
        SELECT
            *
        FROM
            {{ source('transactions', 'new_transactions') }}
    )

SELECT
    *
FROM
    company_report_rebuilt

UNION

SELECT
    dc.company_id,
    nt.company,
    CASE
        WHEN nt.date BETWEEN '2025-01-01' AND '2025-03-31' 
            THEN '2025-01-01' 
        WHEN nt.date BETWEEN '2025-04-01' AND '2025-06-30' 
            THEN '2025-04-01' 
        WHEN nt.date BETWEEN '2025-07-01' AND '2025-09-30' 
            THEN '2025-07-01' 
        WHEN nt.date BETWEEN '2025-10-01' AND '2025-12-31' 
            THEN '2025-10-01' 
    END as quarter,
    SUM(CASE
            WHEN nt."Transaction Type" = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as sales_amount,
    SUM(CASE
            WHEN nt."Transaction Type" = 'Buy Item Cost'
            THEN amount
            ELSE 0
        END) as buy_cost_amount,
    SUM(CASE
            WHEN nt."Transaction Type" IN ('Buy Item Cost', 'Upkeep Cost')
            THEN amount
            ELSE 0
        END) as total_cost,
    SUM(CASE
            WHEN nt."Transaction Type" = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as total_revenue,
FROM new_transactions nt
INNER JOIN dim_company dc
    ON nt.Company = dc.current_company_name
GROUP BY
    1, 2, 3
ORDER BY
    1, 3


