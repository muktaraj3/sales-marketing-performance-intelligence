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

