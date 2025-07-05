-- =======================================
-- 02_vw_country_revenue_churn.sql
-- Revenue and churn by country and plan
-- =======================================

DROP VIEW IF EXISTS saas_product.vw_country_revenue_churn;

CREATE VIEW saas_product.vw_country_revenue_churn AS
SELECT
    plan,
    country,
    COUNT(user_id) AS total_users,
    SUM(revenue) AS total_revenue,
    COUNT(DISTINCT CASE 
        WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id 
        ELSE NULL END) AS active_users,
    CONCAT(ROUND(
        COUNT(DISTINCT CASE WHEN churn_date IS NULL OR churn_date = 'n/a' THEN user_id END)
        * 100.0 / COUNT(DISTINCT user_id), 2), ' %') AS churn_rate_percentage
FROM saas_product.dim_subscriptions
GROUP BY country, plan
ORDER BY total_revenue DESC;
