WITH fund_performance AS (
    SELECT
        *
    FROM
        {{ ref('fund_performance') }}
)

SELECT
    fund,
    total_revenue - total_cost AS profit,
    (total_revenue - total_cost) - invested AS roi
FROM 
    fund_performance
ORDER BY
    profit DESC