-- Q1. Which product categories generate the highest customer spending?

WITH category_totals AS (
    SELECT 'Wine' AS category, SUM(wine_spending) AS total_spending
    FROM clean.marketing_campaign

    UNION ALL

    SELECT 'Fruits', SUM(fruit_spending)
    FROM clean.marketing_campaign

    UNION ALL

    SELECT 'Meat', SUM(meat_spending)
    FROM clean.marketing_campaign

    UNION ALL

    SELECT 'Fish', SUM(fish_spending)
    FROM clean.marketing_campaign

    UNION ALL

    SELECT 'Sweets', SUM(sweet_spending)
    FROM clean.marketing_campaign

    UNION ALL

    SELECT 'Gold', SUM(gold_spending)
    FROM clean.marketing_campaign
)

SELECT
    category,
    total_spending,
    ROUND(
        total_spending * 100.0 / SUM(total_spending) OVER (),
        2
    ) AS spending_percentage
FROM category_totals
ORDER BY total_spending DESC;


-- Q2. Who are the highest-spending customers?

SELECT
    customer_id,
    country,
    income,
    (
        wine_spending +
        fruit_spending +
        meat_spending +
        fish_spending +
        sweet_spending +
        gold_spending
    ) AS total_spending,

    DENSE_RANK() OVER (
        ORDER BY
            wine_spending +
            fruit_spending +
            meat_spending +
            fish_spending +
            sweet_spending +
            gold_spending DESC
    ) AS spending_rank

FROM clean.marketing_campaign
ORDER BY total_spending DESC
LIMIT 10;

-- Q3. How does customer spending differ across countries?

SELECT
    country,
    COUNT(*) AS customer_count,

    SUM(
        wine_spending +
        fruit_spending +
        meat_spending +
        fish_spending +
        sweet_spending +
        gold_spending
    ) AS total_spending,

    ROUND(
        AVG(
            wine_spending +
            fruit_spending +
            meat_spending +
            fish_spending +
            sweet_spending +
            gold_spending
        ),
        2
    ) AS avg_spending_per_customer

FROM clean.marketing_campaign
GROUP BY country
ORDER BY avg_spending_per_customer DESC;

-- Q4. How does the latest campaign response differ by country?

SELECT
    country,
    COUNT(*) AS customer_count,
    SUM(latest_campaign_response) AS responses,

    ROUND(
        AVG(latest_campaign_response) * 100,
        2
    ) AS response_rate_pct

FROM clean.marketing_campaign
GROUP BY country
ORDER BY response_rate_pct DESC;

-- Q5. Which previous marketing campaign had the highest acceptance?

SELECT
    'Campaign 1' AS campaign,
    SUM(accepted_campaign_1) AS accepted_customers,
    ROUND(AVG(accepted_campaign_1) * 100, 2) AS acceptance_rate_pct
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Campaign 2',
    SUM(accepted_campaign_2),
    ROUND(AVG(accepted_campaign_2) * 100, 2)
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Campaign 3',
    SUM(accepted_campaign_3),
    ROUND(AVG(accepted_campaign_3) * 100, 2)
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Campaign 4',
    SUM(accepted_campaign_4),
    ROUND(AVG(accepted_campaign_4) * 100, 2)
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Campaign 5',
    SUM(accepted_campaign_5),
    ROUND(AVG(accepted_campaign_5) * 100, 2)
FROM clean.marketing_campaign

ORDER BY acceptance_rate_pct DESC;

-- Q6. Which purchase method is used most frequently?

SELECT
    'Store' AS purchase_method,
    ROUND(AVG(store_purchases), 2) AS avg_purchases_per_customer,
    SUM(store_purchases) AS total_purchases
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Web',
    ROUND(AVG(web_purchases), 2),
    SUM(web_purchases)
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Catalog',
    ROUND(AVG(catalog_purchases), 2),
    SUM(catalog_purchases)
FROM clean.marketing_campaign

UNION ALL

SELECT
    'Deals',
    ROUND(AVG(deal_purchases), 2),
    SUM(deal_purchases)
FROM clean.marketing_campaign

ORDER BY avg_purchases_per_customer DESC;

-- Q7. Does website visit frequency relate to web purchases?

