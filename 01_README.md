# Telecom Churn & Revenue Risk Analytics

## Project Overview
This project presents an end-to-end telecom churn analytics solution designed to evaluate customer retention, identify high-risk subscriber segments, and calculate monthly revenue loss. 
The workflow moves from raw data cleaning and exploratory data analysis (EDA) in Python, through structured SQL metric queries in PostgreSQL, to a fully interactive, single-page Power BI executive dashboard.

By isolating churn indicators across contract types, tenure cohorts, and internet services, the analysis translates raw subscriber attributes into targeted retention strategies for business stakeholders and decision-makers.

## Business Problem
Telecom service providers face revenue leakage and customer loss due to unmanaged subscriber churn. Business leaders need answers to critical operational questions:
* What is the current overall customer churn rate and associated monthly revenue loss?
* Which contract types and internet service offerings experience the highest attrition rates?
* How does customer tenure impact the likelihood of churn?
* Which specific active, high-value accounts are at immediate risk of leaving?

## Business Objectives
* Quantify global customer retention and revenue metrics across the subscriber base.
* Identify high-risk service configurations and customer demographics.
* Deliver an actionable executive dashboard prioritizing top revenue-loss accounts for targeted retention campaigns.

## Dataset
* **Rows:** 7,043
* **Columns:** 21
* **Data Type:** Telecom Subscriber Operations & Financial Records
* **Key Fields:** `customerid`, `contract`, `internetservice`, `monthlycharges`, `totalcharges`, `tenure`, `churn`

## Tools & Technologies
| Tool | Purpose |
| :--- | :--- |
| **Python (Pandas, NumPy)** | Data cleaning, data type validation, missing value handling, and exploratory data analysis (EDA). |
| **PostgreSQL** | Relational database analysis, SQL schema design, KPI querying, and aggregate functions. |
| **Power BI Desktop** | Data modeling, DAX measure creation, UI layout design, and interactive dashboard development. |
| **DAX (Data Analysis Expressions)** | Custom KPIs (`DIVIDE`, `SUM`, `AVERAGE`, `COUNT`), conditional logic, and calculated columns. |
| **GitHub** | Version control, documentation, and portfolio showcase. |

## Project Workflow
* **Raw Dataset**,
* **Python Data Cleaning & EDA**,
* **PostgreSQL Analysis & Business Queries**,
* **Power BI Data Modeling & DAX Measures**,
* **Interactive 1-Page Power BI Dashboard**,
* **Business Insights & Recommendations**

---

## Python Analysis
Performed initial data inspection, type casting, missing value treatment, and distribution checks across key subscriber variables.
* Converted `TotalCharges` to numeric types and imputed missing records.
* Conducted univariate and bivariate EDA to evaluate churn correlation with contract types and tenure.
* Generated baseline distribution plots to guide SQL query logic and Power BI visual layouts.

**Python Notebook:** [telecom_churn_eda.ipynb](python/telecom_churn_eda.ipynb)

---

## SQL Analysis
Structured PostgreSQL queries to aggregate core KPIs and extract customer risk segments for dashboard verification.
* Calculated churn percentages grouped by `Contract` and `InternetService` types.
* Built window functions to rank active accounts by `MonthlyCharges` to surface top revenue-at-risk customers.
* Validated total revenue loss metrics against raw dataset aggregations.

**SQL File:** [churn_analysis_queries.sql](sql/churn_analysis_queries.sql)

---

## Power BI Dashboard
The Power BI report contains 1 dedicated interactive page:

### 1. Churn Analytics
An executive summary view displaying top-tier KPIs, contract churn distribution, tenure risk trends, and a high-risk active customer list.
* **Core KPIs:** Total Customers (7,043), Churned Customers (1,869), Churn Rate (26.54%), Monthly Revenue Lost ($139.13K).
* **Stacked Column Chart (Total Customers by Contract and Churn):** Displays churn distribution across Month-to-month, One year, and Two year contracts, highlighting month-to-month as the highest churn segment.
* **Line Chart (Churn Rate % by Tenure):** Plots attrition probability across tenure months, demonstrating a steep churn rate spike among early-stage subscribers (0–12 months).
* **Donut Chart (Churned Customers by Internet Service):** Breaks down churned subscribers by service type, illustrating that Fiber Optic accounts for the vast majority of lost customers (69.4%).
* **Table Visual (Top 10 High-Risk Accounts):** Dynamically lists active Month-to-month Fiber Optic customers with tenure <= 12 months, sorted by highest monthly charges for immediate intervention.

**Power BI Dashboard File:** [Telecom_Churn_Analytics.pbix](powerbi/Telecom_Churn_Analytics.pbix)

---

## Key KPIs
| KPI | Overall Result |
| :--- | :--- |
| **Total Customers** | 7,043 |
| **Churned Customers** | 1,869 |
| **Churn Rate** | 26.54% |
| **Monthly Revenue Lost** | $139.13K |

---

## Key Business Insights

### Contract & Tenure Vulnerabilities
* **Month-to-Month Contract Risk:** Subscribers on month-to-month agreements account for the overwhelming majority of total churned customers (over 1.6K churned out of 1.87K total).
* **Early Tenure Drop-Off:** Churn rates peak significantly during the first 12 months of service (exceeding 60% in month 1), steadily decreasing as subscriber tenure matures beyond 24 months.

### Product & Revenue Impact
* **Fiber Optic Service Attrition:** Fiber Optic users represent 69.4% of total churned customers, indicating potential service pricing or reliability issues despite high tier adoption.
* **Revenue Exposure:** Total monthly revenue loss stands at $139.13K, driven predominantly by high-paying Fiber Optic account cancellations.

---

## Business Recommendations
* **Contract Transition Incentives:** Offer targeted discounts or loyalty perks to convert high-risk Month-to-Month subscribers into 1-Year or 2-Year commitments.
* **Onboarding Retention Programs:** Implement aggressive customer success and support outreach during the first 90 days of onboarding to mitigate early-tenure drop-offs.
* **Fiber Optic Service Review:** Investigate Fiber Optic service quality and competitive pricing models to address the 69.4% churn concentration in this category.
* **Proactive Account Outreach:** Utilize the Top High-Risk Active Customers view to deploy personalized retention offers to top-tier revenue accounts before contract cancellation.

--- 

## Dashboard Preview

### Churn Analytics
![Churn Analytics](docs/churn_analytics_dashboard.png)
