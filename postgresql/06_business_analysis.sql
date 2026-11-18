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