WITH visit_analysis AS (
    SELECT
        CASE
            WHEN web_visits_month >= 10 THEN '10+'
            ELSE web_visits_month::TEXT
        END AS monthly_visits,

        CASE
            WHEN web_visits_month >= 10 THEN 10
            ELSE web_visits_month
        END AS sort_order,

        web_purchases

    FROM clean.marketing_campaign
)

SELECT
    monthly_visits,
    COUNT(*) AS customer_count,
    ROUND(AVG(web_purchases), 2) AS avg_web_purchases

FROM visit_analysis
GROUP BY monthly_visits, sort_order
ORDER BY sort_order;

-- Q8. How does customer income relate to spending?

WITH customer_spending AS (
    SELECT
        CASE
            WHEN income < 30000 THEN 'Below 30K'
            WHEN income < 60000 THEN '30K-60K'
            WHEN income < 90000 THEN '60K-90K'
            ELSE 'Above 90K'
        END AS income_group,

        CASE
            WHEN income < 30000 THEN 1
            WHEN income < 60000 THEN 2
            WHEN income < 90000 THEN 3
            ELSE 4
        END AS sort_order,

        wine_spending +
        fruit_spending +
        meat_spending +
        fish_spending +
        sweet_spending +
        gold_spending AS total_spending

    FROM clean.marketing_campaign
    WHERE income IS NOT NULL
      AND income_review = FALSE
)

SELECT
    income_group,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spending), 2) AS avg_customer_spending

FROM customer_spending
GROUP BY income_group, sort_order
ORDER BY sort_order;

-- Q9. How is customer spending distributed across four quartiles?

WITH customer_spending AS (
    SELECT
        customer_id,
        wine_spending +
        fruit_spending +
        meat_spending +
        fish_spending +
        sweet_spending +
        gold_spending AS total_spending
    FROM clean.marketing_campaign
),

spending_quartiles AS (
    SELECT
        customer_id,
        total_spending,
        NTILE(4) OVER (
            ORDER BY total_spending, customer_id
        ) AS spending_quartile
    FROM customer_spending
)

SELECT
    spending_quartile,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spending), 2) AS avg_spending,
    SUM(total_spending) AS total_spending

FROM spending_quartiles
GROUP BY spending_quartile
ORDER BY spending_quartile;

-- Q10. How does product category spending differ across spending quartiles?

WITH customer_spending AS (
    SELECT
        customer_id,
        wine_spending,
        fruit_spending,
        meat_spending,
        fish_spending,
        sweet_spending,
        gold_spending,

        wine_spending +
        fruit_spending +
        meat_spending +
        fish_spending +
        sweet_spending +
        gold_spending AS total_spending

    FROM clean.marketing_campaign
),

spending_quartiles AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY total_spending, customer_id
        ) AS spending_quartile
    FROM customer_spending
)

SELECT
    spending_quartile,
    ROUND(AVG(wine_spending), 2) AS avg_wine,
    ROUND(AVG(fruit_spending), 2) AS avg_fruit,
    ROUND(AVG(meat_spending), 2) AS avg_meat,
    ROUND(AVG(fish_spending), 2) AS avg_fish,
    ROUND(AVG(sweet_spending), 2) AS avg_sweet,
    ROUND(AVG(gold_spending), 2) AS avg_gold

FROM spending_quartiles
GROUP BY spending_quartile
ORDER BY spending_quartile;

-- Q11. Does previous campaign acceptance differ across spending quartiles?

WITH customer_spending AS (
    SELECT
        customer_id,

        wine_spending +
        fruit_spending +
        meat_spending +
        fish_spending +
        sweet_spending +
        gold_spending AS total_spending,

        accepted_campaign_1 +
        accepted_campaign_2 +
        accepted_campaign_3 +
        accepted_campaign_4 +
        accepted_campaign_5 AS campaigns_accepted

    FROM clean.marketing_campaign
),

spending_quartiles AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY total_spending, customer_id
        ) AS spending_quartile
    FROM customer_spending
)

SELECT
    spending_quartile,
    COUNT(*) AS customer_count,
    ROUND(AVG(campaigns_accepted), 2) AS avg_campaigns_accepted

FROM spending_quartiles
GROUP BY spending_quartile
ORDER BY spending_quartile;

