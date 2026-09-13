-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: 05_create_priority_roles_mart.sql
-- Purpose: Create a priority roles summary mart
-- ====================================================================

CREATE SCHEMA IF NOT EXISTS analytics;

CREATE OR REPLACE TABLE analytics.priority_roles_mart (
    role_name VARCHAR PRIMARY KEY,
    total_jobs BIGINT,
    avg_salary_year DECIMAL(18,2),
    max_salary_year DECIMAL(18,2)
);

INSERT INTO analytics.priority_roles_mart (role_name, total_jobs, avg_salary_year, max_salary_year)
SELECT
    r.role_name,
    COUNT(*) AS total_jobs,
    ROUND(AVG(f.salary_year_avg), 2) AS avg_salary_year,
    MAX(f.salary_year_avg) AS max_salary_year
FROM warehouse.fact_job_postings AS f
LEFT JOIN warehouse.dim_role AS r
    ON f.role_id = r.role_id
WHERE f.salary_year_avg IS NOT NULL
GROUP BY r.role_name
HAVING COUNT(*) >= 25
ORDER BY avg_salary_year DESC;
