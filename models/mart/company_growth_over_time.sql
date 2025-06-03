WITH company_profit_start_and_end AS (
    SELECT
        *
    FROM
        {{ ref('company_profit') }}
    WHERE quarter IN ('2024-01-01', '2024-10-01')
)

SELECT
    *,
     profit / lag(profit) OVER (PARTITION BY company_id ORDER BY quarter) AS profit_growth,
     total_revenue / lag(total_revenue) OVER (PARTITION BY company_id ORDER BY quarter) AS revenue_growth
FROM
    company_profit_start_and_end
ORDER BY profit_growth DESC
