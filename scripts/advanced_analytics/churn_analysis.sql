-- =======================================
-- 03_churn_analysis.sql
-- Analyze churn trends by time and geography
-- =======================================

-- 🔹 Churned users per signup month
SELECT 
    s.signup_month AS month,
    COUNT(DISTINCT e.user_id) AS churn_user_number
FROM 
    saas_product.dim_subscriptions s
JOIN saas_product.dim_events e
    ON s.user_id = e.user_id
WHERE
    s.churn_date != '' OR s.churn_date IS NOT NULL
GROUP BY s.signup_month;


-- 🔹 Countries with the highest churn count
SELECT 
    country,
    COUNT(churn_date) AS churn_count
FROM saas_product.dim_subscriptions
WHERE churn_date != '' AND churn_date != 'n/a'
GROUP BY country
ORDER BY churn_count DESC;


-- 🔹 (Optional) Total churned users overall
SELECT 
    COUNT(*) AS total_churned_users
FROM saas_product.dim_subscriptions
WHERE churn_date IS NOT NULL AND churn_date != '' AND churn_date != 'n/a';

-- 🔹 churn reasons (synthetic)

CREATE OR REPLACE VIEW saas_product.churn_reasons_synthetic AS
WITH last_event AS (
    SELECT
        s.user_id,
        MAX(e.event_date) AS last_event_date,
        MAX(e.event_type) AS last_event_type
    FROM saas_product.silver_subscriptions s
    LEFT JOIN saas_product.silver_events e USING (user_id)
    WHERE s.churn_date IS NOT NULL
    GROUP BY s.user_id
)
SELECT
    last_event_type,
    COUNT(*) AS churned_users
FROM last_event
GROUP BY last_event_type
ORDER BY churned_users DESC;
