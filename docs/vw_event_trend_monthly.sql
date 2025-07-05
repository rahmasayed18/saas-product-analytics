-- =======================================
-- 03_vw_event_trend_monthly.sql
-- Monthly event counts and user activity
-- =======================================

DROP VIEW IF EXISTS saas_product.vw_event_trend_monthly;

CREATE VIEW saas_product.vw_event_trend_monthly AS
SELECT
    event_month,
    event_type,
    COUNT(user_id) AS total_events,
    COUNT(DISTINCT user_id) AS unique_users
FROM saas_product.dim_events
GROUP BY event_month, event_type;
