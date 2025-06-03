WITH transactions_cleaned AS (
    SELECT
        *
    FROM
        {{ ref('transactions_cleaned') }}
),

    fund_info AS (
        SELECT
            *
        FROM
            {{ source('transactions', 'fund_info') }}
    ),

    transactions_after_investment AS (
        SELECT
            f.fund,
            f.invested,
            t.*
        FROM 
            transactions_cleaned t
        INNER JOIN fund_info f
            ON t.company_id = f.company_id
        WHERE date >= f.invested_date

        UNION

        SELECT
            f.fund,
            f.invested,
            nt.*
        FROM 
            new_transactions_cleaned nt
        INNER JOIN fund_info f
            ON nt.company_id = f.company_id
        WHERE date >= f.invested_date
    )

SELECT
    fund,
    MAX(invested) as invested,
    SUM(CASE
            WHEN transaction_type = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as sales_amount,
    SUM(CASE
            WHEN transaction_type = 'Buy Item Cost'
            THEN amount
            ELSE 0
        END) as buy_cost_amount,
    SUM(CASE
            WHEN transaction_type IN ('Buy Item Cost', 'Upkeep Cost')
            THEN amount
            ELSE 0
        END) as total_cost,
    SUM(CASE
            WHEN transaction_type = 'Sales of Item'
            THEN amount
            ELSE 0
        END) as total_revenue,
FROM transactions_after_investment
GROUP BY
    1
ORDER BY
    1

