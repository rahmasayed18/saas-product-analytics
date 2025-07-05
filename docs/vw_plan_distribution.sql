-- =======================================
-- 04_vw_plan_distribution.sql
-- Distribution of users and revenue per plan
-- =======================================

DROP VIEW IF EXISTS saas_product.vw_plan_distribution;

CREATE VIEW saas_product.vw_plan_distribution AS
WITH user_cte AS (
    SELECT
        plan,
        COUNT(DISTINCT user_id) AS number_of_users
    FROM saas_product.dim_subscriptions
    GROUP BY plan
),
revenue_cte AS (
    SELECT
        plan,
        SUM(revenue) AS total_revenue
    FROM saas_product.dim_subscriptions
    GROUP BY plan
),
totals AS (
    SELECT
        SUM(u.number_of_users) AS rolling_users,
        SUM(r.total_revenue) AS rolling_revenue
    FROM user_cte u
    JOIN revenue_cte r ON u.plan = r.plan
)
SELECT
    u.plan,
    u.number_of_users,
    r.total_revenue,
    t.rolling_users,
    t.rolling_revenue,
    CONCAT(ROUND((u.number_of_users / t.rolling_users) * 100, 2), ' %') AS user_percentage,
    CONCAT(ROUND((r.total_revenue / t.rolling_revenue) * 100, 2), ' %') AS revenue_percentage
FROM user_cte u
JOIN revenue_cte r ON u.plan = r.plan
JOIN totals t ON 1=1;
