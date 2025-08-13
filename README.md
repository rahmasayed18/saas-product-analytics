# 📊 SaaS Product Analytics — Executive Summary & Insights

This analysis explores user behavior, plan performance, and market distribution for the SaaS product over the period covered in the dataset.  
The goal was to identify acquisition trends, retention drivers, and monetization opportunities.

---

## 🔑 Key Highlights

- **Total Users:** 100  
- **Active Subscriptions:** 74 (74% of total — 36 Free, 27 Basic, 11 Pro)  
- **Top Acquisition Month:** Jan 2022 — 31 signups  
- **Top Plan:** Free — 48 signups  
- **Top Country:** Canada — 29% of signups  
- **Lowest Country:** India  
- **Lowest MRR:** $10  
- **Highest MRR:** $25  
- **Top Event Feature:** Feature B — engaged by 93,024% of active users *(likely high due to repeated events)*

---

## 📈 KPI Summary

| KPI                           | Value                          |
|-------------------------------|--------------------------------|
| **Total Users**               | 100                            |
| **Active Subs**               | 74 (74%)                       |
| **Free Plan Active Users**    | 36                             |
| **Basic Plan Active Users**   | 27                             |
| **Pro Plan Active Users**     | 11                             |
| **Top Acquisition Month**     | Jan 2022 (31 signups)          |
| **Top Country**               | Canada (29%)                   |
| **Lowest Country**            | India                          |

---

## 🔍 Key Insights

### 1. Customer Acquisition
- Monthly signups peaked in **Jan** and **Mar 2022**.  
- Top plan at signup: **Free** (48 users).  
- Top country: **Canada**; lowest: **India**.

### 2. Retention & Churn
- Current monthly churn: **26%** *(June 2022)*, compared to SaaS benchmarks of ~5–7%.

### 3. Revenue & Monetization
- MRR fluctuated — highest in **Feb 2022** ($520) and lowest in **Apr 2022**.  
- ARPU is highest in the **Pro plan**.  
- Revenue distribution: **Canada** leads with 37.58%, lowest is **UK** with 17.45%.

### 4. Engagement & Product Usage
- Monthly active users were stable in the first three months (**6%**, **7%**, **9%**).  
- These months saw the **highest MRR**, showing a correlation between MAU stability and revenue peaks.  
- In month four, MAU dropped to **4%**, coinciding with MRR falling from **$440** to **$130**.

---

## 💡 Strategic Recommendations

1. **Boost high-value plan adoption**  
   - Highlight Pro features in onboarding emails.  
   - Offer upgrade discounts in the first 30 days.  

2. **Double down on peak acquisition month strategies**  
   - Replicate successful Jan/Mar campaigns in slower periods.  

3. **Address early churn**  
   - Focus retention efforts within the first 90 days.  
   - Use personalized reactivation campaigns.  

4. **Correlate engagement to revenue**  
   - Explore how sustained MAU in early months drives MRR stability.  

---

## ⚠️ Caveats & Limitations

- **Short Time Range:** The dataset covers a limited number of months, making it hard to capture long-term seasonality or trends.
- **Partial Churn Insight:** Churn rates are calculated from available data but may not reflect true behavior if cancellations weren’t logged consistently.
- **MRR Variability:** Monthly recurring revenue is sensitive to small user count changes due to the relatively small sample size.
- **Engagement Data Gaps:** Not all users have complete event logs, which could skew MAU and feature usage metrics.
- **Plan Definition Ambiguity:** “Free,” “Basic,” and “Pro” plan benefits are assumed; no feature mapping was included in the dataset.
- **Country Representation:** Some countries have very low sample sizes (e.g., India, UK), making percentage comparisons less reliable.
- **Feature Usage Inflation:** Extremely high engagement percentage for Feature B likely reflects repeated event logging rather than unique user interaction.

---

## 🧠 What I Did

- Cleaned and transformed raw event logs and subscription records into structured tables (`silver_events`, `dim_subscriptions`, etc.).
- Built multiple SQL views to analyze revenue trends, plan performance, and retention.
- Normalized date formats and created a fiscal calendar logic.
- Designed layered reports, including `plan_report_saas`, `plan_summary_report`, and `user_value_segmentation`.

---

## 🗃️ Dataset

- **Source:** [SaaS Product Dashboard Dataset – Kaggle](https://www.kaggle.com/datasets/philbertchan/saas-product-dashboard-mau-feature-usage-mrr)  
- **Author:** [Philbert Chan](https://www.kaggle.com/philbertchan)  
- **License:** [CC0 1.0 Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/)  

---

## 🏗️ Project Structure

├── data/ # Cleaned dataset (source available under CC0)
├── sql/ # SQL queries and views
├── reports/ # Analysis write-ups, KPIs, charts
├── README.md # Project overview, dataset info, analysis goals
├── data_license.txt # Dataset usage/license info
├── .gitignore # Ignore rules for Git
└── LICENSE # MIT License for this project

---

## 📊 Reports & Views

- `docs/01_vw_plan_summary.sql` — Plan-level metrics (ARPU, churn).  
- `docs/02_vw_country_revenue_churn.sql` — Revenue and churn by country.  
- `docs/03_vw_event_trend_monthly.sql` — Event volumes and user counts monthly.  
- `docs/04_vw_plan_distribution.sql` — User & revenue share by plan.  
- `docs/05_customer_summary_report.sql` — User-level segmentation & spend.  
- `docs/06_plan_report_saas.sql` — Plan performance, ARPU, engagement.  
- `docs/` — [Executive Summary & Recommendations](docs/executive_summary.md)

---

## 🔧 Tools & Technologies

- **SQL (MySQL)**  
- **Git & GitHub**  
- **Data Cleaning & Transformation** (SQL Views, CTEs)

---

## 🙌 Acknowledgment

- Dataset by [Philbert Chan](https://www.kaggle.com/philbertchan)  
- Licensed under [CC0 1.0 Public Domain](https://creativecommons.org/publicdomain/zero/1.0/)  
