-- =======================================
-- 01_data_cleaning.sql
-- Cleans and normalizes raw SaaS data
-- =======================================

-- Step 1: Inspect event types for validation
SELECT DISTINCT event_type
FROM saas_product.events_saas;


-- Step 2: Create silver_events table (deduplicated, formatted)
DROP TABLE IF EXISTS saas_product.silver_events;

CREATE TABLE saas_product.silver_events AS
SELECT
    user_id,
    DATE(event_date) AS event_date,
    DATE_FORMAT(event_date, '%H:%i:%s') AS event_time, -- Extract time portion
    event_type
FROM (
    SELECT 
        user_id,
        event_date,
        event_type,
        ROW_NUMBER() OVER (
            PARTITION BY user_id, event_date
            ORDER BY event_date
        ) AS row_num
    FROM saas_product.events_saas
) t
WHERE row_num = 1
ORDER BY user_id;

-- ===================================================
-- Subscription Table Cleaning & Normalization
-- ===================================================

-- Step 3: Inspect unique plan types
SELECT DISTINCT plan
FROM saas_product.subscriptions;


-- Step 4: Create silver_subscriptions table (cleaned version)
DROP TABLE IF EXISTS saas_product.silver_subscriptions;

CREATE TABLE saas_product.silver_subscriptions AS
SELECT 
    user_id,
    CAST(signup_date AS DATE) AS signup_date,
    
    -- Normalize country names
    CASE
        WHEN TRIM(country) = 'USA' THEN 'united states'
        WHEN TRIM(country) = 'UK'  THEN 'united kingdom'
        ELSE TRIM(country)
    END AS country,
    
    plan,
    subscription_status,
    revenue,
    
    -- Standardize churn date format
    CASE
        WHEN churn_date = '' OR churn_date IS NULL THEN 'n/a'
        ELSE CAST(churn_date AS DATE)
    END AS churn_date

FROM (
    SELECT 
        user_id,
        signup_date,
        country,
        plan,
        subscription_status,
        revenue,
        churn_date,
        ROW_NUMBER() OVER (
            PARTITION BY user_id
        ) AS row_num
    FROM saas_product.subscriptions
) t
WHERE row_num = 1;
