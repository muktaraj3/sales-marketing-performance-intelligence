-- ============================================
-- SALES & MARKETING PERFORMANCE INTELLIGENCE
-- 02: DATA CLEANING AND TYPE CONVERSION
-- ============================================

CREATE SCHEMA IF NOT EXISTS clean;

CREATE TABLE clean.marketing_campaign AS

SELECT
    id::INTEGER AS customer_id,
    year_birth::INTEGER AS birth_year,
    education,
    marital_status,

    NULLIF(TRIM(income), '')::NUMERIC AS income,

    kidhome::INTEGER AS children_home,
    teenhome::INTEGER AS teenagers_home,
    dt_customer::DATE AS enrollment_date,
    recency::INTEGER AS recency_days,

    mntwines::NUMERIC AS wine_spending,
    mntfruits::NUMERIC AS fruit_spending,
    mntmeatproducts::NUMERIC AS meat_spending,
    mntfishproducts::NUMERIC AS fish_spending,
    mntsweetproducts::NUMERIC AS sweet_spending,
    mntgoldprods::NUMERIC AS gold_spending,

    numdealspurchases::INTEGER AS deal_purchases,
    numwebpurchases::INTEGER AS web_purchases,
    numcatalogpurchases::INTEGER AS catalog_purchases,
    numstorepurchases::INTEGER AS store_purchases,
    numwebvisitsmonth::INTEGER AS web_visits_month,

    acceptedcmp1::INTEGER AS accepted_campaign_1,
    acceptedcmp2::INTEGER AS accepted_campaign_2,
    acceptedcmp3::INTEGER AS accepted_campaign_3,
    acceptedcmp4::INTEGER AS accepted_campaign_4,
    acceptedcmp5::INTEGER AS accepted_campaign_5,

    response::INTEGER AS latest_campaign_response,
    complain::INTEGER AS complaint,
    country,

    CASE
        WHEN marital_status IN ('Alone', 'Absurd', 'YOLO')
        THEN 'Unknown / Unclassified'
        ELSE marital_status
    END AS marital_status_clean,

    CASE
        WHEN year_birth IN (1893, 1899, 1900)
        THEN TRUE
        ELSE FALSE
    END AS birth_year_review,

   CASE
    WHEN NULLIF(TRIM(income), '')::NUMERIC = 666666
    THEN TRUE
    ELSE FALSE
END AS income_review
FROM raw.marketing_campaign;

-- Original raw table remains unchanged.
-- Missing income values are preserved as NULL.
-- Unusual marital statuses are recoded in a separate column.
-- Suspicious birth years and extreme income are flagged for review.
