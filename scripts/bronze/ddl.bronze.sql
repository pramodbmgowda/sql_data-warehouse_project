/*
===============================================================================
Stored Procedure: Load Bronze Layer
===============================================================================
Script Purpose:
    This stored procedure loads raw CRM and ERP data from CSV files
    into the Bronze layer tables.

Workflow:
    1. Record the procedure start time.
    2. Truncate each Bronze table.
    3. Load data from staged CSV files using COPY INTO.
    4. Calculate execution time for each table.
    5. Calculate the total execution time.
    6. Return a summary of the load process.

Source Files:
    - cust_info.csv
    - prd_info.csv
    - sales_details.csv
    - CUST_AZ12.csv
    - LOC_A101.csv
    - PX_CAT_G1V2.csv

Target Schema:
    bronze


===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
RETURNS STRING
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
DECLARE
    start_time TIMESTAMP_NTZ;
    end_time TIMESTAMP_NTZ;
    total_time NUMBER;

    crm_cust_start_time TIMESTAMP_NTZ;
    crm_cust_end_time TIMESTAMP_NTZ;
    crm_cust_duration NUMBER;

    crm_prd_start_time TIMESTAMP_NTZ;
    crm_prd_end_time TIMESTAMP_NTZ;
    crm_prd_duration NUMBER;

    crm_sales_start_time TIMESTAMP_NTZ;
    crm_sales_end_time TIMESTAMP_NTZ;
    crm_sales_duration NUMBER;

    erp_cust_start_time TIMESTAMP_NTZ;
    erp_cust_end_time TIMESTAMP_NTZ;
    erp_cust_duration NUMBER;

    erp_loc_start_time TIMESTAMP_NTZ;
    erp_loc_end_time TIMESTAMP_NTZ;
    erp_loc_duration NUMBER;

    erp_px_start_time TIMESTAMP_NTZ;
    erp_px_end_time TIMESTAMP_NTZ;
    erp_px_duration NUMBER;

BEGIN
    start_time := CURRENT_TIMESTAMP();
    ----------------------------------------------------------
    -- CRM CUSTOMER
    ----------------------------------------------------------

    crm_cust_start_time := CURRENT_TIMESTAMP();

    TRUNCATE TABLE bronze.crm_cust_info;

    EXECUTE IMMEDIATE '
        COPY INTO bronze.crm_cust_info
        FROM @bronze_stage/cust_info.csv
        FILE_FORMAT=(FORMAT_NAME=csv_format)
        FORCE=TRUE
    ';

    crm_cust_end_time := CURRENT_TIMESTAMP();

    crm_cust_duration := DATEDIFF(
        'second',
        crm_cust_start_time,
        crm_cust_end_time
    );


    ----------------------------------------------------------
    -- CRM PRODUCT
    ----------------------------------------------------------

    crm_prd_start_time := CURRENT_TIMESTAMP()::TIMESTAMP_NTZ;

    TRUNCATE TABLE bronze.crm_prd_info;

    EXECUTE IMMEDIATE '
        COPY INTO bronze.crm_prd_info
        FROM @bronze_stage/prd_info.csv
        FILE_FORMAT=(FORMAT_NAME=csv_format)
        FORCE=TRUE
    ';

    crm_prd_end_time := CURRENT_TIMESTAMP()::TIMESTAMP_NTZ;

    crm_prd_duration := DATEDIFF(
        'second',
        crm_prd_start_time,
        crm_prd_end_time
    );


    ----------------------------------------------------------
    -- CRM SALES
    ----------------------------------------------------------

    crm_sales_start_time := CURRENT_TIMESTAMP();

    TRUNCATE TABLE bronze.crm_sales_details;

    EXECUTE IMMEDIATE '
        COPY INTO bronze.crm_sales_details
        FROM @bronze_stage/sales_details.csv
        FILE_FORMAT=(FORMAT_NAME=csv_format)
        FORCE=TRUE
    ';

    crm_sales_end_time := CURRENT_TIMESTAMP();

    crm_sales_duration := DATEDIFF(
        'second',
        crm_sales_start_time,
        crm_sales_end_time
    );


    ----------------------------------------------------------
    -- ERP CUSTOMER
    ----------------------------------------------------------

    erp_cust_start_time := CURRENT_TIMESTAMP();

    TRUNCATE TABLE bronze.erp_cust_az12;

    EXECUTE IMMEDIATE '
        COPY INTO bronze.erp_cust_az12
        FROM @bronze_stage/CUST_AZ12.csv
        FILE_FORMAT=(FORMAT_NAME=csv_format)
        FORCE=TRUE
    ';

    erp_cust_end_time := CURRENT_TIMESTAMP();

    erp_cust_duration := DATEDIFF(
        'second',
        erp_cust_start_time,
        erp_cust_end_time
    );


    ----------------------------------------------------------
    -- ERP LOCATION
    ----------------------------------------------------------

    erp_loc_start_time := CURRENT_TIMESTAMP();

    TRUNCATE TABLE bronze.erp_loc_a101;

    EXECUTE IMMEDIATE '
        COPY INTO bronze.erp_loc_a101
        FROM @bronze_stage/LOC_A101.csv
        FILE_FORMAT=(FORMAT_NAME=csv_format)
        FORCE=TRUE
    ';

    erp_loc_end_time := CURRENT_TIMESTAMP();

    erp_loc_duration := DATEDIFF(
        'second',
        erp_loc_start_time,
        erp_loc_end_time
    );


    ----------------------------------------------------------
    -- ERP PRODUCT CATEGORY
    ----------------------------------------------------------

    erp_px_start_time := CURRENT_TIMESTAMP();

    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    EXECUTE IMMEDIATE '
        COPY INTO bronze.erp_px_cat_g1v2
        FROM @bronze_stage/PX_CAT_G1V2.csv
        FILE_FORMAT=(FORMAT_NAME=csv_format)
        FORCE=TRUE
    ';

    erp_px_end_time := CURRENT_TIMESTAMP();

    erp_px_duration := DATEDIFF(
        'second',
        erp_px_start_time,
        erp_px_end_time
    );

    end_time := CURRENT_TIMESTAMP();

    total_time := DATEDIFF('second',start_time,end_time);


    RETURN
'Bronze Layer Loaded Successfully

CRM Customer : ' || crm_cust_duration || ' sec
CRM Product  : ' || crm_prd_duration || ' sec
CRM Sales    : ' || crm_sales_duration || ' sec
ERP Customer : ' || erp_cust_duration || ' sec
ERP Location : ' || erp_loc_duration || ' sec
ERP Category : ' || erp_px_duration || ' sec
TOTAL TIME   : ' || total_time ||' sec';

EXCEPTION
    WHEN OTHER THEN
        RETURN 'Error Code: ' || SQLCODE ||
               ' Error Message: ' || SQLERRM;

END;
$$;
