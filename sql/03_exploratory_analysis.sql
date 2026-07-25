/*
 ===============================================================================
 Project      : FlowStack SaaS Analytics
 File         : 03_exploratory_analysis.sql
 
 Description  :
 Performs Exploratory Data Analysis (EDA) on the FlowStack SaaS
 Analytics database to understand the dataset before business analysis.
 
 Objectives :
 • Verify imported records
 • Explore customer demographics
 • Analyze subscription patterns
 • Understand invoice and payment data
 • Examine support ticket trends
 • Explore product usage
 • Perform basic data quality checks
 ===============================================================================
 */
-- =============================================================================
-- STEP 1 : Select Database
-- =============================================================================
USE flowstack_analytics;
-- =============================================================================
-- STEP 2 : Verify Imported Data
-- Purpose:
-- Displays the number of records available in each table.
-- =============================================================================
SELECT 'account_managers' AS table_name,
    COUNT(*) AS total_rows
FROM account_managers
UNION ALL
SELECT 'customers',
    COUNT(*)
FROM customers
UNION ALL
SELECT 'plans',
    COUNT(*)
FROM plans
UNION ALL
SELECT 'subscriptions',
    COUNT(*)
FROM subscriptions
UNION ALL
SELECT 'invoices',
    COUNT(*)
FROM invoices
UNION ALL
SELECT 'support_tickets',
    COUNT(*)
FROM support_tickets
UNION ALL
SELECT 'usage_logs',
    COUNT(*)
FROM usage_logs
UNION ALL
SELECT 'monthly_targets',
    COUNT(*)
FROM monthly_targets;
-- =============================================================================
-- STEP 3 : Preview Sample Data
-- Purpose:
-- Displays sample records from each table for quick inspection.
-- =============================================================================
SELECT *
FROM account_managers
LIMIT 5;
SELECT *
FROM customers
LIMIT 5;
SELECT *
FROM plans
LIMIT 5;
SELECT *
FROM subscriptions
LIMIT 5;
SELECT *
FROM invoices
LIMIT 5;
SELECT *
FROM support_tickets
LIMIT 5;
SELECT *
FROM usage_logs
LIMIT 5;
SELECT *
FROM monthly_targets
LIMIT 5;
-- =============================================================================
-- STEP 4 : Explore Customer Data
-- Purpose:
-- Analyze customer distribution across industries,
-- acquisition channels, and regions.
-- =============================================================================
SELECT industry,
    COUNT(*) AS total_customers
FROM customers
GROUP BY industry
ORDER BY total_customers DESC;
SELECT region,
    COUNT(*) AS total_customers
FROM customers
GROUP BY region
ORDER BY total_customers DESC;
SELECT acquisition_channel,
    COUNT(*) AS total_customers
FROM customers
GROUP BY acquisition_channel
ORDER BY total_customers DESC;
-- =============================================================================
-- STEP 5 : Explore Subscription Data
-- Purpose:
-- Analyze subscription status, billing cycle,
-- and plan popularity.
-- =============================================================================
SELECT subscription_status,
    COUNT(*) AS total_subscriptions
FROM subscriptions
GROUP BY subscription_status;
SELECT billing_cycle,
    COUNT(*) AS total_subscriptions
FROM subscriptions
GROUP BY billing_cycle;
SELECT plan_id,
    COUNT(*) AS subscribers
FROM subscriptions
GROUP BY plan_id
ORDER BY subscribers DESC;
-- =============================================================================
-- STEP 6 : Explore Invoice Data
-- Purpose:
-- Understand invoice values and payment behavior.
-- =============================================================================
SELECT MIN(amount) AS minimum_invoice,
    MAX(amount) AS maximum_invoice,
    ROUND(AVG(amount), 2) AS average_invoice
FROM invoices;
SELECT payment_status,
    COUNT(*) AS total_invoices
FROM invoices
GROUP BY payment_status;
SELECT payment_method,
    COUNT(*) AS total_payments
FROM invoices
GROUP BY payment_method;
-- =============================================================================
-- STEP 7 : Explore Support Ticket Data
-- Purpose:
-- Analyze customer support activity.
-- =============================================================================
SELECT category,
    COUNT(*) AS total_tickets
FROM support_tickets
GROUP BY category;
SELECT priority,
    COUNT(*) AS total_tickets
FROM support_tickets
GROUP BY priority;
SELECT status,
    COUNT(*) AS total_tickets
FROM support_tickets
GROUP BY status;
SELECT ROUND(AVG(resolution_hours), 2) AS average_resolution_hours
FROM support_tickets;
-- =============================================================================
-- STEP 8 : Explore Product Usage
-- Purpose:
-- Analyze customer product usage behavior.
-- =============================================================================
SELECT ROUND(AVG(active_users), 2) AS avg_active_users,
    ROUND(AVG(api_requests), 2) AS avg_api_requests,
    ROUND(AVG(storage_used_gb), 2) AS avg_storage_used_gb,
    ROUND(AVG(login_count), 2) AS avg_login_count
FROM usage_logs;
-- =============================================================================
-- STEP 9 : Explore Monthly Targets
-- Purpose:
-- Review revenue targets assigned to account managers.
-- =============================================================================
SELECT MIN(target_revenue) AS minimum_target,
    MAX(target_revenue) AS maximum_target,
    ROUND(AVG(target_revenue), 2) AS average_target
FROM monthly_targets;
-- =============================================================================
-- STEP 10 : Data Quality Checks
-- Purpose:
-- Check important foreign key columns for NULL values.
-- =============================================================================
SELECT COUNT(*) AS customers_without_manager
FROM customers
WHERE manager_id IS NULL;
SELECT COUNT(*) AS subscriptions_without_customer
FROM subscriptions
WHERE customer_id IS NULL;
SELECT COUNT(*) AS subscriptions_without_plan
FROM subscriptions
WHERE plan_id IS NULL;
SELECT COUNT(*) AS invoices_without_subscription
FROM invoices
WHERE subscription_id IS NULL;
SELECT COUNT(*) AS tickets_without_customer
FROM support_tickets
WHERE customer_id IS NULL;
SELECT COUNT(*) AS usage_without_customer
FROM usage_logs
WHERE customer_id IS NULL;
SELECT COUNT(*) AS targets_without_manager
FROM monthly_targets
WHERE manager_id IS NULL;
-- =============================================================================
-- Exploratory Data Analysis Completed Successfully
-- =============================================================================