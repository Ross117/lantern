WITH fund_info AS (
    SELECT
        *
    FROM
        {{ source('transactions', 'fund_info') }}
)

SELECT
    company_id,
    company AS previous_company_name,
    CASE
        WHEN company = 'TitanTech'
        THEN 'The Titan Tech'
        ELSE company
    END AS current_company_name
FROM
    fund_info