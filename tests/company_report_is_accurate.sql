WITH original_company_report AS (
        SELECT *
        FROM {{ source('transactions', 'company_report') }}
), 
    company_report_rebuilt AS (
        SELECT *
        FROM {{ ref('company_report_rebuilt') }}
)

SELECT
    o.*
FROM
    original_company_report o
INNER JOIN
    company_report_rebuilt r
    ON o.company_id = r.company_id
    AND o.quarter = r.quarter
WHERE
    o.sales_amount <> r.sales_amount
    OR o.buy_cost_amount <> r.buy_cost_amount
    OR o.total_cost <> r.total_cost
    OR o.total_revenue <> r.total_revenue