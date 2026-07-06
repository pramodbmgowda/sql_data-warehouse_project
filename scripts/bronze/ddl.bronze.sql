/*
=============================================================
Create Bronze Layer Tables
=============================================================
Script Purpose:
    This script creates all Bronze layer tables required
    for the Data Warehouse project.

    Tables Created:
        - crm_cust_info
        - crm_prd_info
        - crm_sales_details
        - erp_loc_a101
        - erp_cust_az12
        - erp_px_cat_g1v2

Schema:
    bronze
=============================================================
*/

-- ==========================================================
-- CRM Customer Information
-- ==========================================================

CREATE OR REPLACE TABLE bronze.crm_cust_info (
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_material_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date DATE
);

-- ==========================================================
-- CRM Product Information
-- ==========================================================

CREATE OR REPLACE TABLE bronze.crm_prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt TIMESTAMP_NTZ,
    prd_end_dt TIMESTAMP_NTZ
);

-- ==========================================================
-- CRM Sales Details
-- ==========================================================

CREATE OR REPLACE TABLE bronze.crm_sales_details (
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- ==========================================================
-- ERP Location Information
-- ==========================================================

CREATE OR REPLACE TABLE bronze.erp_loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

-- ==========================================================
-- ERP Customer Information
-- ==========================================================

CREATE OR REPLACE TABLE bronze.erp_cust_az12 (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);

-- ==========================================================
-- ERP Product Category Information
-- ==========================================================

CREATE OR REPLACE TABLE bronze.erp_px_cat_g1v2 (
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50)
);

-- ==========================================================
-- Verify Tables
-- ==========================================================

SHOW TABLES IN SCHEMA bronze;DATAWAREHOUSE.BRONZE.CRM_CUST_INFO
