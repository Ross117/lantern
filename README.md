### 2. **Data Validation & Insight Generation**

Answer the following questions using DBT models and SQL:

#### 🔍 Company-Level Analysis
- Are companies misreporting data (e.g., discrepancies between `transactions` and `company_report`)?

    Yes - test company_report_is_accurate is failing. OnmiCorp have misreported their sales figures.

- Which company is performing the **best** and the **worst**?

    NanoBuild is performing the best as it has generated the largest profit.
    ModuGear is performing the worst has the smallest profit.
    Profit is defined as total_revenue - total_cost

- Which company shows **the most growth** over time?

    NanoBuild had the highest growth in profit from the 1st to the 4th quarter, and also the highest growth in revenue.

### 3. **Data Update Task**
Update your models to reflect the following data correction:
- The company **"TitanTech"** has been renamed to **"The Titan Tech"**.
- This update is present in the `new_transactions` table.
- Create a new company report with updated new_transactions 

Done - the new company report is called company_report_updated

### 4. **Fund-Level Analysis**

Each company is linked to a fund via `fund_info`. Analyze the following:

- Which **fund** is performing the **best** overall?

    


- Which fund has the **highest ROI**, based on Invested value and cash in bank?


- What **additional metric(s)** would you propose to evaluate fund performance?


> 💡 Bonus: Explain why your proposed metric(s) could be useful to stakeholders.