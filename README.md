# SaaS Product Analytics Project

This project analyzes user behavior, feature usage, and subscription patterns from a SaaS product dataset. It uses SQL to clean, transform, and extract actionable business insights.

---

## 📌 Objectives

- Understand subscription trends by plan and geography
- Track feature usage and engagement by user segment
- Identify churn patterns and customer lifetime
- Measure key SaaS metrics: MRR, MAU, churn rate, retention

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

---

## 🧠 Key Insights

- Most users are on the Free plan, but Pro users show longer retention
- Country X has the highest churn rate; Country Y leads in lifetime value
- MAU peaks around product update releases
- Feature Z correlates strongly with reduced churn

---

## 🔧 Tools & Technologies

- SQL (MySQL)
- Git & GitHub
- Data Cleaning & Transformation (SQL Views, CTEs)

---

## 🙌 Acknowledgment

- Dataset by [Philbert Chan](https://www.kaggle.com/philbertchan)  
- Licensed under [CC0 1.0 Public Domain](https://creativecommons.org/publicdomain/zero/1.0/)
