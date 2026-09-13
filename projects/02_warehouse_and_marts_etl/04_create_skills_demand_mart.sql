-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: 04_create_skills_demand_mart.sql
-- Purpose: Build a skills demand mart
-- ====================================================================

CREATE OR REPLACE VIEW analytics.skills_demand_mart AS
SELECT
    skill_name,
    COUNT(*) AS demand_count,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year
FROM job_skills
WHERE skill_name IS NOT NULL
GROUP BY skill_name
ORDER BY demand_count DESC;
