### 2. **Data Validation & Insight Generation**

Answer the following questions using DBT models and SQL:

#### 🔍 Company-Level Analysis
- Are companies misreporting data (e.g., discrepancies between `transactions` and `company_report`)?

    Yes - test company_report_is_accurate is failing. OnmiCorp have misreported their sales figures.

- Which company is performing the **best** and the **worst**?

    NanoBuild is performing the best as it has generated the largest profit.
    ModuGear is has the smallest profit.
    Profit is defined as  total_revenue - total_cost

- Which company shows **the most growth** over time?

    