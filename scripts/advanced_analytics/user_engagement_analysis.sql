-- =======================================
-- 04_user_engagement_analysis.sql
-- Analyze user engagement and activity trends
-- =======================================

-- 🔹 Average number of events per user per month
WITH total_events_cte AS (
    SELECT
        e.user_id,
        e.event_type,
        COUNT(e.event_type) AS number_of_events,
        COUNT(e.event_type) OVER (PARTITION BY e.user_id) AS total_events,
        e.event_month
    FROM saas_product.dim_events e
    GROUP BY user_id, event_type, event_month
)
SELECT
    user_id,
    event_type,
    number_of_events,
    total_events,
    ROUND(AVG(total_events) OVER (PARTITION BY event_month), 1) AS avg_events,
    event_month
FROM total_events_cte
ORDER BY user_id;


-- 🔹 Engagement depth by plan (total events per plan)
SELECT 
    s.plan,
    COUNT(e.event_type) AS number_of_events
FROM saas_product.dim_subscriptions s
JOIN saas_product.dim_events e ON s.user_id = e.user_id
GROUP BY s.plan;


-- 🔹 Monthly engagement trend by plan
SELECT
    e.event_month,
    s.plan,
    COUNT(e.event_type) AS total_events
FROM saas_product.dim_events e
JOIN saas_product.dim_subscriptions s ON e.user_id = s.user_id
GROUP BY e.event_month, s.plan
ORDER BY e.event_month, s.plan;


-- 🔹 Event type distribution by country
SELECT
    s.country,
    e.event_type,
    COUNT(*) AS event_count
FROM saas_product.dim_events e
JOIN saas_product.dim_subscriptions s ON e.user_id = s.user_id
GROUP BY s.country, e.event_type
ORDER BY s.country, event_count DESC;


-- 🔹 Monthly Active Users (MAU)
SELECT
    event_month,
    COUNT(DISTINCT user_id) AS monthly_active_users
FROM saas_product.dim_events
GROUP BY event_month
ORDER BY event_month;


-- 🔹 Weekly Active Users (WAU)
SELECT
    DATE_FORMAT(event_date, '%Y-%u') AS week,
    COUNT(DISTINCT user_id) AS weekly_active_users
FROM saas_product.dim_events
GROUP BY week
ORDER BY week;
