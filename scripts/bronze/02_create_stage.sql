/*
===============================================================================
Script: Create Internal Stage
===============================================================================
Purpose:
    Creates an internal Snowflake stage for storing source CSV files.
===============================================================================
*/

CREATE OR REPLACE STAGE bronze_stage
FILE_FORMAT = csv_format;
