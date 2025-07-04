-- =======================================
-- 01_user_lifecycle_analysis.sql
-- Analyze signup trends, retention, and customer lifetime
-- =======================================

-- 🔹 Join subscriptions and events for full user lifecycle tracking
SELECT 
    s.subscription_key,
    s.user_id,
    s.signup_date,
    s.signup_year,
    s.signup_month,
    s.country,
    s.plan,
    s.subscription_status,
    s.revenue,
    s.churn_date,
    e.event_date,
    e.event_year,
    e.event_month,
    e.event_time,
    e.event_type
FROM saas_product.dim_subscriptions s
LEFT JOIN saas_product.dim_events e
    ON s.user_id = e.user_id;


-- 🔹 Monthly signup volume and retention
WITH users_cte AS (
    -- Count of signups per month
    SELECT 
        signup_month,
        COUNT(user_id) AS signups_number
    FROM saas_product.dim_subscriptions
    GROUP BY signup_month
), 

churn_users AS (
    -- Active users per signup_month (i.e. not churned yet or churned after last event)
    SELECT
        s.signup_month,
        COUNT(DISTINCT s.user_id) AS users_number
    FROM saas_product.dim_subscriptions s
    JOIN saas_product.dim_events e ON s.user_id = e.user_id
    WHERE s.churn_date = '' OR s.churn_date > e.event_date
    GROUP BY s.signup_month
)

-- 🔹 Retention vs. loss per month
SELECT 
    u.signup_month,
    u.signups_number,
    c.users_number,
    u.signups_number - c.users_number AS loss_per_month
FROM users_cte u
JOIN churn_users c ON u.signup_month = c.signup_month;


-- 🔹 Calculate customer lifetime (in days)
SELECT 
    user_id,     
    DATEDIFF(
        COALESCE(churn_date, NOW()), 
        signup_date
    ) AS customer_lifetime_days
FROM saas_product.dim_subscriptions
WHERE signup_date IS NOT NULL 
  OR churn_date IS NOT NULL;
