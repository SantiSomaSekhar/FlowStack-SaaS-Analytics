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
-- =============================================================================
-- SECTION 5 : CUSTOMER SUPPORT ANALYTICS
-- Purpose:
-- Analyze customer support performance, ticket distribution,
-- resolution efficiency, and customer satisfaction.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q21. Support Tickets by Category
-- Objective : Identify the most common customer support requests.
-- -----------------------------------------------------------------------------
SELECT category,
    COUNT(*) AS total_tickets
FROM support_tickets
GROUP BY category
ORDER BY total_tickets DESC;
-- -----------------------------------------------------------------------------
-- Q22. Support Tickets by Priority
-- Objective : Analyze the distribution of ticket priorities.
-- -----------------------------------------------------------------------------
SELECT priority,
    COUNT(*) AS total_tickets
FROM support_tickets
GROUP BY priority
ORDER BY total_tickets DESC;
-- -----------------------------------------------------------------------------
-- Q23. Average Resolution Time by Ticket Category
-- Objective : Measure how quickly different types of support requests are resolved.
-- -----------------------------------------------------------------------------
SELECT category,
    ROUND(AVG(resolution_hours), 2) AS average_resolution_hours
FROM support_tickets
WHERE ticket_resolved_date IS NOT NULL
GROUP BY category
ORDER BY average_resolution_hours;
-- -----------------------------------------------------------------------------
-- Q24. Average Customer Satisfaction Rating
-- Objective : Evaluate overall customer satisfaction with support services.
-- -----------------------------------------------------------------------------
SELECT ROUND(AVG(customer_rating), 2) AS average_customer_rating
FROM support_tickets
WHERE customer_rating IS NOT NULL;
-- -----------------------------------------------------------------------------
-- Q25. Ticket Status Distribution
-- Objective : Monitor the current status of customer support tickets.
-- -----------------------------------------------------------------------------
SELECT status,
    COUNT(*) AS total_tickets
FROM support_tickets
GROUP BY status
ORDER BY total_tickets DESC;
-- =============================================================================
-- End of Customer Support Analytics
-- =============================================================================
-- =============================================================================
-- SECTION 6 : PRODUCT USAGE ANALYTICS
-- Purpose:
-- Analyze customer engagement, platform usage,
-- and product adoption trends.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q26. Average Product Usage Metrics
-- Objective : Measure the average customer usage across key platform metrics.
-- -----------------------------------------------------------------------------
SELECT ROUND(AVG(active_users), 2) AS avg_active_users,
    ROUND(AVG(api_requests), 2) AS avg_api_requests,
    ROUND(AVG(storage_used_gb), 2) AS avg_storage_used_gb,
    ROUND(AVG(login_count), 2) AS avg_login_count
FROM usage_logs;
-- -----------------------------------------------------------------------------
-- Q27. Top 10 Customers by API Requests
-- Objective : Identify customers generating the highest API traffic.
-- -----------------------------------------------------------------------------
SELECT c.customer_id,
    c.company_name,
    SUM(u.api_requests) AS total_api_requests
FROM customers c
    JOIN usage_logs u ON c.customer_id = u.customer_id
GROUP BY c.customer_id,
    c.company_name
ORDER BY total_api_requests DESC
LIMIT 10;
-- -----------------------------------------------------------------------------
-- Q28. Top 10 Customers by Storage Usage
-- Objective : Identify customers consuming the highest storage capacity.
-- -----------------------------------------------------------------------------
SELECT c.customer_id,
    c.company_name,
    ROUND(SUM(u.storage_used_gb), 2) AS total_storage_used_gb
FROM customers c
    JOIN usage_logs u ON c.customer_id = u.customer_id
GROUP BY c.customer_id,
    c.company_name
ORDER BY total_storage_used_gb DESC
LIMIT 10;
-- -----------------------------------------------------------------------------
-- Q29. Top 10 Customers by Login Activity
-- Objective : Identify the most active customers based on login frequency.
-- -----------------------------------------------------------------------------
SELECT c.customer_id,
    c.company_name,
    SUM(u.login_count) AS total_logins
FROM customers c
    JOIN usage_logs u ON c.customer_id = u.customer_id
GROUP BY c.customer_id,
    c.company_name
ORDER BY total_logins DESC
LIMIT 10;
-- -----------------------------------------------------------------------------
-- Q30. Monthly Product Usage Trend
-- Objective : Monitor overall platform usage over time.
-- -----------------------------------------------------------------------------
SELECT DATE_FORMAT(usage_month, '%Y-%m') AS usage_month,
    SUM(active_users) AS total_active_users,
    SUM(api_requests) AS total_api_requests,
    ROUND(SUM(storage_used_gb), 2) AS total_storage_used_gb
FROM usage_logs
GROUP BY DATE_FORMAT(usage_month, '%Y-%m')
ORDER BY usage_month;
-- =============================================================================
-- End of Product Usage Analytics
-- =============================================================================
-- =============================================================================
-- SECTION 7 : ACCOUNT MANAGER PERFORMANCE
-- Purpose:
-- Evaluate account manager performance based on customer portfolio,
-- revenue generation, and target achievement.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q31. Customers Managed by Each Account Manager
-- Objective : Determine the customer portfolio handled by each manager.
-- -----------------------------------------------------------------------------
SELECT am.manager_id,
    am.manager_name,
    COUNT(c.customer_id) AS total_customers
