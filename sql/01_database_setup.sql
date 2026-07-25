/*
 ===============================================================================
 Project      : FlowStack SaaS Analytics
 File         : 01_database_setup.sql
 Author       : SANTENNAGARI SOMA SEKHAR
 Description  : 
 Creates the FlowStack SaaS Analytics database, tables,
 relationships, and indexes required for the project.
 
 Database Objects Created:
 • account_managers
 • customers
 • plans
 • subscriptions
 • invoices
 • support_tickets
 • usage_logs
 • monthly_targets
 
 Additional Objects:
 • Foreign Key Constraints
 • Performance Indexes
 ===============================================================================
 */
-- =============================================================================
-- STEP 1 : Create Database
-- =============================================================================
DROP DATABASE IF EXISTS flowstack_analytics;
CREATE DATABASE flowstack_analytics;
USE flowstack_analytics;
-- =============================================================================
-- STEP 2 : Create Master Tables
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Table : account_managers
-- Purpose:
-- Stores account manager information responsible for customer relationships.
-- -----------------------------------------------------------------------------
CREATE TABLE account_managers(
    manager_id INT PRIMARY KEY,
    manager_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    region VARCHAR(50),
    experience_years INT,
    created_at DATETIME
);
-- -----------------------------------------------------------------------------
-- Table : customers
-- Purpose:
-- Stores customer master information and links each customer
-- to an assigned account manager.
-- -----------------------------------------------------------------------------
CREATE TABLE customers(
    customer_id INT PRIMARY KEY,
    company_name VARCHAR(150),
    industry VARCHAR(50),
    region VARCHAR(50),
    acquisition_channel VARCHAR(50),
    signup_date DATE,
    manager_id INT,
    created_at DATETIME,
    CONSTRAINT fk_customer_manager FOREIGN KEY(manager_id) REFERENCES account_managers(manager_id)
);
-- -----------------------------------------------------------------------------
-- Table : plans
-- Purpose:
-- Stores subscription plans offered by the SaaS company.
-- -----------------------------------------------------------------------------
CREATE TABLE plans(
    plan_id INT PRIMARY KEY,
    plan_name VARCHAR(50),
    monthly_price DECIMAL(10, 2),
    max_users INT,
    storage_limit_gb INT,
    created_at DATETIME
);
-- =============================================================================
-- STEP 3 : Create Transaction Tables
-- =============================================================================
-- -----------------------------------------------------------------------------
-- Table : subscriptions
-- Purpose:
-- Stores customer subscription details including plan,
-- billing cycle, discounts, and subscription status.
-- -----------------------------------------------------------------------------
CREATE TABLE subscriptions(
    subscription_id INT PRIMARY KEY,
    customer_id INT,
    plan_id INT,
    billing_cycle ENUM('Monthly', 'Annual'),
    subscription_start DATE,
    subscription_end DATE,
    subscription_status ENUM('Active', 'Expired'),
    discount_percent INT,
    created_at DATETIME,
    CONSTRAINT fk_subscription_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_subscription_plan FOREIGN KEY(plan_id) REFERENCES plans(plan_id)
);
-- -----------------------------------------------------------------------------
-- Table : invoices
-- Purpose:
-- Stores invoice generation and payment information
-- for customer subscriptions.
-- -----------------------------------------------------------------------------
CREATE TABLE invoices(
    invoice_id INT PRIMARY KEY,
    subscription_id INT,
    invoice_date DATE,
    due_date DATE,
    paid_date DATE,
    amount DECIMAL(10, 2),
    payment_method ENUM(
        'Credit Card',
        'Debit Card',
        'UPI',
        'Bank Transfer'
    ),
    payment_status ENUM(
        'Paid',
        'Pending',
        'Failed'
    ),
    created_at DATETIME,
    CONSTRAINT fk_invoice_subscription FOREIGN KEY(subscription_id) REFERENCES subscriptions(subscription_id)
);
-- -----------------------------------------------------------------------------
-- Table : support_tickets
-- Purpose:
-- Stores customer support requests, priorities,
-- resolution details, and customer feedback.
-- -----------------------------------------------------------------------------
CREATE TABLE support_tickets(
    ticket_id INT PRIMARY KEY,
    customer_id INT,
    category ENUM(
        'Technical',
        'Billing',
        'Feature Request',
        'General'
    ),
    priority ENUM(
        'Low',
        'Medium',
        'High',
        'Critical'
    ),
    status ENUM(
        'Open',
        'In Progress',
        'Resolved',
        'Closed'
    ),
    ticket_created_date DATE,
    ticket_resolved_date DATE,
    resolution_hours INT,
    customer_rating DECIMAL(2, 1),
    created_at DATETIME,
    CONSTRAINT fk_ticket_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
-- -----------------------------------------------------------------------------
-- Table : usage_logs
-- Purpose:
-- Stores monthly product usage statistics for each customer.
-- -----------------------------------------------------------------------------
CREATE TABLE usage_logs(
    usage_id INT PRIMARY KEY,
    customer_id INT,
    usage_month DATE,
    active_users INT,
    api_requests INT,
    storage_used_gb DECIMAL(10, 2),
    login_count INT,
    created_at DATETIME,
    CONSTRAINT fk_usage_customer FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
-- -----------------------------------------------------------------------------
-- Table : monthly_targets
-- Purpose:
-- Stores monthly revenue targets and achievements
-- for account managers.
-- -----------------------------------------------------------------------------
CREATE TABLE monthly_targets(
    target_id INT PRIMARY KEY,
    manager_id INT,
    target_month DATE,
    target_revenue DECIMAL(12, 2),
    achieved_revenue DECIMAL(12, 2),
    created_at DATETIME,
    CONSTRAINT fk_target_manager FOREIGN KEY(manager_id) REFERENCES account_managers(manager_id)
);
-- =============================================================================
-- STEP 4 : Create Performance Indexes
-- Purpose:
-- Improves query performance for joins, filtering,
-- and reporting operations.
-- =============================================================================
CREATE INDEX idx_customer_manager ON customers(manager_id);
CREATE INDEX idx_customer_signup ON customers(signup_date);
CREATE INDEX idx_subscription_customer ON subscriptions(customer_id);
CREATE INDEX idx_subscription_plan ON subscriptions(plan_id);
CREATE INDEX idx_invoice_subscription ON invoices(subscription_id);
CREATE INDEX idx_invoice_date ON invoices(invoice_date);
CREATE INDEX idx_ticket_customer ON support_tickets(customer_id);
CREATE INDEX idx_usage_customer ON usage_logs(customer_id);
CREATE INDEX idx_target_manager ON monthly_targets(manager_id);
-- =============================================================================
-- Database setup completed successfully.
-- =============================================================================
SHOW TABLES;
-- =============================================================================
-- STEP 5 : Verify Database Objects
-- =============================================================================
SHOW TABLES;
