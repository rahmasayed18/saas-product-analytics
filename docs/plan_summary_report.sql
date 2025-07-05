-- =======================================
-- 06_plan_report_saas.sql
-- Plan-level performance report: ARPU, churn, engagement
-- =======================================

DROP VIEW IF EXISTS saas_product.plan_report_saas;

CREATE VIEW saas_product.plan_report_saas AS
WITH base AS (
    SELECT 
        plan,
        COUNT(DISTINCT user_id) AS total_users,
        COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
            ELSE NULL END) AS active_users,
        COUNT(DISTINCT user_id) - COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
            ELSE NULL END) AS churned_users,
        SUM(revenue) AS total_revenue,
        ROUND(SUM(revenue) / NULLIF(COUNT(DISTINCT user_id), 0), 2) AS ARPU,
        CONCAT(ROUND(COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
        END) * 100.0 / COUNT(DISTINCT user_id), 2), ' %') AS churn_rate_percentage
    FROM saas_product.dim_subscriptions
    GROUP BY plan
),

events AS (
    SELECT 
        s.plan,
        COUNT(*) AS total_events,
        ROUND(COUNT(*) / NULLIF(COUNT(DISTINCT s.user_id), 0), 1) AS events_per_user
    FROM saas_product.dim_events e
    JOIN saas_product.dim_subscriptions s ON s.user_id = e.user_id
    GROUP BY s.plan
)

SELECT 
    b.plan,
    b.total_users,
    b.active_users,
    b.churned_users,
    b.total_revenue,
    b.ARPU,
    b.churn_rate_percentage,
    e.total_events,
    e.events_per_user
FROM base b
LEFT JOIN events e ON b.plan = e.plan;
