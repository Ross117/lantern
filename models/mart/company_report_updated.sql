WITH company_report_rebuilt AS (
    SELECT
        *
    FROM
        {{ ref('company_report_rebuilt') }}
), 
    new_transactions_cleaned AS (
        SELECT
            *
        FROM
            {{ ref('new_transactions_cleaned') }}
    )

SELECT
    *
FROM
    company_report_rebuilt

UNION

SELECT
    dc.company_id,
    nt.company,
    quarter,
    SUM(CASE
            WHEN nt.transaction_type = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as sales_amount,
    SUM(CASE
            WHEN nt.transaction_type = 'Buy Item Cost'
            THEN amount
            ELSE 0
        END) as buy_cost_amount,
    SUM(CASE
            WHEN nt.transaction_type IN ('Buy Item Cost', 'Upkeep Cost')
            THEN amount
            ELSE 0
        END) as total_cost,
    SUM(CASE
            WHEN nt.transaction_type = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as total_revenue,
FROM new_transactions_cleaned nt
INNER JOIN dim_company dc
    ON nt.Company = dc.current_company_name
GROUP BY
    1, 2, 3
ORDER BY
    1, 3


