-- ====================================================================
-- Chapter 10 Practice: Running Totals and Rolling Metrics
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Running total of jobs per role in salary order
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    SUM(salary_year_avg) OVER (
        ORDER BY salary_year_avg
    ) AS running_salary_total
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY salary_year_avg;

-- Problem 2: 3-row rolling average salary by role
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    AVG(salary_year_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY salary_year_avg
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_3
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_title_short, salary_year_avg;

-- Problem 3: Compare current salary to previous salary in same role
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    LAG(salary_year_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY salary_year_avg DESC
    ) AS previous_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_title_short, salary_year_avg DESC;

-- Problem 4: Leading salary in same category
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    LEAD(salary_year_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY salary_year_avg DESC
    ) AS next_salary
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_title_short, salary_year_avg DESC;
