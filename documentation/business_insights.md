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

### 7. Website Visits vs Web Purchases

- Customers visiting the website 3 times per month averaged 4.51 web purchases.
- Customers visiting 7 times averaged 3.64 web purchases.
- The relationship was not consistently increasing across visit groups.

**Business implication:** Higher website visit frequency does not automatically correspond to higher web purchase activity. Further investigation into customer browsing behaviour may be useful.

### 8. Income vs Customer Spending

- Customers earning below 30K averaged 72.18 spending units.
- Customers in the 30K–60K group averaged 298.24 units.
- Customers in the 60K–90K group averaged 1,185.36 units.
- Customers earning above 90K averaged 1,603.96 units.

**Business implication:** Higher income groups showed higher average spending in this dataset. This is an association, not proof that income causes higher spending.

*Note: Customers with missing income and the flagged extreme income value were excluded from this comparison.*

### 9. Customer Spending Quartiles

- The dataset was divided into four equal-sized customer groups using SQL NTILE(4).
- The highest-spending quartile (Q4) accounted for 61.53% of total recorded spending.
- The lowest-spending quartile (Q1) accounted for only 1.62%.

**Business implication:** Spending is concentrated among the highest-spending customer group. This segmentation can help prioritize customer analysis and engagement strategies.
