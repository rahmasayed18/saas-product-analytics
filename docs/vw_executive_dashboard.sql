CREATE OR REPLACE VIEW saas_product.vw_exec_dashboard AS
WITH base AS (
    SELECT
        CURRENT_DATE AS report_date,
        COUNT(DISTINCT user_id) AS total_users,
        ROUND(SUM(revenue), 2) AS total_revenue,
        ROUND(SUM(revenue) / COUNT(DISTINCT user_id), 2) AS arpu
    FROM saas_product.silver_subscriptions
),
mrr AS (
    SELECT
        CURRENT_DATE AS report_date,
        ROUND(SUM(revenue) / COUNT(DISTINCT user_id), 2) AS mrr
    FROM saas_product.silver_subscriptions
    WHERE churn_date IS NULL OR churn_date > CURRENT_DATE
),
churn AS (
    SELECT
        CURRENT_DATE AS report_date,
        ROUND(
            COUNT(DISTINCT CASE WHEN churn_date BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY) AND CURRENT_DATE THEN user_id END) 
            / COUNT(DISTINCT user_id), 4
        ) AS churn_rate
    FROM saas_product.silver_subscriptions
),
top_country AS (
    SELECT
        CURRENT_DATE AS report_date,
        country
    FROM (
        SELECT country, COUNT(*) AS cnt
        FROM saas_product.silver_subscriptions
        GROUP BY country
        ORDER BY cnt DESC
        LIMIT 1
    ) t
),
top_plan AS (
    SELECT
        CURRENT_DATE AS report_date,
        plan
    FROM (
        SELECT plan, COUNT(*) AS cnt
        FROM saas_product.silver_subscriptions
        GROUP BY plan
        ORDER BY cnt DESC
        LIMIT 1
    ) t
)
SELECT 
    b.report_date,
    b.total_users,
    m.mrr,
    c.churn_rate,
    b.arpu,
    tc.country AS top_country,
    tp.plan AS top_plan
FROM base b
JOIN mrr m USING (report_date)
JOIN churn c USING (report_date)
JOIN top_country tc USING (report_date)
JOIN top_plan tp USING (report_date);
