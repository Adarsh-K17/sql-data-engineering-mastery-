-- ====================================================================
-- Chapter 9 Practice: Inline Views and CTEs
-- Dataset: job_postings_fact
-- ====================================================================

WITH high_salary_jobs AS (
    SELECT
        job_id,
        job_title,
        job_title_short,
        salary_year_avg
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
),
role_salary_summary AS (
    SELECT
        job_title_short,
        AVG(salary_year_avg) AS avg_salary_year
    FROM high_salary_jobs
    GROUP BY job_title_short
)
SELECT
    h.job_id,
    h.job_title,
    h.job_title_short,
    h.salary_year_avg,
    r.avg_salary_year
FROM high_salary_jobs AS h
INNER JOIN role_salary_summary AS r
    ON h.job_title_short = r.job_title_short
WHERE h.salary_year_avg > r.avg_salary_year
ORDER BY h.salary_year_avg DESC;

-- Alternative inline view approach
SELECT *
FROM (
    SELECT
        job_title_short,
        AVG(salary_year_avg) AS avg_salary_year
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY job_title_short
) AS role_summary
WHERE avg_salary_year > 150000;
