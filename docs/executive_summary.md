**SaaS Product Analytics Project – Executive Summary**

**Business Objective:**\
The purpose of this project is to analyze a SaaS product's user behavior, demographics, subscription plans, and revenue trends to extract meaningful insights. This analysis aims to support strategic decisions by understanding:

- How different user plans (Free, Basic, Pro) perform in terms of user activity, retention, and revenue.
- Which demographics (country, signup cohort) are most valuable?
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

-Free Plan Drives High Engagement, Not Revenue:
The Free plan accounts for the largest share of active users and events, making it the top contributor to platform engagement. While it generates no direct revenue, its high volume of user actions makes it a vital funnel for upsell opportunities and feature testing.

-Basic Plan as a Transition Tier:
The Basic plan ranks second in both active users and total events. It serves as the most common upgrade path from the Free plan, indicating it is the "bridge" product in the monetization funnel. Engagement remains strong here, but monetization is still moderate.

-Pro Plans Excel in Revenue & Retention:
Higher-tier paid plans show significantly lower churn rates and higher ARPU (Average Revenue Per User), confirming their value in both customer retention and revenue generation. These plans attract a smaller but more loyal and profitable segment.

-User Segmentation Shows Pareto Effect:
Segmenting users by behavioral and revenue data (Low Value, Engaged, and VIP) reveals a classic Pareto pattern — a small group of VIP users contributes the majority of the revenue. This emphasizes the importance of nurturing high-LTV users and building tailored retention strategies.

-Revenue Efficiency Metrics Add Depth:
By calculating events per user and revenue per event, we identified which user segments are not just active, but efficient in generating value. This dual lens helps differentiate between noisy activity and profitable engagement — a critical metric for refining growth strategies.


**Recommendations:**

- Upsell Active Free Users Strategically:
Leverage engagement data (e.g., events per user) to identify high-activity Free users who are most likely to convert.     Target them with personalized upgrade prompts or feature-limited trials of paid plans.

- Strengthen Retention for Basic Plan Users:
The Basic plan shows moderate churn and sits at a critical point in the upgrade funnel. Improve onboarding, in-app nudges, and support for this tier to reduce drop-off and increase lifetime value.

-Prioritize High-LTV Demographics in Acquisition:
Expand marketing and outreach in regions and demographics historically associated with high ARPU and low churn. Tailor campaigns to match these users’ behaviors and product usage patterns.

- Track Behavioral Trends for Early Signals:
Regularly monitor monthly trends in user events to identify seasonality, engagement dips, or feature fatigue. Utilize these insights to make proactive product and marketing decisions before customers churn.



**Author:** Rahma sayed\
**Project Repository:** [https://github.com/rahmasayed18](https://github.com/rahmasayed18)