FROM account_managers am
    LEFT JOIN customers c ON am.manager_id = c.manager_id
GROUP BY am.manager_id,
    am.manager_name
ORDER BY total_customers DESC;
-- -----------------------------------------------------------------------------
-- Q32. Revenue Managed by Each Account Manager
-- Objective : Calculate the revenue generated by customers under each manager.
-- -----------------------------------------------------------------------------
SELECT am.manager_id,
    am.manager_name,
    ROUND(SUM(i.amount), 2) AS total_revenue
FROM account_managers am
    JOIN customers c ON am.manager_id = c.manager_id
    JOIN subscriptions s ON c.customer_id = s.customer_id
    JOIN invoices i ON s.subscription_id = i.subscription_id
WHERE i.payment_status = 'Paid'
GROUP BY am.manager_id,
    am.manager_name
ORDER BY total_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q33. Monthly Revenue Target Achievement
-- Objective : Compare target revenue against achieved revenue.
-- -----------------------------------------------------------------------------
SELECT am.manager_name,
    DATE_FORMAT(mt.target_month, '%Y-%m') AS target_month,
    mt.target_revenue,
    mt.achieved_revenue,
    ROUND(
        (mt.achieved_revenue / mt.target_revenue) * 100,
        2
    ) AS target_achievement_percentage
FROM monthly_targets mt
    JOIN account_managers am ON mt.manager_id = am.manager_id
ORDER BY target_month,
    am.manager_name;
-- -----------------------------------------------------------------------------
-- Q34. Managers Exceeding Revenue Targets
-- Objective : Identify managers whose achieved revenue exceeded their targets.
-- -----------------------------------------------------------------------------
SELECT am.manager_name,
    mt.target_month,
    mt.target_revenue,
    mt.achieved_revenue
FROM monthly_targets mt
    JOIN account_managers am ON mt.manager_id = am.manager_id
WHERE mt.achieved_revenue > mt.target_revenue
ORDER BY mt.achieved_revenue DESC;
-- -----------------------------------------------------------------------------
-- Q35. Best Performing Account Managers
-- Objective : Rank managers based on total achieved revenue.
-- -----------------------------------------------------------------------------
SELECT am.manager_name,
    ROUND(SUM(mt.achieved_revenue), 2) AS total_achieved_revenue
FROM account_managers am
    JOIN monthly_targets mt ON am.manager_id = mt.manager_id
GROUP BY am.manager_name
ORDER BY total_achieved_revenue DESC;
-- =============================================================================
-- End of Account Manager Performance
-- =============================================================================
-- =============================================================================
-- SECTION 8 : EXECUTIVE KPI DASHBOARD
-- Purpose:
-- Calculate executive-level SaaS KPIs used for monitoring
-- business growth and overall company performance.
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Q36. Monthly Recurring Revenue (MRR)
-- Objective : Calculate the recurring monthly revenue generated from
-- active monthly subscriptions.
-- -----------------------------------------------------------------------------
SELECT ROUND(SUM(p.monthly_price), 2) AS monthly_recurring_revenue
FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
WHERE s.subscription_status = 'Active'
    AND s.billing_cycle = 'Monthly';
-- -----------------------------------------------------------------------------
-- Q37. Annual Recurring Revenue (ARR)
-- Objective : Estimate annual recurring revenue generated from
-- active subscriptions.
-- -----------------------------------------------------------------------------
SELECT ROUND(SUM(p.monthly_price * 12), 2) AS annual_recurring_revenue
FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
WHERE s.subscription_status = 'Active';
-- -----------------------------------------------------------------------------
-- Q38. Average Revenue Per Customer (ARPU)
-- Objective : Measure the average revenue generated per customer.
-- -----------------------------------------------------------------------------
SELECT ROUND(SUM(i.amount) / COUNT(DISTINCT s.customer_id), 2) AS average_revenue_per_customer
FROM invoices i
    JOIN subscriptions s ON i.subscription_id = s.subscription_id
WHERE i.payment_status = 'Paid';
-- -----------------------------------------------------------------------------
-- Q39. Active Customer Percentage
-- Objective : Measure the percentage of customers with
-- active subscriptions.
-- -----------------------------------------------------------------------------
SELECT ROUND(
        COUNT(
            DISTINCT CASE
                WHEN subscription_status = 'Active' THEN customer_id
            END
        ) * 100.0 / COUNT(DISTINCT customer_id),
        2
    ) AS active_customer_percentage
FROM subscriptions;
-- -----------------------------------------------------------------------------
-- Q40. Customer Churn Rate
-- Objective : Calculate the percentage of customers
-- with expired subscriptions.
-- -----------------------------------------------------------------------------
SELECT ROUND(
        COUNT(
            DISTINCT CASE
                WHEN subscription_status = 'Expired' THEN customer_id
            END
        ) * 100.0 / COUNT(DISTINCT customer_id),
        2
    ) AS customer_churn_rate
FROM subscriptions;
-- =============================================================================
-- BUSINESS QUESTIONS COMPLETED
-- Total Business Questions : 40
-- =============================================================================
-- =============================================================================
-- End of File
--
-- Total Sections  : 8
-- Total Queries   : 40
-- Database        : FlowStack SaaS Analytics
-- =============================================================================