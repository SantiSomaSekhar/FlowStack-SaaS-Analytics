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
-- =============================================================================
-- SECTION 2 : SUBSCRIPTION ANALYTICS
-- Purpose:
-- Analyze subscription performance, billing behavior,
-- customer retention, and pricing strategy.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q6. Active vs Expired Subscriptions
-- Objective : Compare the number of active and expired subscriptions.
-- -----------------------------------------------------------------------------
SELECT subscription_status,
    COUNT(*) AS total_subscriptions
FROM subscriptions
GROUP BY subscription_status
ORDER BY total_subscriptions DESC;
-- -----------------------------------------------------------------------------
-- Q7. Billing Cycle Distribution
-- Objective : Analyze customer preference for monthly and annual billing.
-- -----------------------------------------------------------------------------
SELECT billing_cycle,
    COUNT(*) AS total_subscriptions
FROM subscriptions
GROUP BY billing_cycle
ORDER BY total_subscriptions DESC;
-- -----------------------------------------------------------------------------
-- Q8. Most Popular Subscription Plans
-- Objective : Identify the subscription plans with the highest customer adoption.
-- -----------------------------------------------------------------------------
SELECT p.plan_name,
    COUNT(*) AS total_subscribers
FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
GROUP BY p.plan_name
ORDER BY total_subscribers DESC;
-- -----------------------------------------------------------------------------
-- Q9. Average Discount Offered by Subscription Plan
-- Objective : Evaluate discount strategies across subscription plans.
-- -----------------------------------------------------------------------------
SELECT p.plan_name,
    ROUND(AVG(s.discount_percent), 2) AS average_discount
FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
GROUP BY p.plan_name
ORDER BY average_discount DESC;
-- -----------------------------------------------------------------------------
-- Q10. Average Subscription Duration
-- Objective : Measure the average subscription period in days.
-- -----------------------------------------------------------------------------
SELECT ROUND(
        AVG(
            DATEDIFF(subscription_end, subscription_start)
        ),
        2
    ) AS average_subscription_duration_days
FROM subscriptions;
-- =============================================================================
-- End of Subscription Analytics
-- =============================================================================