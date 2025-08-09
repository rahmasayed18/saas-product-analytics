-- =======================================
-- 02_subscription_revenue_kpis.sql
-- Subscription KPIs: Active users, MRR, ARPU, churn rate
-- =======================================

-- 🔹 Create a view for active users by plan
DROP VIEW IF EXISTS saas_product.active_users;

CREATE VIEW saas_product.active_users AS
WITH total_user AS (
    SELECT 
        plan,
        COUNT(DISTINCT user_id) AS user_number,
        SUM(revenue) AS total_revenue
    FROM saas_product.dim_subscriptions
    GROUP BY plan
),

churn_user AS (
    SELECT 
        s.plan,
        COUNT(DISTINCT e.user_id) AS churn_user_number,
        SUM(s.revenue) AS MRR
    FROM saas_product.dim_subscriptions s
    JOIN saas_product.dim_events e ON s.user_id = e.user_id
    WHERE s.churn_date = '' OR s.churn_date IS NULL OR s.churn_date > e.event_date
    GROUP BY s.plan
)

SELECT 
    t.plan,
    t.user_number,
    c.churn_user_number,
    t.user_number - c.churn_user_number AS active_users_monthly,
    t.total_revenue,
    ROUND(t.total_revenue / (t.user_number - c.churn_user_number), 2) AS ARPU
FROM total_user t
JOIN churn_user c ON t.plan = c.plan
GROUP BY plan
ORDER BY plan, user_number DESC;

-- 🔹 Preview the view
SELECT * FROM saas_product.active_users;


-- 🔹 Churn rate calculation per plan
WITH churned_users AS (
    SELECT
        plan,
        COUNT(DISTINCT user_id) AS total_users,
        COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
            ELSE NULL 
        END) AS active_users,
        
        COUNT(DISTINCT user_id) - COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
            ELSE NULL 
        END) AS churned_users
    FROM saas_product.dim_subscriptions
    GROUP BY plan
)

SELECT
    plan,
    total_users,
    active_users,
    churned_users,
    CONCAT(ROUND((churned_users / total_users) * 100, 2), ' %') AS churn_rate_percentage
FROM churned_users;


-- 🔹 Monthly Recurring Revenue (MRR) by plan
WITH active_users AS (
    SELECT DISTINCT
        s.user_id,
        s.plan,
        s.revenue
    FROM saas_product.dim_subscriptions s
    JOIN saas_product.dim_events e ON s.user_id = e.user_id
    WHERE s.churn_date IS NULL OR e.event_date < s.churn_date
),

revenue_by_plan AS (
    SELECT 
        plan,
        COUNT(DISTINCT user_id) AS active_users,
        SUM(revenue) AS active_revenue
    FROM active_users
    GROUP BY plan
)

SELECT * FROM revenue_by_plan;

-- 🔹 revenue trend over time

CREATE OR REPLACE VIEW saas_product.revenue_trend AS
SELECT
    DATE_FORMAT(signup_date, '%Y-%m') AS month,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT user_id) AS active_customers
FROM saas_product.silver_subscriptions
GROUP BY month
ORDER BY month;
