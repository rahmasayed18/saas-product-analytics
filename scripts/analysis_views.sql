-- =======================================
-- 02_analysis_views.sql
-- Dimension views for subscription and event data
-- =======================================

-- -------------------------------------------------------
-- View: dim_subscriptions
-- Adds calendar dimensions to subscriptions data
-- -------------------------------------------------------

DROP VIEW IF EXISTS saas_product.dim_subscriptions;

CREATE VIEW saas_product.dim_subscriptions AS
SELECT 
    ROW_NUMBER() OVER (ORDER BY user_id) AS subscription_key,  -- surrogate key
    user_id,
    signup_date,
    YEAR(signup_date) AS signup_year,
    MONTH(signup_date) AS signup_month,
    country,
    plan,
    subscription_status,
    revenue,
    churn_date
FROM saas_product.silver_subscriptions;

-- Optional test
-- SELECT * FROM saas_product.dim_subscriptions;


-- -------------------------------------------------------
-- View: dim_events
-- Adds calendar dimensions to event data
-- -------------------------------------------------------

DROP VIEW IF EXISTS saas_product.dim_events;

CREATE VIEW saas_product.dim_events AS
SELECT
    user_id,
    event_date,
    YEAR(event_date) AS event_year,
    MONTH(event_date) AS event_month,
    event_time,
    event_type
FROM saas_product.silver_events;

-- Optional test
-- SELECT * FROM saas_product.dim_events;
