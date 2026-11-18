# Sales & Marketing Performance Intelligence

## Business Insights

This document summarizes findings from the PostgreSQL analysis of the Maven Analytics Marketing Campaign Results dataset.

### 1. Product Category Spending

- Wine generated the highest recorded customer spending: 680,816 units (50.17%).
- Meat followed with 373,968 units (27.56%).
- Wine and meat together accounted for 77.73% of recorded spending.

**Business implication:** Wine and meat categories represent the largest share of customer spending and may deserve priority in product-focused marketing analysis.

### 2. Highest-Spending Customers

- The two highest-spending customers each recorded 2,525 units.
- The next highest customer recorded 2,524 units.
- The top 10 customers each recorded at least 2,302 units.

**Business implication:** Identifying high-spending customers can help businesses explore premium customer segments and targeted engagement opportunities.

### 3. Customer Spending by Country

- Spain recorded the highest total spending: 662,220 units across 1,095 customers.
- Canada recorded the highest average spending among countries with meaningful sample sizes: 628.85 units per customer.
- Mexico recorded the highest average at 1,040.67 units, but this was based on only 3 customers.

**Business implication:** Country-level comparisons should consider customer counts. Spain leads in total spending because it represents a large share of the dataset, while Canada's average spending is higher.

### 4. Latest Campaign Response by Country

- Spain recorded the highest response rate among countries with meaningful sample sizes at 16.07%.
- Saudi Arabia followed at 15.43%.
- India recorded the lowest response rate at 8.78%.
- Mexico's response rate was 66.67%, but it represented only 3 customers.

**Business implication:** Spain and Saudi Arabia may offer useful markets for further campaign analysis. Small customer samples should not drive market-level decisions.

### 5. Previous Campaign Acceptance

- Campaign 4 had the highest acceptance count: 167 customers (7.46%).
- Campaigns 3 and 5 each recorded 163 acceptances (7.28%).
- Campaign 2 had the lowest acceptance count: 30 customers (1.34%).

**Business implication:** Campaign 4 had the strongest acceptance rate in this dataset. Campaign 2 may warrant further investigation. Campaign costs are unavailable, so profitability cannot be compared.

### 6. Purchase Behaviour

- Store purchases had the highest average: 5.79 purchases per customer.
- Web purchases averaged 4.08.
- Catalog purchases averaged 2.66.
- Deal purchases averaged 2.33.

**Business implication:** Store purchases represent the highest average purchase activity. These figures describe purchase methods and deal-related purchases, not verified marketing-channel attribution.
