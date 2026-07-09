/*
=============================================================
Stored Procedure: Load Silver Layer
=============================================================
Procedure Purpose:
    This procedure loads data from the Bronze layer into the
    Silver layer by performing data cleansing, validation,
    standardization and business transformations.

    The procedure performs the following operations:

        • Truncates all Silver layer tables.
        • Cleans and standardizes CRM Customer data.
        • Cleans and standardizes CRM Product data.
        • Cleans and validates CRM Sales data.
        • Cleans and standardizes ERP Customer data.
        • Cleans and standardizes ERP Location data.
        • Loads ERP Product Category data.
        • Records execution time for each table load.
        • Returns a complete execution summary.

Source Schema:
    Bronze

Target Schema:
    Silver

Execution:
    CALL silver.load_silver();

=============================================================
*/


CREATE OR REPLACE PROCEDURE silver.load_silver()
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
-------------------------------------------------------------
-- Record Overall Procedure Start Time
-------------------------------------------------------------
 start_time := CURRENT_TIMESTAMP();

    
-------------------------------------------------------------
-- Load CRM Customer Information
-------------------------------------------------------------
-- Step 1 : Record Start Time
-- Step 2 : Truncate Silver Table
-- Step 3 : Remove Duplicate Customers
-- Step 4 : Trim Customer Names
-- Step 5 : Standardize Marital Status
-- Step 6 : Standardize Gender
-- Step 7 : Insert Clean Data
-- Step 8 : Record Load Duration
-------------------------------------------------------------    
crm_cust_start_time := CURRENT_TIMESTAMP();

TRUNCATE TABLE silver.crm_cust_info;

INSERT INTO silver.crm_cust_info(
cst_id,
cst_key,
cst_firstname,
cst_lastname,
cst_material_status,
cst_gndr,
cst_create_date
)

SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS  cst_firstname,
TRIM(cst_lastname) AS cst_lastname,
CASE WHEN UPPER(TRIM(cst_material_status)) = 'S' THEN 'Single'
     WHEN UPPER(TRIM(cst_material_status)) = 'M' THEN 'Married'
     ELSE 'N/A'
END cst_material_status,

CASE WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
     WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
     ELSE 'N/A'
END cst_gndr,  
cst_create_date

FROM(
SELECT *, 
ROW_NUMBER() OVER (PARTITION BY CST_ID ORDER BY CST_CREATE_DATE DESC) AS flag_last 
FROM bronze.crm_cust_info
WHERE cst_id IS NOT NULL
)t WHERE flag_last = 1;

crm_cust_end_time := CURRENT_TIMESTAMP();

    crm_cust_duration := DATEDIFF(

    'second',

    crm_cust_start_time,

    crm_cust_end_time

);


-------------------------------------------------------------
-- Load CRM Product Information
-------------------------------------------------------------
-- Step 1 : Record Start Time
-- Step 2 : Truncate Silver Table
-- Step 3 : Extract Product Category
-- Step 4 : Standardize Product Line
-- Step 5 : Replace Missing Product Cost
-- Step 6 : Calculate Product End Date
-- Step 7 : Insert Clean Data
-- Step 8 : Record Load Duration
-------------------------------------------------------------

crm_prd_start_time := CURRENT_TIMESTAMP()::TIMESTAMP_NTZ;

TRUNCATE TABLE silver.crm_prd_info;

