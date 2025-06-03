WITH company_report_rebuilt AS (
    SELECT
        *
    FROM
        {{ ref('company_report_rebuilt') }}
)
    
SELECT
    *,
    total_revenue - total_cost AS profit
FROM
    company_report_rebuilt
