Data Warehouse and Analytics Project

Welcome to the Data Warehouse and Analytics Project repository! 🚀

This project demonstrates a complete end-to-end data warehousing solution using Snowflake. It covers the entire data engineering lifecycle—from ingesting raw data to building a business-ready analytical data model following the Medallion Architecture (Bronze, Silver, and Gold).

This repository serves as a portfolio project showcasing modern data engineering, ETL development, data modeling, and analytics best practices.

⸻

🏗️ Data Architecture

The project follows the Medallion Architecture, consisting of three layers:

🥉 Bronze Layer

* Stores raw data exactly as received from the source systems.
* Data is loaded from CSV files into Snowflake.
* No transformations are applied.

🥈 Silver Layer

* Cleanses and standardizes raw data.
* Removes duplicates.
* Resolves data quality issues.
* Performs data transformations and normalization.

🥇 Gold Layer

* Contains business-ready data.
* Implements a Star Schema with Fact and Dimension Views.
* Optimized for reporting, dashboards, and analytics.

⸻

📖 Project Overview

This project includes:

✅ Data Architecture

Designing a modern cloud data warehouse using the Medallion Architecture.

✅ ETL Pipelines

Building Extract, Transform, and Load (ETL) pipelines to ingest and process CRM and ERP datasets.

✅ Data Modeling

Creating Fact and Dimension models optimized for analytical workloads.

✅ Analytics & Reporting

Developing SQL queries to generate business insights from the warehouse.

⸻

🎯 Skills Demonstrated

* Snowflake
* SQL Development
* Data Warehousing
* ETL Pipeline Development
* Data Engineering
* Data Modeling
* Data Analytics
* Star Schema Design
* Data Cleaning & Transformation

⸻

🛠️ Tools & Technologies

Everything used in this project is free.

Tool	Purpose
Snowflake	Cloud Data Warehouse
Snowsight	Snowflake SQL Editor and Management Interface
Git & GitHub	Version Control
Draw.io	Data Architecture & Data Modeling
CSV Files	Source Data
SQL	ETL, Data Modeling & Analytics

⸻

🚀 Project Requirements

Building the Data Warehouse

Objective

Develop a modern cloud data warehouse using Snowflake to consolidate CRM and ERP sales data into a single analytical platform.

Specifications

* Import data from ERP and CRM source systems.
* Load CSV files into the Bronze layer.
* Clean and standardize data in the Silver layer.
* Build analytical dimension and fact views in the Gold layer.
* Focus only on the latest available data.
* Document the data model for analytics and reporting.

⸻

📊 Analytics & Reporting

Develop SQL analytics to provide insights into:

* Customer Behavior
* Product Performance
* Sales Trends
* Revenue Analysis
* Business KPIs

The Gold Layer provides a business-ready Star Schema for reporting and dashboards.

⸻


📂 Repository Structure

data-warehouse-project/
│
├── datasets/                     # Source CSV datasets
│
├── docs/
│   ├── data_architecture.png
│   ├── data_architecture.drawio
│   ├── data_flow.drawio
│   ├── data_models.drawio
│   ├── etl.drawio
│   ├── data_catalog.md
│   └── naming-conventions.md
│
├── scripts/
│   ├── bronze/
│   ├── silver/
│   └── gold/
│
├── tests/
│
├── README.md
├── LICENSE
└── .gitignore

⸻

📈 Project Workflow

CSV Files
      │
      ▼
 Bronze Layer
(Raw Data Loading)
      │
      ▼
 Silver Layer
(Data Cleaning &
Transformation)
      │
      ▼
 Gold Layer
(Fact & Dimension Views)
      │
      ▼
Analytics & Reporting

⸻

📚 Concepts Covered

* Medallion Architecture
* Snowflake Data Warehouse
* ETL Pipeline Design
* Data Cleaning
* Data Transformation
* Data Modeling
* Fact Tables
* Dimension Tables
* Star Schema
* SQL Window Functions
* Views
* Analytical SQL
* Data Quality Checks

⸻

📄 License

This project is licensed under the MIT License.

⸻

👨‍💻 Author

Pramod B M

Computer Science Engineering Student

Passionate about:

* Data Engineering
* Data Analytics
* Cloud Data Warehousing
* SQL Development
* Java Backend Development
* Machine Learning

⸻

⭐ If you found this project useful, consider giving the repository a Star on GitHub.
