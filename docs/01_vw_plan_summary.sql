-- =======================================
-- 01_vw_plan_summary.sql
-- Plan-level summary of churn, users, revenue, ARPU
-- =======================================

DROP VIEW IF EXISTS saas_product.vw_plan_summary;

CREATE VIEW saas_product.vw_plan_summary AS
SELECT
    t.plan,
    t.total_users,
    c.active_users,
    c.churned_users,
    t.total_revenue,
    CONCAT(ROUND(t.total_revenue / c.active_users, 2), ' %') AS ARPU
FROM (
    SELECT
        plan,
        COUNT(DISTINCT user_id) AS total_users,
        SUM(revenue) AS total_revenue
    FROM saas_product.dim_subscriptions
    GROUP BY plan
) t
JOIN (
    SELECT
        plan,
        COUNT(DISTINCT user_id) AS total_users,
        COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
            ELSE NULL END) AS active_users,
        COUNT(DISTINCT user_id) - COUNT(DISTINCT CASE 
            WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
            ELSE NULL END) AS churned_users
    FROM saas_product.dim_subscriptions
    GROUP BY plan
) c ON t.plan = c.plan;
