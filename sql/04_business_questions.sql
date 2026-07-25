/*
 ===============================================================================
 Project      : FlowStack SaaS Analytics
 File         : 04_business_questions.sql
 
 Description  :
 Solves real-world SaaS business problems using SQL queries.
 Each query provides meaningful insights to support business
 decisions across sales, finance, marketing, customer success,
 and executive management.
 
 Sections :
 1. Customer Analytics
 2. Subscription Analytics
 3. Revenue Analytics
 4. Customer Value Analysis
 5. Customer Support Analytics
 6. Product Usage Analytics
 7. Account Manager Performance
 8. Executive KPIs
 ===============================================================================
 */
USE flowstack_analytics;
-- =============================================================================
-- SECTION 1 : CUSTOMER ANALYTICS
-- Purpose:
-- Analyze customer distribution, acquisition trends,
-- and overall customer growth.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q1. Total Customer Base
-- Objective : Determine the total number of registered customers.
-- -----------------------------------------------------------------------------
SELECT COUNT(*) AS total_customers
FROM customers;
-- -----------------------------------------------------------------------------
-- Q2. Customer Distribution by Industry
-- Objective : Identify industries with the highest customer count.
-- -----------------------------------------------------------------------------
SELECT industry,
    COUNT(*) AS total_customers
FROM customers
GROUP BY industry
ORDER BY total_customers DESC;
-- -----------------------------------------------------------------------------
-- Q3. Customer Distribution by Region
-- Objective : Analyze customer concentration across different regions.
-- -----------------------------------------------------------------------------
SELECT region,
    COUNT(*) AS total_customers
FROM customers
GROUP BY region
ORDER BY total_customers DESC;
-- -----------------------------------------------------------------------------
-- Q4. Customer Acquisition by Marketing Channel
-- Objective : Measure the effectiveness of acquisition channels.
-- -----------------------------------------------------------------------------
SELECT acquisition_channel,
    COUNT(*) AS total_customers
FROM customers
GROUP BY acquisition_channel
ORDER BY total_customers DESC;
-- -----------------------------------------------------------------------------
-- Q5. Monthly Customer Growth Trend
-- Objective : Track new customer registrations over time.
-- -----------------------------------------------------------------------------
SELECT DATE_FORMAT(signup_date, '%Y-%m') AS signup_month,
    COUNT(*) AS new_customers
FROM customers
GROUP BY DATE_FORMAT(signup_date, '%Y-%m')
ORDER BY signup_month;
-- =============================================================================
-- End of Customer Analytics
-- =============================================================================