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
-- =============================================================================
-- SECTION 3 : REVENUE ANALYTICS
-- Purpose:
-- Analyze company revenue, identify top-performing subscription plans,
-- evaluate regional performance, and monitor revenue trends.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q11. Total Revenue Generated
-- Objective : Calculate the total revenue generated from all invoices.
-- -----------------------------------------------------------------------------
SELECT ROUND(SUM(amount), 2) AS total_revenue
FROM invoices
WHERE payment_status = 'Paid';
-- -----------------------------------------------------------------------------
-- Q12. Revenue by Subscription Plan
-- Objective : Identify which subscription plans generate the highest revenue.
-- -----------------------------------------------------------------------------
SELECT p.plan_name,
    ROUND(SUM(i.amount), 2) AS total_revenue
FROM invoices i
    JOIN subscriptions s ON i.subscription_id = s.subscription_id
    JOIN plans p ON s.plan_id = p.plan_id
WHERE i.payment_status = 'Paid'
GROUP BY p.plan_name
ORDER BY total_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q13. Revenue by Customer Region
-- Objective : Compare revenue contribution across different regions.
-- -----------------------------------------------------------------------------
SELECT c.region,
    ROUND(SUM(i.amount), 2) AS total_revenue
FROM invoices i
    JOIN subscriptions s ON i.subscription_id = s.subscription_id
    JOIN customers c ON s.customer_id = c.customer_id
WHERE i.payment_status = 'Paid'
GROUP BY c.region
ORDER BY total_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q14. Monthly Revenue Trend
-- Objective : Monitor monthly revenue growth over time.
-- -----------------------------------------------------------------------------
SELECT DATE_FORMAT(invoice_date, '%Y-%m') AS revenue_month,
    ROUND(SUM(amount), 2) AS monthly_revenue
FROM invoices
WHERE payment_status = 'Paid'
GROUP BY DATE_FORMAT(invoice_date, '%Y-%m')
ORDER BY revenue_month;
-- -----------------------------------------------------------------------------
-- Q15. Average Invoice Value
-- Objective : Measure the average revenue generated per paid invoice.
-- -----------------------------------------------------------------------------
SELECT ROUND(AVG(amount), 2) AS average_invoice_value
FROM invoices
WHERE payment_status = 'Paid';
-- =============================================================================
-- End of Revenue Analytics
-- =============================================================================
-- =============================================================================
-- SECTION 4 : CUSTOMER VALUE ANALYSIS
-- Purpose:
-- Identify high-value customers, evaluate customer spending,
-- and measure revenue contribution across the customer base.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q16. Top 10 Customers by Revenue
-- Objective : Identify customers generating the highest revenue.
-- -----------------------------------------------------------------------------
SELECT c.customer_id,
    c.company_name,
    ROUND(SUM(i.amount), 2) AS total_revenue
FROM customers c
    JOIN subscriptions s ON c.customer_id = s.customer_id
    JOIN invoices i ON s.subscription_id = i.subscription_id
WHERE i.payment_status = 'Paid'
GROUP BY c.customer_id,
    c.company_name
ORDER BY total_revenue DESC
LIMIT 10;
-- -----------------------------------------------------------------------------
-- Q17. Revenue Contribution by Industry
-- Objective : Compare revenue generated across different industries.
-- -----------------------------------------------------------------------------
SELECT c.industry,
    ROUND(SUM(i.amount), 2) AS total_revenue
FROM customers c
    JOIN subscriptions s ON c.customer_id = s.customer_id
    JOIN invoices i ON s.subscription_id = i.subscription_id
WHERE i.payment_status = 'Paid'
GROUP BY c.industry
ORDER BY total_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q18. Customer Lifetime Revenue
-- Objective : Calculate the lifetime revenue generated by each customer.
-- -----------------------------------------------------------------------------
SELECT c.customer_id,
    c.company_name,
    ROUND(SUM(i.amount), 2) AS lifetime_revenue
FROM customers c
    JOIN subscriptions s ON c.customer_id = s.customer_id
    JOIN invoices i ON s.subscription_id = i.subscription_id
WHERE i.payment_status = 'Paid'
GROUP BY c.customer_id,
    c.company_name
ORDER BY lifetime_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q19. Average Customer Revenue
-- Objective : Measure the average revenue generated per customer.
-- -----------------------------------------------------------------------------
SELECT ROUND(AVG(customer_revenue), 2) AS average_customer_revenue
FROM (
        SELECT c.customer_id,
            SUM(i.amount) AS customer_revenue
        FROM customers c
            JOIN subscriptions s ON c.customer_id = s.customer_id
            JOIN invoices i ON s.subscription_id = i.subscription_id
        WHERE i.payment_status = 'Paid'
        GROUP BY c.customer_id
    ) AS revenue_summary;
-- -----------------------------------------------------------------------------
-- Q20. Customers Generating Above-Average Revenue
-- Objective : Identify customers whose lifetime revenue exceeds the overall customer average.
-- -----------------------------------------------------------------------------
SELECT customer_id,
    company_name,
    lifetime_revenue
FROM (
        SELECT c.customer_id,
            c.company_name,
            SUM(i.amount) AS lifetime_revenue
        FROM customers c
            JOIN subscriptions s ON c.customer_id = s.customer_id
            JOIN invoices i ON s.subscription_id = i.subscription_id
        WHERE i.payment_status = 'Paid'
        GROUP BY c.customer_id,
            c.company_name
    ) AS customer_summary
WHERE lifetime_revenue > (
        SELECT AVG(customer_revenue)
        FROM (
                SELECT SUM(i.amount) AS customer_revenue
                FROM customers c
                    JOIN subscriptions s ON c.customer_id = s.customer_id
                    JOIN invoices i ON s.subscription_id = i.subscription_id
                WHERE i.payment_status = 'Paid'
                GROUP BY c.customer_id
            ) AS avg_revenue
    )
ORDER BY lifetime_revenue DESC;
-- =============================================================================
-- End of Customer Value Analysis
-- =============================================================================