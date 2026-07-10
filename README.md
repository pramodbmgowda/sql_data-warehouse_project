# 🚀 Data Warehouse and Analytics Project using Snowflake

Welcome to the **Data Warehouse and Analytics Project** repository!

This project demonstrates the design and implementation of a modern cloud-based data warehouse using **Snowflake**. It follows the **Medallion Architecture (Bronze, Silver, and Gold)** to ingest, transform, and model ERP and CRM datasets into a business-ready analytical data model.

The project showcases industry best practices in **Data Engineering**, **ETL Development**, **Data Modeling**, and **SQL Analytics**.

---

# 🏗️ Data Architecture

The project follows the **Medallion Architecture**, consisting of three layers:

![Data Architecture](docs/ARCHITECTURE
.png)

### 🥉 Bronze Layer
- Stores raw ERP and CRM data.
- Loads CSV files into Snowflake.
- No transformations are applied.

### 🥈 Silver Layer
- Cleans and validates data.
- Removes duplicates.
- Standardizes formats.
- Performs business transformations.
- Improves overall data quality.

### 🥇 Gold Layer
- Creates business-ready analytical views.
- Implements a Star Schema.
- Contains Fact and Dimension Views.
- Optimized for dashboards and reporting.

---

# 📖 Project Overview

This project covers the complete lifecycle of building a cloud data warehouse.

### ✅ Data Architecture
Designing a scalable cloud data warehouse using Medallion Architecture.

### ✅ ETL Pipeline
Building ETL pipelines for loading CRM and ERP data into Snowflake.

### ✅ Data Cleaning
Handling missing values, duplicates, invalid records, and inconsistent formats.

### ✅ Data Modeling
Building analytical Fact and Dimension views using Star Schema.

### ✅ Analytics
Writing SQL queries to generate meaningful business insights.

---

# 🎯 Skills Demonstrated

- Snowflake
- SQL
- Data Warehousing
- ETL Development
- Data Engineering
- Data Modeling
- Star Schema Design
- Data Cleaning
- Data Transformation
- SQL Analytics
- Window Functions
- Views
- Business Intelligence

---

# 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| Snowflake | Cloud Data Warehouse |
| Snowsight | SQL Development & Query Execution |
| SQL | ETL, Data Transformation & Analytics |
| Git | Version Control |
| GitHub | Source Code Management |
| Draw.io | Data Architecture & Data Modeling |
| CSV Files | Source Data |

---

# 🚀 Project Requirements

## Objective

Develop a modern cloud data warehouse using **Snowflake** to consolidate ERP and CRM sales data into a single analytical platform.

## Specifications

- Import ERP and CRM datasets.
- Load raw CSV files into the Bronze layer.
- Clean and standardize data in the Silver layer.
- Build analytical views in the Gold layer.
- Design a Star Schema.
- Create business-ready datasets for reporting.
- Document the complete data model.

---

# 📊 Analytics & Reporting

The Gold Layer provides business-ready data for analytical reporting.

The project includes SQL analysis on:

- Customer Behavior
- Product Performance
- Sales Trends
- Revenue Analysis
- Customer Segmentation
- Business KPIs

---

# 📂 Repository Structure

```text
sql_data-warehouse_project/
│
├── datasets/
│   ├── source_crm/
│   ├── source_erp/
│   └── *.csv
│
├── docs/
│   ├── data_architecture.png
│   ├── architecture.drawio
│   ├── integration_model.drawio
│   ├── data_flow.drawio
│   ├── data_catalog.md
│   └── naming_conventions.md
│
├── scripts/
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   │
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   │
│   └── gold/
│       ├── ddl_gold.sql
│       └── analytics.sql
│
├── tests/
│   └── quality_checks.sql
│
├── README.md
├── LICENSE
└── .gitignore
```

---

# 🔄 Data Pipeline

```text
              CSV Files
                  │
                  ▼
          Bronze Layer
      (Raw Data Ingestion)
                  │
                  ▼
          Silver Layer
   (Cleaning & Transformation)
                  │
                  ▼
           Gold Layer
 (Fact & Dimension Views)
                  │
                  ▼
      Analytics & Reporting
```

---

# ⭐ Medallion Architecture

```
                +--------------------+
                |    Source Data     |
                | ERP & CRM (CSV)    |
                +---------+----------+
                          |
                          ▼
                +--------------------+
                |   Bronze Layer     |
                |   Raw Data Load    |
                +---------+----------+
                          |
                          ▼
                +--------------------+
                |   Silver Layer     |
                | Data Cleaning      |
                | Standardization    |
                | Validation         |
                +---------+----------+
                          |
                          ▼
                +--------------------+
                |    Gold Layer      |
                | Fact Views         |
                | Dimension Views    |
                +---------+----------+
                          |
                          ▼
                +--------------------+
                | Business Analytics |
                | Dashboards         |
                | SQL Reports        |
                +--------------------+
```

---

# 📚 Concepts Covered

- Snowflake
- Cloud Data Warehouse
- Medallion Architecture
- ETL Pipeline
- Data Engineering
- Data Cleaning
- Data Transformation
- Star Schema
- Fact Tables
- Dimension Tables
- SQL Window Functions
- Analytical SQL
- Views
- Data Quality
- Business Intelligence

---

# 👨‍💻 Author

**Pramod B M**

Computer Science Engineering Student


