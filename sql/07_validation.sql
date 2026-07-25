/*
 ===============================================================================
 Project      : FlowStack SaaS Analytics
 File         : 07_validation.sql
 
 Description  :
 Validates data quality and integrity after data import.
 Performs checks for row counts, NULL values, duplicates,
 foreign key consistency, and business rule validation.
 ===============================================================================
 */
USE flowstack_analytics;
-- -----------------------------------------------------------------------------
-- Q1. Verify Record Count for All Tables
-- Objective : Ensure all datasets have been imported successfully.
-- -----------------------------------------------------------------------------
SELECT 'account_managers' AS table_name,
    COUNT(*) AS total_records
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
-- -----------------------------------------------------------------------------
-- Q2. Check Critical Columns for NULL Values
-- Objective : Ensure key foreign keys and business columns are populated.
-- -----------------------------------------------------------------------------
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
-- -----------------------------------------------------------------------------
-- Q3. Check for Duplicate Customer Records
-- Objective : Ensure customer IDs remain unique.
-- -----------------------------------------------------------------------------
SELECT customer_id,
    COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
-- -----------------------------------------------------------------------------
-- Q4. Check for Duplicate Invoice Records
-- -----------------------------------------------------------------------------
SELECT invoice_id,
    COUNT(*) AS duplicate_count
FROM invoices
GROUP BY invoice_id
HAVING COUNT(*) > 1;
-- -----------------------------------------------------------------------------
-- Q5. Verify Customer References in Subscriptions
-- Objective : Identify subscriptions referencing missing customers.
-- -----------------------------------------------------------------------------
SELECT s.subscription_id
FROM subscriptions s
    LEFT JOIN customers c ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;
-- -----------------------------------------------------------------------------
-- Q6. Verify Subscription References in Invoices
-- -----------------------------------------------------------------------------
SELECT i.invoice_id
FROM invoices i
    LEFT JOIN subscriptions s ON i.subscription_id = s.subscription_id
WHERE s.subscription_id IS NULL;
-- -----------------------------------------------------------------------------
-- Q7. Validate Invoice Amounts
-- Objective : Identify invoices with zero or negative values.
-- -----------------------------------------------------------------------------
SELECT *
FROM invoices
WHERE amount <= 0;
-- -----------------------------------------------------------------------------
-- Q8. Validate Resolution Hours
-- -----------------------------------------------------------------------------
SELECT *
FROM support_tickets
WHERE resolution_hours < 0;
-- -----------------------------------------------------------------------------
-- Q9. Validate Customer Ratings
-- -----------------------------------------------------------------------------
SELECT *
FROM support_tickets
WHERE customer_rating NOT BETWEEN 0 AND 5;
-- -----------------------------------------------------------------------------
-- Q10. Validate Subscription Dates
-- Objective : Ensure subscription end dates occur after start dates.
-- -----------------------------------------------------------------------------
SELECT *
FROM subscriptions
WHERE subscription_end < subscription_start;
-- -----------------------------------------------------------------------------
-- Q11. Validate Invoice Dates
-- -----------------------------------------------------------------------------
SELECT *
FROM invoices
WHERE paid_date < invoice_date;
-- -----------------------------------------------------------------------------
-- Q12. Overall Data Quality Status
-- Objective : Display overall table statistics.
-- -----------------------------------------------------------------------------
SELECT (
        SELECT COUNT(*)
        FROM customers
    ) AS total_customers,
    (
        SELECT COUNT(*)
        FROM subscriptions
    ) AS total_subscriptions,
    (
        SELECT COUNT(*)
        FROM invoices
    ) AS total_invoices,
    (
        SELECT COUNT(*)
        FROM support_tickets
    ) AS total_support_tickets,
    (
        SELECT COUNT(*)
        FROM usage_logs
    ) AS total_usage_records;
-- =============================================================================
-- DATA VALIDATION COMPLETED
--
-- Validation Areas:
-- • Record Counts
-- • NULL Values
-- • Duplicate Records
-- • Referential Integrity
-- • Business Rules
-- • Date Validation
-- =============================================================================