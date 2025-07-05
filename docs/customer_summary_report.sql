-- =======================================
-- 05_customer_summary_report.sql
-- Detailed per-user metrics: segmentation, spend, usage, activity
-- =======================================

DROP VIEW IF EXISTS saas_product._summary_report;

CREATE VIEW saas_product._summary_report AS
WITH base AS (
    SELECT
        s.user_id,
        s.plan,
        s.country,
        s.signup_date,
        s.churn_date,
        s.revenue,
        DATEDIFF(COALESCE(s.churn_date, CURRENT_DATE), s.signup_date) AS lifetime_days,
        CASE
            WHEN s.revenue >= 100 THEN 'VIP'
            WHEN s.revenue BETWEEN 50 AND 99.99 THEN 'Engaged'
            ELSE 'Low Value'
        END AS customer_segment
    FROM saas_product.dim_subscriptions s
),

events_agg AS (
    SELECT 
        user_id,
        COUNT(*) AS total_events,
        COUNT(DISTINCT event_type) AS unique_event_types,
        MIN(event_date) AS first_event,
        MAX(event_date) AS last_event
    FROM saas_product.dim_events
    GROUP BY user_id
)

SELECT 
    b.user_id,
    b.plan,
    b.country,
    b.signup_date,
    b.churn_date,
    b.revenue,
    b.customer_segment,
    b.lifetime_days,
    e.total_events,
    e.unique_event_types,
    e.first_event,
    e.last_event,
    FLOOR(DATEDIFF(CURRENT_DATE, e.last_event) / 30) AS months_since_last_activity,
    ROUND(b.revenue / NULLIF(b.lifetime_days, 0), 2) AS avg_daily_spend,
    ROUND(b.revenue / NULLIF(e.total_events, 0), 2) AS revenue_per_event
FROM base b
LEFT JOIN events_agg e ON b.user_id = e.user_id;
