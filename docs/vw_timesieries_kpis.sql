CREATE OR REPLACE VIEW saas_product.vw_timeseries_kpis AS
WITH months AS (
    SELECT DISTINCT DATE_FORMAT(signup_date, '%Y-%m') AS month
    FROM saas_product.silver_subscriptions
),
monthly_users AS (
    SELECT
        DATE_FORMAT(signup_date, '%Y-%m') AS month,
        COUNT(DISTINCT user_id) AS new_signups
    FROM saas_product.silver_subscriptions
    GROUP BY month
),
monthly_mrr AS (
    SELECT
        DATE_FORMAT(signup_date, '%Y-%m') AS month,
        ROUND(SUM(revenue) / COUNT(DISTINCT user_id), 2) AS mrr
    FROM saas_product.silver_subscriptions
    GROUP BY month
),
monthly_churn AS (
    SELECT
        DATE_FORMAT(churn_date, '%Y-%m') AS month,
        ROUND(COUNT(DISTINCT user_id) / NULLIF(COUNT(*), 0), 4) AS churn_rate
    FROM saas_product.silver_subscriptions
    WHERE churn_date IS NOT NULL
    GROUP BY month
)
SELECT
    m.month,
    u.new_signups,
    r.mrr,
    c.churn_rate
FROM months m
LEFT JOIN monthly_users u USING (month)
LEFT JOIN monthly_mrr r USING (month)
LEFT JOIN monthly_churn c USING (month)
ORDER BY m.month;
