-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: data_validation_checks.sql
-- Purpose: Validate rows, nulls, and key integrity
-- ====================================================================

SELECT 'fact_job_postings' AS table_name,
       COUNT(*) AS row_count,
       COUNT(DISTINCT job_id) AS distinct_keys,
       COUNT(*) - COUNT(DISTINCT job_id) AS duplicate_keys
FROM warehouse.fact_job_postings;

SELECT 'dim_role' AS table_name,
       COUNT(*) AS row_count,
       COUNT(DISTINCT role_id) AS distinct_keys,
       SUM(CASE WHEN role_name IS NULL THEN 1 ELSE 0 END) AS null_role_names
FROM warehouse.dim_role;

SELECT 'fact_job_postings' AS table_name,
       SUM(CASE WHEN salary_year_avg IS NULL THEN 1 ELSE 0 END) AS missing_salary_year_avg,
       SUM(CASE WHEN salary_hour_avg IS NULL THEN 1 ELSE 0 END) AS missing_salary_hour_avg
FROM warehouse.fact_job_postings;

SELECT
    role_name,
    AVG(salary_year_avg) AS avg_salary_year
FROM warehouse.fact_job_postings AS f
LEFT JOIN warehouse.dim_role AS r
    ON f.role_id = r.role_id
GROUP BY role_name
HAVING AVG(salary_year_avg) IS NULL
ORDER BY role_name;
