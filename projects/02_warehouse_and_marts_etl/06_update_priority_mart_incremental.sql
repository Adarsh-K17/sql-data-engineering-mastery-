-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: 06_update_priority_mart_incremental.sql
-- Purpose: Incrementally refresh the priority roles mart
-- ====================================================================

CREATE SCHEMA IF NOT EXISTS analytics;

CREATE TABLE IF NOT EXISTS warehouse.last_refresh_log (
    table_name VARCHAR,
    refreshed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO warehouse.last_refresh_log (table_name)
VALUES ('analytics.priority_roles_mart');

DELETE FROM analytics.priority_roles_mart
WHERE role_name IN (
    SELECT r.role_name
    FROM warehouse.fact_job_postings AS f
    INNER JOIN warehouse.dim_role AS r
        ON f.role_id = r.role_id
    WHERE f.posting_date >= CURRENT_DATE - INTERVAL 30 DAY
    GROUP BY r.role_name
);

INSERT INTO analytics.priority_roles_mart (
    role_name,
    total_jobs,
    avg_salary_year,
    max_salary_year
)
SELECT
    r.role_name,
    COUNT(*) AS total_jobs,
    ROUND(AVG(f.salary_year_avg), 2) AS avg_salary_year,
    MAX(f.salary_year_avg) AS max_salary_year
FROM warehouse.fact_job_postings AS f
INNER JOIN warehouse.dim_role AS r
    ON f.role_id = r.role_id
WHERE f.posting_date >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY r.role_name
HAVING COUNT(*) >= 25;
