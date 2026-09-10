CREATE TABLE customer_churn (
    customerID VARCHAR(50) PRIMARY KEY,
    gender VARCHAR(20),
    SeniorCitizen VARCHAR(5),
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(25),
    InternetService VARCHAR(25),
    OnlineSecurity VARCHAR(25),
    OnlineBackup VARCHAR(25),
    DeviceProtection VARCHAR(25),
    TechSupport VARCHAR(25),
    StreamingTV VARCHAR(25),
    StreamingMovies VARCHAR(25),
    Contract VARCHAR(25),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges NUMERIC(10, 2),
    TotalCharges NUMERIC(10, 2),
    Churn VARCHAR(5)
);

SELECT COUNT(*) FROM customer_churn;

SELECT * FROM customer_churn;


-- Step 1 :- Overall Key Performance Indicators (KPIs)

SELECT 
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_percentage,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) AS monthly_revenue_lost
FROM customer_churn;


-- Step 2 :- Churn Analysis by Customer Segmentation

-- 2.1 :- Churn Rate by Contract Type

SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Contract
ORDER BY churn_rate_pct DESC;

-- 2.2 :- Churn Rate by Internet Service

SELECT 
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY InternetService
ORDER BY churn_rate_pct DESC;


-- Step 3 :- Customer Tenure Bucketing (Cohort Analysis)

SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year (New)'
        WHEN tenure <= 24 THEN '1-2 Years'
        WHEN tenure <= 48 THEN '2-4 Years'
        ELSE '4+ Years (Loyal)'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY tenure_group
ORDER BY churn_rate_pct DESC;


-- Step 4 :- High Risk Customer Identification (Business Action Query)

SELECT 
    customerID,
    tenure,
    Contract,
    InternetService,
    MonthlyCharges,
    TotalCharges
FROM customer_churn
WHERE Contract = 'Month-to-month'
  AND InternetService = 'Fiber optic'
  AND tenure <= 12
  AND Churn = 'No'
ORDER BY MonthlyCharges DESC;


-- Step 5 :- High Revenue Loss Customers Ranking (by Contract Type)

WITH RankedLostRevenue AS (
    SELECT 
        customerID,
        Contract,
        MonthlyCharges,
        TotalCharges,
        tenure,
        DENSE_RANK() OVER (
            PARTITION BY Contract 
            ORDER BY MonthlyCharges DESC
        ) AS revenue_rank
    FROM customer_churn
    WHERE Churn = 'Yes'
)
SELECT 
    Contract,
    revenue_rank,
    customerID,
    MonthlyCharges,
    TotalCharges,
    tenure
FROM RankedLostRevenue
WHERE revenue_rank <= 3
ORDER BY Contract, revenue_rank;

-- Step 6 :- Active Customers Risk Profiling & Revenue Exposure (Risk Scoring)

WITH CustomerRiskScore AS (
    SELECT 
        customerID,
        MonthlyCharges,
        tenure,
        Contract,
        InternetService,
        CASE 
            WHEN Contract = 'Month-to-month' AND InternetService = 'Fiber optic' AND tenure <= 12 THEN 'High Risk'
            WHEN Contract = 'Month-to-month' OR tenure <= 24 THEN 'Medium Risk'
            ELSE 'Low Risk'
        END AS risk_category
    FROM customer_churn
    WHERE Churn = 'No'
)
SELECT 
    risk_category,
    COUNT(*) AS total_active_customers,
    ROUND(SUM(MonthlyCharges), 2) AS potential_mrr_at_risk,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charge
FROM CustomerRiskScore
GROUP BY risk_category
ORDER BY potential_mrr_at_risk DESC;