WITH company_report_rebuilt AS (
    SELECT
        *
    FROM
        {{ ref('company_report_rebuilt') }}
), 
    company_profit AS (
        SELECT
            *,
            total_revenue - total_cost AS profit
        FROM
            company_report_rebuilt
    )

SELECT
    company_id,
    company,
    SUM(sales_amount) as total_sales_amount,
    SUM(buy_cost_amount) as buy_cost_amount,
    SUM(total_cost) as total_cost,
    SUM(total_revenue) as total_revenue,
    SUM(profit) as total_profit
FROM company_profit
GROUP BY
    1, 2
ORDER BY
    SUM(profit) DESC

