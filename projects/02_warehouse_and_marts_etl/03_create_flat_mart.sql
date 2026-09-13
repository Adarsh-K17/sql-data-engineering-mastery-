-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: 03_create_flat_mart.sql
-- Purpose: Create a reporting-friendly flattened fact table
-- ====================================================================

CREATE OR REPLACE VIEW analytics.flat_job_postings AS
SELECT
    f.job_id,
    r.role_name,
    r.role_family,
    e.employer_name,
    l.city,
    l.state,
    l.country,
    f.job_title,
    f.salary_year_avg,
    f.salary_hour_avg,
    f.job_schedule_type,
    f.employment_type,
    f.posting_date
FROM warehouse.fact_job_postings AS f
LEFT JOIN warehouse.dim_role AS r
    ON f.role_id = r.role_id
LEFT JOIN warehouse.dim_employer AS e
    ON f.employer_id = e.employer_id
LEFT JOIN warehouse.dim_location AS l
    ON f.location_id = l.location_id;
