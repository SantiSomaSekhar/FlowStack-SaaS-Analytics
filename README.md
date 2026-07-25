<div align="center">

# 🚀 FlowStack SaaS Analytics

### End-to-End SQL Analytics & Business Intelligence Project

*A complete Data Analytics project that simulates a real-world Software-as-a-Service (SaaS) business using SQL, Python, and Power BI.*

![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Python](https://img.shields.io/badge/Python-Pandas-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Git](https://img.shields.io/badge/Git-Version%20Control-F05032?style=for-the-badge&logo=git&logoColor=white)

</div>

---

# 📖 About The Project

FlowStack SaaS Analytics is an end-to-end Business Intelligence project that demonstrates how a Data Analyst transforms raw business data into actionable insights.

The project simulates a subscription-based SaaS company and follows the same workflow used in professional analytics teams—from data generation and database design to SQL analysis and interactive dashboards.

This repository showcases practical SQL skills, business analysis techniques, and dashboard development using real-world business scenarios.

---

# 🎯 Business Objective

The objective is to help business stakeholders answer critical questions such as:

- Which subscription plans generate the highest revenue?
- Which customers contribute the most to Monthly Recurring Revenue (MRR)?
- How is revenue changing month over month?
- Which customers are likely to churn?
- Which account managers perform the best?
- Which countries generate the highest revenue?
- How efficiently are customer support tickets being resolved?

---

# 🛠 Tech Stack

| Category | Technology |
|----------|------------|
| Database | MySQL |
| Query Language | SQL |
| Programming | Python (Pandas) |
| Visualization | Power BI |
| Version Control | Git |
| Repository Hosting | GitHub |
| Development Environment | Visual Studio Code |

---

# 📂 Repository Structure

```
FlowStack-SaaS-Analytics
│
├── data/
│   ├── account_managers.csv
│   ├── customers.csv
│   ├── invoices.csv
│   ├── monthly_targets.csv
│   ├── plans.csv
│   ├── subscriptions.csv
│   ├── support_tickets.csv
│   └── usage_logs.csv
│
├── docs/
│   ├── data_dictionary.md
│   └── project_journey.md
│
├── images/
│   ├── dashboard_preview.png
│   ├── er_diagram.png
│   └── schema.png
│
├── powerbi/
│
├── python/
│   └── 07_generate_flowstack_data.py
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_data_import.sql
│   ├── 03_exploratory_analysis.sql
│   ├── 04_business_questions.sql
│   ├── 05_advanced_sql.sql
│   ├── 06_views.sql
│   ├── 07_validation.sql
│   └── 08_stored_procedures.sql
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# 🔄 Project Workflow

```
Business Requirements
          │
          ▼
Python Data Generation
          │
          ▼
CSV Files
          │
          ▼
MySQL Database
          │
          ▼
Data Cleaning & Validation
          │
          ▼
Exploratory SQL Analysis
          │
          ▼
Business KPI Analysis
          │
          ▼
Views & Stored Procedures
          │
          ▼
Power BI Dashboard
          │
          ▼
Business Insights
```

---

# 🗄 Database Design

The project uses a relational database consisting of multiple interconnected tables.

### Core Tables

- Customers
- Subscription Plans
- Subscriptions
- Invoices
- Usage Logs
- Account Managers
- Monthly Targets
- Support Tickets

**Database ER Diagram**

```
images/er_diagram.png
```

---

# 📊 Key Performance Indicators

The analysis focuses on important SaaS business metrics including:

- Monthly Recurring Revenue (MRR)
- Annual Recurring Revenue (ARR)
- Customer Lifetime Value (CLV)
- Customer Churn Rate
- Customer Growth
- Revenue Growth
- Average Revenue Per User (ARPU)
- Active Customers
- Subscription Distribution
- Country-wise Revenue
- Account Manager Performance
- Support Ticket Performance

---

# 📈 SQL Skills Demonstrated

### Database Design

- Database Creation
- Table Design
- Primary Keys
- Foreign Keys
- Constraints

### SQL Fundamentals

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- LIMIT

### Intermediate SQL

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- CROSS JOIN
- CASE Statements
- Aggregate Functions
- Subqueries

### Advanced SQL

- Common Table Expressions (CTEs)
- Window Functions
- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- Views
- Stored Procedures

---

# 📋 Business Questions Solved

Examples of business problems addressed in this project:

- Top customers by revenue
- Monthly revenue trends
- Revenue by subscription plan
- Customer churn analysis
- Active customer tracking
- Country-wise revenue comparison
- Account manager performance evaluation
- Monthly customer acquisition
- Customer support performance
- Subscription plan profitability

---

# 📷 Dashboard Preview

```
images/dashboard_preview.png
```

*(Power BI dashboard screenshot will be displayed here.)*

---

# 🚀 Running the Project

## 1. Clone the Repository

```bash
git clone https://github.com/SantiSomaSekhar/FlowStack-SaaS-Analytics.git
```

---

## 2. Open MySQL

Execute the SQL scripts in the following order:

```
01_database_setup.sql

02_data_import.sql

03_exploratory_analysis.sql

04_business_questions.sql

05_advanced_sql.sql

06_views.sql

07_validation.sql

08_stored_procedures.sql
```

---

## 3. Generate Sample Data

```bash
python python/07_generate_flowstack_data.py
```

---

## 4. Open Power BI

Load the project files from the **powerbi/** directory and refresh the data source.

---

# 💡 Key Skills Demonstrated

- SQL Query Writing
- Database Design
- Business Intelligence
- Data Cleaning
- Exploratory Data Analysis
- Data Validation
- Dashboard Development
- Business KPI Analysis
- Git Version Control
- GitHub Project Management
- Python Automation
- Technical Documentation

---

# 📚 Learning Outcomes

This project demonstrates practical experience in:

- Designing relational databases
- Building scalable SQL queries
- Solving real business problems using SQL
- Creating reusable SQL Views
- Developing Stored Procedures
- Applying Window Functions
- Building interactive Power BI dashboards
- Managing analytics projects with Git and GitHub
- Maintaining professional project documentation

---

# 👨‍💻 Author

**Santennagari Soma Sekhar **

**GitHub**

https://github.com/SantiSomaSekhar

**LinkedIn**

*Add your LinkedIn profile URL here.*

---

# 📄 License

This project is licensed under the MIT License.

---

<div align="center">

### ⭐ If you found this project useful, consider giving it a star.

</div>
