# SaaS Product Analytics Project

📊 Project Overview
This project analyzes a SaaS product dataset to uncover user behavior, revenue patterns, and plan profitability. The goal was to develop a comprehensive understanding of how users interact with the platform over time and how that translates into business outcomes, such as churn, lifetime value, and monthly recurring revenue.

The dataset contains user subscription events, countries, signup dates, and product activity logs.

## 📌 Objectives

- Understand subscription trends by plan and geography
- Track feature usage and engagement by user segment
- Identify churn patterns and customer lifetime
- Measure key SaaS metrics: MRR, MAU, churn rate, retention

---
## 📐 SaaS Metrics Glossary
- **MRR (Monthly Recurring Revenue)**: Predictable subscription income per month.
- **ARPU (Average Revenue Per User)**: Revenue per active subscriber.
- **Churn Rate**: % of users who cancel subscriptions.

---

🎯 Business Questions Answered
What is the monthly trend in revenue and active users?

Which plans contribute most to revenue and retention?

What is the distribution of users across countries and plans?

Which users can be considered high-value (VIP) or low-engagement?

What is the churn rate and lifetime value of users by plan?

---

## 🗃️ Dataset

- **Source**: [SaaS Product Dashboard Dataset – Kaggle](https://www.kaggle.com/datasets/philbertchan/saas-product-dashboard-mau-feature-usage-mrr)
- **Author**: [Philbert Chan](https://www.kaggle.com/philbertchan)
- **License**: [CC0 1.0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/)

✅ You are free to use, modify, and redistribute this dataset (even commercially) without permission.

---

## 🏗️ Project Structure
```
├── data/ # Cleaned dataset (source available under CC0)
├── sql/ # SQL queries and views
├── reports/ # Analysis write-ups, KPIs, charts
├── README.md # Project overview, dataset info, analysis goals
├── data_license.txt # Dataset usage/license info
├── .gitignore # Ignore rules for Git
└── LICENSE # MIT License for this project
```
---

## 📊 Reports & Views

- `docs/01_vw_plan_summary.sql`: Plan-level metrics (ARPU, churn).
- `docs/02_vw_country_revenue_churn.sql`: Revenue and churn by country.
- `docs/03_vw_event_trend_monthly.sql`: Event volumes and user counts monthly.
- `docs/04_vw_plan_distribution.sql`: User & revenue share by plan.
- `docs/05_customer_summary_report.sql`: User-level segmentation & spend.
- `docs/06_plan_report_saas.sql`: Plan performance, ARPU, engagement.
- `docs/` :  [Executive Summary & Recommendations](docs/executive_summary.md)


---
🧠 What I Did
Cleaned and transformed raw event logs and subscription records into structured tables (silver_events, dim_subscriptions, etc.)

Built multiple SQL views to analyze revenue trends, plan performance, and retention.

Normalized date formats and created a fiscal calendar logic.

Designed layered reports, including plan_report_saas, plan_summary_report, and user_value_segmentation.


---

💡 Key Insights

✔️ Pro Plans = 50.3% of revenue, only 15% of users.
✔️ Canada = high revenue & high churn → growth opportunity?
✔️ Free Plan = most events → strong top-of-funnel.
✔️ Top 10% users = 16% of events → power users drive product usage.


---

## 🔧 Tools & Technologies

- SQL (MySQL)
- Git & GitHub
- Data Cleaning & Transformation (SQL Views, CTEs)

---

## 🙌 Acknowledgment

- Dataset by [Philbert Chan](https://www.kaggle.com/philbertchan)  
- Licensed under [CC0 1.0 Public Domain](https://creativecommons.org/publicdomain/zero/1.0/)
