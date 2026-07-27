# Data Dictionary

## Overview

This document provides a detailed description of the database schema used in the **FlowStack SaaS Analytics** project.

The database is designed to simulate the operations of a Software-as-a-Service (SaaS) company and consists of eight relational tables covering customer management, subscription services, billing, product usage, customer support, and account manager performance.

Each section below explains the purpose of the table, its primary and foreign keys, and the business meaning of every column.

---

# Database Summary

| Table            | Purpose                                          |
| ---------------- | ------------------------------------------------ |
| account_managers | Stores account manager information.              |
| customers        | Stores customer master information.              |
| plans            | Stores available subscription plans.             |
| subscriptions    | Stores customer subscription details.            |
| invoices         | Stores invoice and payment information.          |
| support_tickets  | Stores customer support requests.                |
| usage_logs       | Stores monthly product usage statistics.         |
| monthly_targets  | Stores monthly revenue targets and achievements. |

---

# Table Definitions

---

# account_managers

### Purpose

Stores information about account managers responsible for managing customer relationships.

**Primary Key:** `manager_id`

| Column           | Data Type    | Description                                 |
| ---------------- | ------------ | ------------------------------------------- |
| manager_id       | INT          | Unique identifier for each account manager. |
| manager_name     | VARCHAR(100) | Full name of the account manager.           |
| email            | VARCHAR(150) | Official email address.                     |
| region           | VARCHAR(50)  | Assigned business region.                   |
| experience_years | INT          | Years of professional experience.           |
| created_at       | DATETIME     | Record creation timestamp.                  |

---

# customers

### Purpose

Stores customer master information and links each customer to an assigned account manager.

**Primary Key:** `customer_id`

**Foreign Key:** `manager_id → account_managers.manager_id`

| Column              | Data Type    | Description                                     |
| ------------------- | ------------ | ----------------------------------------------- |
| customer_id         | INT          | Unique customer identifier.                     |
| company_name        | VARCHAR(150) | Customer company name.                          |
| industry            | VARCHAR(50)  | Business industry of the customer.              |
| region              | VARCHAR(50)  | Customer operating region.                      |
| acquisition_channel | VARCHAR(50)  | Marketing channel used to acquire the customer. |
| signup_date         | DATE         | Customer registration date.                     |
| manager_id          | INT          | Assigned account manager.                       |
| created_at          | DATETIME     | Record creation timestamp.                      |

---

# plans

### Purpose

Stores subscription plans offered by the SaaS platform.

**Primary Key:** `plan_id`

| Column           | Data Type     | Description                          |
| ---------------- | ------------- | ------------------------------------ |
| plan_id          | INT           | Unique subscription plan identifier. |
| plan_name        | VARCHAR(50)   | Name of the subscription plan.       |
| monthly_price    | DECIMAL(10,2) | Monthly subscription fee.            |
| max_users        | INT           | Maximum users allowed.               |
| storage_limit_gb | INT           | Maximum storage allocation in GB.    |
| created_at       | DATETIME      | Record creation timestamp.           |

---

# subscriptions

### Purpose

Stores customer subscription details and plan information.

**Primary Key:** `subscription_id`

**Foreign Keys:**

- `customer_id → customers.customer_id`
- `plan_id → plans.plan_id`

| Column              | Data Type | Description                           |
| ------------------- | --------- | ------------------------------------- |
| subscription_id     | INT       | Unique subscription identifier.       |
| customer_id         | INT       | Customer owning the subscription.     |
| plan_id             | INT       | Selected subscription plan.           |
| billing_cycle       | ENUM      | Monthly or Annual billing cycle.      |
| subscription_start  | DATE      | Subscription start date.              |
| subscription_end    | DATE      | Subscription end date.                |
| subscription_status | ENUM      | Current subscription status.          |
| discount_percent    | INT       | Discount applied to the subscription. |
| created_at          | DATETIME  | Record creation timestamp.            |

---

# invoices

### Purpose

Stores invoice generation and payment details.

**Primary Key:** `invoice_id`

**Foreign Key:** `subscription_id → subscriptions.subscription_id`

| Column          | Data Type     | Description                |
| --------------- | ------------- | -------------------------- |
| invoice_id      | INT           | Unique invoice identifier. |
| subscription_id | INT           | Related subscription.      |
| invoice_date    | DATE          | Invoice creation date.     |
| due_date        | DATE          | Invoice due date.          |
| paid_date       | DATE          | Payment completion date.   |
| amount          | DECIMAL(10,2) | Invoice amount.            |
| payment_method  | ENUM          | Payment method used.       |
| payment_status  | ENUM          | Invoice payment status.    |
| created_at      | DATETIME      | Record creation timestamp. |

---

# support_tickets

### Purpose

Stores customer support requests and resolution details.

**Primary Key:** `ticket_id`

**Foreign Key:** `customer_id → customers.customer_id`

| Column               | Data Type    | Description                       |
| -------------------- | ------------ | --------------------------------- |
| ticket_id            | INT          | Unique support ticket identifier. |
| customer_id          | INT          | Customer who raised the ticket.   |
| category             | ENUM         | Support request category.         |
| priority             | ENUM         | Ticket priority level.            |
| status               | ENUM         | Current ticket status.            |
| ticket_created_date  | DATE         | Ticket creation date.             |
| ticket_resolved_date | DATE         | Ticket resolution date.           |
| resolution_hours     | INT          | Total resolution time in hours.   |
| customer_rating      | DECIMAL(2,1) | Customer satisfaction rating.     |
| created_at           | DATETIME     | Record creation timestamp.        |

---

# usage_logs

### Purpose

Stores monthly product usage statistics for each customer.

**Primary Key:** `usage_id`

**Foreign Key:** `customer_id → customers.customer_id`

| Column          | Data Type     | Description                                |
| --------------- | ------------- | ------------------------------------------ |
| usage_id        | INT           | Unique usage record identifier.            |
| customer_id     | INT           | Customer associated with the usage record. |
| usage_month     | DATE          | Month of recorded usage.                   |
| active_users    | INT           | Number of active users.                    |
| api_requests    | INT           | Total API requests.                        |
| storage_used_gb | DECIMAL(10,2) | Storage consumed in GB.                    |
| login_count     | INT           | Total user logins.                         |
| created_at      | DATETIME      | Record creation timestamp.                 |

---

# monthly_targets

### Purpose

Stores monthly revenue targets and achievements for account managers.

**Primary Key:** `target_id`

**Foreign Key:** `manager_id → account_managers.manager_id`

| Column           | Data Type     | Description                        |
| ---------------- | ------------- | ---------------------------------- |
| target_id        | INT           | Unique monthly target identifier.  |
| manager_id       | INT           | Assigned account manager.          |
| target_month     | DATE          | Reporting month.                   |
| target_revenue   | DECIMAL(12,2) | Revenue target for the month.      |
| achieved_revenue | DECIMAL(12,2) | Revenue achieved during the month. |
| created_at       | DATETIME      | Record creation timestamp.         |

---

# Database Relationships

```
account_managers
        │
        │
customers
    │
    ├──────────────┐
    │              │
subscriptions   support_tickets
    │
    ├──────────────┐
    │              │
plans        invoices
    │
usage_logs

monthly_targets
      │
account_managers
```

---

# Summary

The FlowStack SaaS Analytics database follows a normalized relational design that separates master data, transactional data, operational metrics, and business performance records.

The schema supports analytical reporting, dashboard development, advanced SQL analysis, and business intelligence workflows while maintaining data integrity through primary and foreign key relationships.
