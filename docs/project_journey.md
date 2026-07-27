# Project Journey

## Overview

FlowStack SaaS Analytics is an end-to-end Data Analytics project designed to simulate the operations of a Software-as-a-Service (SaaS) company. The objective of this project was to practice the complete workflow of a Data Analyst—from designing a database to generating business insights through SQL and Power BI.

Rather than analyzing an existing database, this project was built from the ground up. Every stage, including database design, data import, SQL analysis, and reporting, was developed to resemble a real-world analytics environment.

---

# Project Objectives

The main objectives of this project were to:

- Design a normalized relational database.
- Import structured business datasets into MySQL.
- Perform exploratory and business-focused SQL analysis.
- Apply advanced SQL concepts used in real analytics teams.
- Build reusable SQL views and stored procedures.
- Validate data quality before reporting.
- Develop interactive dashboards in Power BI.
- Present findings in a professional portfolio project.

---

# Project Workflow

The project was completed in multiple stages.

## Stage 1 — Database Design

The first step was designing the database structure.

Eight related tables were created to represent different parts of a SaaS business:

- Account Managers
- Customers
- Subscription Plans
- Subscriptions
- Invoices
- Support Tickets
- Usage Logs
- Monthly Targets

Primary keys, foreign keys, and indexes were added to maintain data integrity and improve query performance.

---

## Stage 2 — Data Import

CSV datasets were imported into MySQL using the `LOAD DATA LOCAL INFILE` command.

After importing the data, validation queries were executed to verify that every table contained the expected number of records.

---

## Stage 3 — Exploratory Data Analysis

Once the data was available, exploratory SQL queries were written to understand the dataset.

This included:

- Customer distribution
- Regional analysis
- Industry distribution
- Revenue overview
- Subscription status
- Support ticket analysis
- Product usage trends

These queries helped build familiarity with the data before moving to business analysis.

---

## Stage 4 — Business Analysis

Business-focused SQL queries were created to answer common SaaS reporting questions.

Examples include:

- Which customers generate the highest revenue?
- Which subscription plans are most popular?
- Which regions contribute the most revenue?
- How are customers distributed across industries?
- What are the most common support ticket categories?

This stage focused on converting raw data into meaningful business insights.

---

## Stage 5 — Advanced SQL

Advanced SQL techniques were implemented to improve analytical capabilities.

Topics covered include:

- Common Table Expressions (CTEs)
- Ranking Functions
- Window Functions
- Running Totals
- Moving Averages
- LAG() and LEAD()
- CASE Expressions
- Executive KPI Reporting

These techniques are commonly used in business intelligence and reporting environments.

---

## Stage 6 — SQL Views

Reusable SQL Views were created to simplify reporting.

Instead of repeatedly writing complex joins, views provide ready-to-use datasets for dashboards and future analysis.

---

## Stage 7 — Data Validation

Before reporting, validation queries were executed to ensure data quality.

Validation included:

- Record count verification
- NULL value checks
- Duplicate record detection
- Foreign key validation
- Business rule validation
- Date consistency checks

This helped confirm that the imported data was reliable.

---

## Stage 8 — Stored Procedures

Stored procedures were developed for common reporting tasks.

These procedures allow frequently used reports to be executed using simple procedure calls instead of rewriting SQL queries.

---

## Power BI Dashboard

The final stage of the project is the development of an interactive Power BI dashboard.

The dashboard presents key business metrics including:

- Revenue
- Customer Growth
- Subscription Performance
- Product Usage
- Support Metrics
- Executive KPIs

The dashboard is built using the SQL database created throughout this project.

---

# Challenges Faced

During the project several practical challenges were encountered, including:

- Designing relationships between multiple tables.
- Importing CSV files into MySQL.
- Managing foreign key dependencies.
- Writing complex analytical SQL queries.
- Organizing SQL scripts into a professional repository structure.
- Integrating SQL outputs with Power BI.

Solving these challenges provided hands-on experience with real data analytics workflows.

---

# Skills Applied

- MySQL
- SQL
- Window Functions
- Common Table Expressions (CTEs)
- Database Design
- Data Validation
- Stored Procedures
- SQL Views
- Power BI
- Git
- GitHub

---

# Key Learning Outcomes

This project strengthened my understanding of the complete analytics workflow.

Some of the key takeaways include:

- Designing relational databases from scratch.
- Writing business-oriented SQL queries.
- Applying advanced SQL functions to solve analytical problems.
- Validating data before reporting.
- Organizing projects using Git and GitHub.
- Preparing datasets for dashboard development.

---

# Conclusion

FlowStack SaaS Analytics represents a complete end-to-end Data Analytics project that combines database design, SQL development, data validation, and business reporting into a single workflow.

The project demonstrates practical SQL skills and provides a strong foundation for building interactive business intelligence dashboards using Power BI.
