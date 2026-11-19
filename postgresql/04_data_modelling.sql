-- ============================================
-- SALES & MARKETING PERFORMANCE INTELLIGENCE
-- 04: DATA MODELLING
-- ============================================

-- 1. Create customer dimension

CREATE TABLE clean.dim_customer AS
SELECT
    customer_id,
    birth_year,
    education,
    marital_status_clean AS marital_status,
    children_home,
    teenagers_home,
    enrollment_date,
    country,
    birth_year_review
FROM clean.marketing_campaign;


-- 2. Create customer marketing fact table

CREATE TABLE clean.fact_customer_marketing AS
SELECT
    customer_id,

    income,
    income_review,

    wine_spending,
    fruit_spending,
    meat_spending,
    fish_spending,
    sweet_spending,
    gold_spending,

    deal_purchases,
    web_purchases,
    catalog_purchases,
    store_purchases,
    web_visits_month,

    accepted_campaign_1,
    accepted_campaign_2,
    accepted_campaign_3,
    accepted_campaign_4,
    accepted_campaign_5,

    latest_campaign_response,
    complaint,
    recency_days

FROM clean.marketing_campaign;


-- 3. Add primary keys

ALTER TABLE clean.dim_customer
ADD PRIMARY KEY (customer_id);

ALTER TABLE clean.fact_customer_marketing
ADD PRIMARY KEY (customer_id);


-- 4. Establish relationship between the tables

ALTER TABLE clean.fact_customer_marketing
ADD CONSTRAINT fk_customer
FOREIGN KEY (customer_id)
REFERENCES clean.dim_customer(customer_id);
