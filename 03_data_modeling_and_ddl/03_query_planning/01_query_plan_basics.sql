-- ====================================================================
-- Chapter 15 Practice: Query Planning
-- Purpose: Build readable queries and reason about execution flow
-- ====================================================================

EXPLAIN
SELECT
    r.role_name,
    COUNT(*) AS total_jobs,
    ROUND(AVG(f.salary_year_avg), 2) AS avg_salary
FROM fact_job_postings AS f
INNER JOIN dim_role AS r
    ON f.role_id = r.role_id
WHERE f.salary_year_avg IS NOT NULL
GROUP BY r.role_name
ORDER BY avg_salary DESC;

-- Alternate scan-focused example
SELECT
    e.employer_name,
    COUNT(*) AS total_postings
FROM fact_job_postings AS f
LEFT JOIN dim_employer AS e
    ON f.employer_id = e.employer_id
GROUP BY e.employer_name
ORDER BY total_postings DESC;
