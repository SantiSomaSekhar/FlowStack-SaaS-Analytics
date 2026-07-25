/*
 ===============================================================================
 Project      : FlowStack SaaS Analytics
 File         : 02_data_import.sql
 
 Description  :
 Imports all CSV datasets into the FlowStack Analytics database
 using MySQL's LOAD DATA LOCAL INFILE command.
 
 Purpose :
 • Import master data
 • Import transactional data
 • Verify successful data loading
 
 Prerequisites :
 • Database must already exist.
 • Tables must be created.
 • local_infile must be enabled.
 • CSV files must exist in the specified directory.
 ===============================================================================
 */
-- =============================================================================
-- STEP 1 : Select Database
-- =============================================================================
USE flowstack_analytics;
-- =============================================================================
-- STEP 2 : Import Master Tables
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Import : Account Managers
-- Purpose:
-- Loads account manager information.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/account_managers.csv' INTO TABLE account_managers FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    manager_id,
    manager_name,
    email,
    region,
    experience_years,
    created_at
);
-- -----------------------------------------------------------------------------
-- Import : Subscription Plans
-- Purpose:
-- Loads all available SaaS subscription plans.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/plans.csv' INTO TABLE plans FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    plan_id,
    plan_name,
    monthly_price,
    max_users,
    storage_limit_gb,
    created_at
);
-- -----------------------------------------------------------------------------
-- Import : Customers
-- Purpose:
-- Loads customer master records.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/customers.csv' INTO TABLE customers FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    customer_id,
    company_name,
    industry,
    region,
    acquisition_channel,
    signup_date,
    manager_id,
    created_at
);
-- =============================================================================
-- STEP 3 : Import Transaction Tables
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Import : Subscriptions
-- Purpose:
-- Loads customer subscription details.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/subscriptions.csv' INTO TABLE subscriptions FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    subscription_id,
    customer_id,
    plan_id,
    billing_cycle,
    subscription_start,
    subscription_end,
    subscription_status,
    discount_percent,
    created_at
);
-- -----------------------------------------------------------------------------
-- Import : Invoices
-- Purpose:
-- Loads invoice and payment information.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/invoices.csv' INTO TABLE invoices FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    invoice_id,
    subscription_id,
    invoice_date,
    due_date,
    paid_date,
    amount,
    payment_method,
    payment_status,
    created_at
);
-- -----------------------------------------------------------------------------
-- Import : Monthly Targets
-- Purpose:
-- Loads monthly revenue targets for account managers.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/monthly_targets.csv' INTO TABLE monthly_targets FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    target_id,
    manager_id,
    target_month,
    target_revenue,
    achieved_revenue,
    created_at
);
-- -----------------------------------------------------------------------------
-- Import : Support Tickets
-- Purpose:
-- Loads customer support ticket records.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/support_tickets.csv' INTO TABLE support_tickets FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    ticket_id,
    customer_id,
    category,
    priority,
    status,
    ticket_created_date,
    ticket_resolved_date,
    resolution_hours,
    customer_rating,
    created_at
);
-- -----------------------------------------------------------------------------
-- Import : Usage Logs
-- Purpose:
-- Loads monthly customer product usage statistics.
-- -----------------------------------------------------------------------------
LOAD DATA LOCAL INFILE 'C:/Users/Admin/OneDrive/Documents/ONEDRIVE KARNA/OneDrive/SOMA SEKHAR/PYTHON/datasets/usage_logs.csv' INTO TABLE usage_logs FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 ROWS (
    usage_id,
    customer_id,
    usage_month,
    active_users,
    api_requests,
    storage_used_gb,
    login_count,
    created_at
);
-- =============================================================================
-- STEP 4 : Verify Imported Data
-- Purpose:
-- Displays the number of records imported into each table.
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
-- Data import completed successfully.
-- =============================================================================