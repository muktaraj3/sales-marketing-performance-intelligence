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