INSERT INTO silver.crm_prd_info(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)
SELECT 
prd_id,
REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,
prd_nm,
IFNULL(prd_cost, 0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
     WHEN 'M' THEN 'Mountain'
     WHEN 'R' THEN 'Road'
     WHEN 'S' THEN 'Other Sales'
     WHEN 'T' THEN 'Touring'
     ELSE 'n/a'
END AS prd_line,  
CAST(prd_start_dt AS DATE),
CAST (DATEADD( day, -1, LEAD(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY PRD_START_DT)) AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info;

crm_prd_end_time := CURRENT_TIMESTAMP()::TIMESTAMP_NTZ;

    crm_prd_duration := DATEDIFF(
        'second',
        crm_prd_start_time,
        crm_prd_end_time
    );


-------------------------------------------------------------
-- Load CRM Sales Information
-------------------------------------------------------------
-- Step 1 : Record Start Time
-- Step 2 : Truncate Silver Table
-- Step 3 : Convert Integer Dates
-- Step 4 : Validate Sales Amount
-- Step 5 : Validate Product Price
-- Step 6 : Insert Clean Data
-- Step 7 : Record Load Duration
-------------------------------------------------------------

crm_sales_start_time := CURRENT_TIMESTAMP();

TRUNCATE TABLE silver.crm_sales_details;

INSERT INTO silver.crm_sales_details(
sls_ord_num,
sls_prd_key,
sls_cust_id,
sls_order_dt,
sls_ship_dt,
sls_due_dt,
sls_sales,
sls_quantity,
sls_price
)
SELECT 
sls_ord_num,
sls_prd_key,
sls_cust_id,
CASE WHEN sls_order_dt = 0 OR LENGTH(TO_VARCHAR(sls_order_dt)) <> 8 THEN NULL
     ELSE TO_DATE(TO_VARCHAR(sls_order_dt), 'YYYYMMDD')
END AS sls_order_dt,
CASE WHEN sls_ship_dt = 0 OR LENGTH(TO_VARCHAR(sls_ship_dt)) <> 8 THEN NULL
     ELSE TO_DATE(TO_VARCHAR(sls_ship_dt), 'YYYYMMDD')
END AS sls_ship_dt,
CASE WHEN sls_due_dt = 0 OR LENGTH(TO_VARCHAR(sls_due_dt)) <> 8 THEN NULL
     ELSE TO_DATE(TO_VARCHAR(sls_due_dt), 'YYYYMMDD')
END AS sls_due_dt,
CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
     THEN sls_quantity * ABS(sls_price)
     ELSE sls_sales
END AS sls_sales,     
 
 sls_quantity,
 
CASE WHEN sls_price IS NULL OR sls_price <= 0  
     THEN sls_sales / NULLIF(sls_quantity, 0)
     ELSE sls_price
END AS sls_price
FROM bronze.crm_sales_details;

 crm_sales_end_time := CURRENT_TIMESTAMP();

    crm_sales_duration := DATEDIFF(
        'second',
        crm_sales_start_time,
        crm_sales_end_time
    );

 

-------------------------------------------------------------
-- Load ERP Customer Information
-------------------------------------------------------------
-- Step 1 : Record Start Time
-- Step 2 : Truncate Silver Table
-- Step 3 : Remove NAS Prefix
-- Step 4 : Validate Birth Date
-- Step 5 : Standardize Gender
-- Step 6 : Insert Clean Data
-- Step 7 : Record Load Duration
-------------------------------------------------------------

erp_cust_start_time := CURRENT_TIMESTAMP();

TRUNCATE TABLE silver.erp_cust_az12;

INSERT INTO silver.erp_cust_az12(
cid,
bdate,
gen
)
SELECT 
CASE WHEN cid LIKE 'NAS%' THEN SUBSTR(cid, 4, LENGTH(cid))
     ELSE cid
END AS cid,

CASE WHEN bdate > CURRENT_DATE() THEN NULL
     ELSE bdate
END AS bdate,

CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
     ELSE  'n/a'
END AS gen     

FROM bronze.erp_cust_az12;

erp_cust_end_time := CURRENT_TIMESTAMP();

    erp_cust_duration := DATEDIFF(
        'second',
        erp_cust_start_time,
        erp_cust_end_time
    );




-------------------------------------------------------------
-- Load ERP Location Information
-------------------------------------------------------------
-- Step 1 : Record Start Time
-- Step 2 : Truncate Silver Table
-- Step 3 : Remove Hyphen From Customer ID
-- Step 4 : Standardize Country Names
-- Step 5 : Replace Missing Country Values
-- Step 6 : Insert Clean Data
-- Step 7 : Record Load Duration
-------------------------------------------------------------

erp_loc_start_time := CURRENT_TIMESTAMP();

TRUNCATE TABLE silver.erp_loc_a101;

INSERT INTO silver.erp_loc_a101(
cid,
cntry
)
SELECT 
REPLACE(cid, '-', '') AS cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
     WHEN TRIM(cntry) IN ('US', 'USA') THEN 'United States'
     WHEN TRIM(cntry) =  '' OR cntry IS NULL THEN 'n/a'
     ELSE  TRIM(cntry)
END AS cntry    
FROM bronze.erp_loc_a101;

erp_loc_end_time := CURRENT_TIMESTAMP();

    erp_loc_duration := DATEDIFF(
        'second',
        erp_loc_start_time,
        erp_loc_end_time
    );




-------------------------------------------------------------
-- Load ERP Product Category Information
-------------------------------------------------------------
-- Step 1 : Record Start Time
-- Step 2 : Truncate Silver Table
-- Step 3 : Load Product Category Data
-- Step 4 : Record Load Duration
-------------------------------------------------------------

erp_px_start_time := CURRENT_TIMESTAMP();

TRUNCATE TABLE silver.erp_px_cat_g1v2;

INSERT INTO silver.erp_px_cat_g1v2(
id,cat,subcat,maintenance
)
SELECT id, cat, subcat, maintenance FROM bronze.erp_px_cat_g1v2;

erp_px_end_time := CURRENT_TIMESTAMP();

    erp_px_duration := DATEDIFF(
        'second',
        erp_px_start_time,
        erp_px_end_time
    );

end_time := CURRENT_TIMESTAMP();

    -------------------------------------------------------------
-- Calculate Total Procedure Execution Time
-------------------------------------------------------------

total_time := DATEDIFF('second',start_time,end_time);

-------------------------------------------------------------
-- Return Procedure Execution Summary
-------------------------------------------------------------
RETURN
'Silver Layer Loaded Successfully

CRM Customer : ' || crm_cust_duration || ' sec
CRM Product  : ' || crm_prd_duration || ' sec
CRM Sales    : ' || crm_sales_duration || ' sec
ERP Customer : ' || erp_cust_duration || ' sec
ERP Location : ' || erp_loc_duration || ' sec
ERP Category : ' || erp_px_duration || ' sec
TOTAL TIME   : ' || total_time ||' sec';

-------------------------------------------------------------
-- Error Handling
-------------------------------------------------------------
EXCEPTION
    WHEN OTHER THEN
        RETURN 'Error Code: ' || SQLCODE ||
               ' Error Message: ' || SQLERRM;

END;
$$; 

