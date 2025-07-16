**SaaS Product Analytics Project – Executive Summary**

**Business Objective:**\
The purpose of this project is to analyze a SaaS product's user behavior, demographics, subscription plans, and revenue trends to extract meaningful insights. This analysis aims to support strategic decisions by understanding:

- How different user plans (Free, Basic, Pro) perform in terms of user activity, retention, and revenue.
- Which demographics (country, signup cohort) are most valuable.
- Customer engagement and churn patterns.

**Key Focus Areas:**

- Track user behavior through events.
- Segment users by plan, country, signup date, and revenue.
- Measure user engagement and churn.
- Analyze profitability by user segments and demographics.

**Data Preparation:**

- Cleaned and normalized `subscriptions` and `events` tables.
- Created dimensional views: `dim_subscriptions`, `dim_events`.
- Created analytical views: `vw_plan_summary`, `vw_country_revenue_churn`, `vw_event_trend_monthly`, `vw_plan_distribution`, `_summary_report`, `plan_report_saas`.

**Key Insights:**

- **Most users are on the Free plan**, which has the highest number of active users and the most user events, reflecting high engagement.
- The **Basic plan** ranks second in both active users and events, Making it the next tier of user engagement.
- **Churn rate** is lowest in higher-tier plans, implying better retention among paying users.
- **ARPU (Average Revenue Per User)** increases as we move from Free to Pro plans, as expected, but the **Free plan** still provides valuable engagement metrics.
- **User segmentation** (Low Value, Engaged, VIP) reveals that a small portion of users (VIP) generate the bulk of the revenue.
- **Events per user** and **revenue per event** help track which users are both active and profitable.

**Recommendations:**

- Consider upselling Free users based on their activity level.
- Focus retention strategies on Basic plan users to prevent churn.
- Invest more in acquiring users from countries and demographics with historically high LTV.
- Monitor monthly event trends to detect seasonality or declining engagement.



**Author:** Rahma sayed\
**Project Repository:** [https://github.com/rahmasayed18](https://github.com/rahmasayed18)

