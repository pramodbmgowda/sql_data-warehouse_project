/*
===============================================================================
Script: Create File Format
===============================================================================
Purpose:
    Creates the CSV file format used to load data into Snowflake.
===============================================================================
*/

CREATE OR REPLACE FILE FORMAT csv_format
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
