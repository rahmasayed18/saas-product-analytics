-- =======================================
-- 05_conversion_and_event_distribution.sql
-- Distribution metrics and user conversion insights
-- =======================================

-- 🔹 Plan distribution: % of users per plan
SELECT
    *,
    SUM(number_of_users) OVER () AS total_users,
    CONCAT(FLOOR((number_of_users / SUM(number_of_users) OVER()) * 100), ' %') AS user_percentage
FROM (
    SELECT  
        plan,
        COUNT(DISTINCT user_id) AS number_of_users
    FROM saas_product.dim_subscriptions
    GROUP BY plan
    ORDER BY number_of_users DESC
) t;


-- 🔹 Revenue distribution by plan
WITH total_revenue_cte AS (
    SELECT 
        plan,
        SUM(revenue) AS total_revenue  
    FROM saas_product.dim_subscriptions 
    GROUP BY plan
)
SELECT
    *,
    SUM(total_revenue) OVER () AS rolling_total,
    CONCAT(ROUND((total_revenue / SUM(total_revenue) OVER()) * 100, 1), ' %') AS revenue_percentage
FROM total_revenue_cte;


-- 🔹 % of events by top 10% of users
WITH user_count_cte AS (
    SELECT
        user_id,
        COUNT(*) AS total_events
    FROM saas_product.dim_events
    GROUP BY user_id
),

user_rank AS (
    SELECT
        user_id,
        total_events,
        NTILE(10) OVER (ORDER BY total_events DESC) AS decile
    FROM user_count_cte
),

top_users AS (
    SELECT
        user_id, 
        total_events
    FROM user_rank
    WHERE decile = 1
),

events_total AS (
    SELECT
        (SELECT SUM(total_events) FROM user_count_cte) AS total_events,
        (SELECT SUM(total_events) FROM top_users) AS top_10_perc_users
)

SELECT
    total_events,
    top_10_perc_users,
    CONCAT(ROUND((top_10_perc_users / total_events) * 100 , 2), ' %') AS top_10_perc_events
FROM events_total;


-- 🔹 Event share per plan
WITH total_events_cte AS (
    SELECT
        s.plan,
        COUNT(e.event_type) AS total_events
    FROM saas_product.dim_events e
    JOIN saas_product.dim_subscriptions s ON e.user_id = s.user_id
    GROUP BY s.plan
)
SELECT 
    plan,
    total_events,
    SUM(total_events) OVER () AS rolling_total,
    CONCAT(ROUND((total_events / SUM(total_events) OVER()) * 100, 1), ' %') AS event_perc
FROM total_events_cte;


-- 🔹 Free-to-paid conversion rate
WITH plan_users AS (
    SELECT
        plan,
        COUNT(DISTINCT CASE WHEN subscription_status = 'paid' THEN user_id END) AS paid_users,
        COUNT(DISTINCT CASE WHEN subscription_status = 'free' THEN user_id END) AS free_users
    FROM saas_product.dim_subscriptions
    GROUP BY plan
),

total_users AS (
    SELECT
        plan,
        paid_users,
        free_users,
        paid_users + free_users AS total_users
    FROM plan_users
)

SELECT
    plan,
    paid_users,
    free_users,
    total_users,
    SUM(total_users) OVER () AS total_users_overall,
    CONCAT(ROUND((paid_users / SUM(total_users) OVER()) * 100, 2), ' %') AS conversion_rate
FROM total_users
ORDER BY plan;
