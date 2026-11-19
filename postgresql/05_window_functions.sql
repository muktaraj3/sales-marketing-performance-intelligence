-- ============================================
-- SALES & MARKETING PERFORMANCE INTELLIGENCE
-- 05: WINDOW FUNCTIONS
-- ============================================


-- 1. Rank customers by total product spending

SELECT
    customer_id,
    country,

    wine_spending + fruit_spending + meat_spending
    + fish_spending + sweet_spending + gold_spending
    AS total_spending,

    RANK() OVER (
        ORDER BY
        wine_spending + fruit_spending + meat_spending
        + fish_spending + sweet_spending + gold_spending DESC
    ) AS spending_rank

FROM clean.marketing_campaign;


-- 2. Compare RANK, DENSE_RANK and ROW_NUMBER

SELECT
    customer_id,

    wine_spending + fruit_spending + meat_spending
    + fish_spending + sweet_spending + gold_spending
    AS total_spending,

    RANK() OVER (
        ORDER BY
        wine_spending + fruit_spending + meat_spending
        + fish_spending + sweet_spending + gold_spending DESC
    ) AS rank_position,

    DENSE_RANK() OVER (
        ORDER BY
        wine_spending + fruit_spending + meat_spending
        + fish_spending + sweet_spending + gold_spending DESC
    ) AS dense_rank_position,

    ROW_NUMBER() OVER (
        ORDER BY
        wine_spending + fruit_spending + meat_spending
        + fish_spending + sweet_spending + gold_spending DESC,
        customer_id
    ) AS row_number_position

FROM clean.marketing_campaign;


-- 3. Divide customers into four spending quartiles

WITH customer_spending AS (
    SELECT
        customer_id,

        wine_spending + fruit_spending + meat_spending
        + fish_spending + sweet_spending + gold_spending
        AS total_spending

    FROM clean.marketing_campaign
)

SELECT
    customer_id,
    total_spending,

    NTILE(4) OVER (
        ORDER BY total_spending
    ) AS spending_quartile

FROM customer_spending;


-- 4. Calculate average spending within each quartile

WITH customer_spending AS (
    SELECT
        customer_id,

        wine_spending + fruit_spending + meat_spending
        + fish_spending + sweet_spending + gold_spending
        AS total_spending

    FROM clean.marketing_campaign
),

quartile_data AS (
    SELECT
        customer_id,
        total_spending,

        NTILE(4) OVER (
            ORDER BY total_spending
        ) AS spending_quartile

    FROM customer_spending
)

SELECT
    spending_quartile,
    COUNT(*) AS customer_count,
    ROUND(AVG(total_spending), 2) AS average_spending

FROM quartile_data
GROUP BY spending_quartile
ORDER BY spending_quartile;
