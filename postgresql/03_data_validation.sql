-- ============================================
-- SALES & MARKETING PERFORMANCE INTELLIGENCE
-- 03: DATA VALIDATION
-- ============================================

-- 1. Verify total records and missing income
SELECT
    COUNT(*) AS total_customers,
    COUNT(income) AS customers_with_income,
    COUNT(*) - COUNT(income) AS missing_income
FROM clean.marketing_campaign;


-- 2. Check for duplicate customer IDs
SELECT
    customer_id,
    COUNT(*) AS record_count
FROM clean.marketing_campaign
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 3. Check unusual marital status values
SELECT
    marital_status,
    marital_status_clean,
    COUNT(*) AS customer_count
FROM clean.marketing_campaign
GROUP BY marital_status, marital_status_clean
ORDER BY customer_count DESC;


-- 4. Verify campaign and response flags
SELECT
    'Campaign 1' AS flag_name,
    COUNT(*) FILTER (WHERE accepted_campaign_1 NOT IN (0, 1)) AS invalid_values
FROM clean.marketing_campaign

UNION ALL

SELECT 'Campaign 2',
    COUNT(*) FILTER (WHERE accepted_campaign_2 NOT IN (0, 1))
FROM clean.marketing_campaign

UNION ALL

SELECT 'Campaign 3',
    COUNT(*) FILTER (WHERE accepted_campaign_3 NOT IN (0, 1))
FROM clean.marketing_campaign

UNION ALL

SELECT 'Campaign 4',
    COUNT(*) FILTER (WHERE accepted_campaign_4 NOT IN (0, 1))
FROM clean.marketing_campaign

UNION ALL

SELECT 'Campaign 5',
    COUNT(*) FILTER (WHERE accepted_campaign_5 NOT IN (0, 1))
FROM clean.marketing_campaign

UNION ALL

SELECT 'Latest Response',
    COUNT(*) FILTER (WHERE latest_campaign_response NOT IN (0, 1))
FROM clean.marketing_campaign;


-- 5. Review flagged records
SELECT
    customer_id,
    birth_year,
    income,
    birth_year_review,
    income_review
FROM clean.marketing_campaign
WHERE birth_year_review = TRUE
   OR income_review = TRUE
ORDER BY customer_id;
