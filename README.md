
<div align="center">

---

## 📌 Project Overview

This project analyzes SaaS customer, subscription, revenue, usage, and support data using **MySQL, SQL, Python, and Power BI**.

The project follows an end-to-end data analytics workflow, starting with data generation and relational database design, followed by exploratory analysis, business-oriented SQL analysis, advanced SQL techniques, data validation, reusable SQL views and stored procedures, and an interactive Power BI dashboard.

The main objective is to transform raw SaaS data into meaningful analytical insights about **customers, subscriptions, revenue, plans, product usage, support performance, account managers, and revenue targets**.

## 🛠️ Tools & Technologies

| Category           | Technology         |
| ------------------ | ------------------ |
| 🗄️ Database      | MySQL              |
| 🔎 Query Language  | SQL                |
| 🐍 Programming     | Python (Pandas)    |
| 📊 Visualization   | Power BI           |
| 🔧 Version Control | Git                |
| 🐙 Repository      | GitHub             |
| 💻 Development     | Visual Studio Code |

## 📂 Repository Structure

```text
FlowStack-SaaS-Analytics/
│
├── 📁 data/
│   ├── account_managers.csv
│   ├── customers.csv
│   ├── plans.csv
│   ├── subscriptions.csv
│   ├── invoices.csv
│   ├── support_tickets.csv
│   ├── usage_logs.csv
│   └── monthly_targets.csv
│
├── 📁 docs/
│   ├── data_dictionary.md
│   └── project_journey.md
│
├── 📁 images/
│   ├── dashboard_preview.png
│   ├── er_diagram.png
│   └── schema.png
│
├── 📁 powerbi/
│   └── FlowStack_SaaS_Analytics.pbix
│
├── 📁 python/
│   └── 07_generate_flowstack_data.py
│
├── 📁 sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_import.sql
│   ├── 03_exploratory_analysis.sql
│   ├── 04_business_questions.sql
│   ├── 05_advanced_sql.sql
│   ├── 06_views.sql
│   ├── 07_validation.sql
│   └── 08_stored_procedures.sql
│
├── 📄 README.md
├── 📄 LICENSE
├── 📄 .gitignore
└── 📄 .gitattributes
```

## 🔄 Project Workflow

The project follows a complete end-to-end data analytics workflow:

```text
📋 Business Requirements
        ↓
🐍 Python Data Generation
        ↓
📄 CSV Data
        ↓
🗄️ MySQL Database
        ↓
🔎 Exploratory Analysis
        ↓
📊 Business Analysis
        ↓
⚡ Advanced SQL
        ↓
👁️ Views & Stored Procedures
        ↓
✅ Data Validation
        ↓
📈 Power BI Dashboard
        ↓
💡 Business Insights
```

## 📊 Section 7 — Key Performance Indicators

The project focuses on key SaaS metrics used to measure business performance:

- 💰 Monthly Recurring Revenue (MRR)
- 📈 Annual Recurring Revenue (ARR)
- 👤 Customer Lifetime Value (CLV)
- 📉 Customer Churn Rate
- 👥 Customer Growth
- 💵 Average Revenue Per Customer
- 🔄 Active Subscriptions
- 🌍 Region-wise Revenue
- 👨‍💼 Account Manager Performance
- 📊 Product Usage
- 🎧 Support Performance
- 🎯 Revenue Target Achievement

## 🧠 Section 8 — SQL Analysis & Skills

The project demonstrates SQL skills across different levels of analysis.

### 🗄️ Database & Fundamentals

- Database and table creation
- Primary & Foreign Keys
- Constraints
- SELECT, WHERE, GROUP BY, HAVING
- Aggregate Functions

### 🔗 Intermediate SQL

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- CROSS JOIN
- CASE Statements
- Subqueries

### ⚡ Advanced SQL

- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG() & LEAD()
- Running Totals
- Moving Averages
- SQL Views
- Stored Procedures

### ✅ Data Validation

- NULL Checks
- Duplicate Checks
- Referential Integrity
- Business Rule Validation
- Date Validation

## 📋 Section 9 — Business Questions Solved

The project uses SQL to answer real-world SaaS business questions across key areas:

### 👥 Customer Analytics

- Top customers by revenue
- Customer acquisition trends
- Customer churn analysis
- Customer lifetime value

### 💰 Revenue & Subscription Analytics

- Monthly revenue trends
- Revenue by subscription plan
- Revenue by region
- Subscription performance
- Revenue vs. monthly targets

### 📊 Product Usage

- Usage trends over time
- Usage by plan and region
- Top customers by usage
- API request analysis

### 🎧 Support Analytics

- Tickets by category, priority, and status
- Average resolution time
- Support performance analysis

### 👨‍💼 Account Manager Performance

- Manager-wise revenue performance
- Customer performance by account manager

## 📈 Section 10 — Power BI Dashboard

The project includes a **5-page interactive Power BI dashboard** covering the key areas of SaaS business performance.

### 🏠 Executive Overview

Overall business performance, revenue, customers, subscriptions, and target achievement.

### 💰 Revenue & Subscriptions

Revenue trends, plan performance, regional revenue, and subscription analysis.

### 👥 Customer Analytics

Customer distribution, acquisition trends, industries, and top customers by revenue.

### 📊 Product Usage

Usage trends, API requests, plan and regional usage, and top customers by usage.

### 🎧 Support Performance

Ticket trends, categories, priorities, statuses, and resolution performance.

### 🖼️ Dashboard Preview

![Power BI Dashboard Preview](images/dashboard_preview.png)

**Power BI Report:** `powerbi/FlowStack_SaaS_Analytics.pbix`

## 🐍 Section 11 — Python Data Generation

Python and Pandas are used to generate the datasets required for the project.

The script generates data for:

- 👨‍💼 Account Managers
- 👥 Customers
- 📦 Plans
- 🔄 Subscriptions
- 💰 Invoices
- 🎧 Support Tickets
- 📊 Usage Logs
- 🎯 Monthly Targets

```bash
python python/07_generate_flowstack_data.py
```

## 🚀 Section 12 — How to Run the Project

### 1. 📥 Clone the Repository

```bash
git clone https://github.com/SantiSomaSekhar/FlowStack-SaaS-Analytics.git
```

### 2. 🐍 Generate the Data

```bash
python python/07_generate_flowstack_data.py
```

### 3. 🗄️ Run the SQL Scripts

Execute the SQL files in this order:

```text
01_database_setup.sql
02_data_import.sql
03_exploratory_analysis.sql
04_business_questions.sql
05_advanced_sql.sql
06_views.sql
07_validation.sql
08_stored_procedures.sql
```

### 4. 📊 Open Power BI

Open:

`powerbi/FlowStack_SaaS_Analytics.pbix`

Refresh the data source if required.

## 💡 Key Skills Demonstrated

- 🗄️ MySQL & SQL
- 🔎 Exploratory & Business Analysis
- ⚡ Advanced SQL & Window Functions
- ✅ Data Validation
- 👁️ SQL Views & Stored Procedures
- 🐍 Python & Pandas
- 📊 Power BI & Data Visualization
- 🔧 Git & GitHub

## 📚 Documentation

- 📖 **Data Dictionary** — Tables, columns, data types, keys, and relationships.
- 📝 **Project Journey** — Complete project workflow, development stages, and key learnings.

## 👨‍💻 Author

**Santennagari Soma Sekhar**

🔗 [GitHub](https://github.com/SantiSomaSekhar)

## 📄 License

This project is licensed under the **MIT License**.

---

<div align="center">
