-- ============================================
-- SALES & MARKETING PERFORMANCE INTELLIGENCE
-- 01: RAW TABLE CREATION
-- ============================================

CREATE SCHEMA IF NOT EXISTS raw;

CREATE TABLE IF NOT EXISTS raw.marketing_campaign (
    id TEXT,
    year_birth TEXT,
    education TEXT,
    marital_status TEXT,
    income TEXT,
    kidhome TEXT,
    teenhome TEXT,
    dt_customer TEXT,
    recency TEXT,
    mntwines TEXT,
    mntfruits TEXT,
    mntmeatproducts TEXT,
    mntfishproducts TEXT,
    mntsweetproducts TEXT,
    mntgoldprods TEXT,
    numdealspurchases TEXT,
    numwebpurchases TEXT,
    numcatalogpurchases TEXT,
    numstorepurchases TEXT,
    numwebvisitsmonth TEXT,
    acceptedcmp1 TEXT,
    acceptedcmp2 TEXT,
    acceptedcmp3 TEXT,
    acceptedcmp4 TEXT,
    acceptedcmp5 TEXT,
    response TEXT,
    complain TEXT,
    country TEXT
);

-- Raw data is imported separately from the original CSV.
-- All source columns are initially stored as TEXT.
-- This preserves the original imported values.
