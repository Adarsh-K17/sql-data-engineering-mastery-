-- ====================================================================
-- Chapter 10 Practice: Window Functions
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Rank roles by salary within each role category
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    RANK() OVER (
        PARTITION BY job_title_short
        ORDER BY salary_year_avg DESC
    ) AS salary_rank
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_title_short, salary_rank, salary_year_avg DESC;

-- Problem 2: Show running total of jobs by title category
SELECT
    job_title_short,
    COUNT(*) AS role_count,
    SUM(COUNT(*)) OVER (
        ORDER BY job_title_short
    ) AS running_total
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY job_title_short;

-- Problem 3: Salary compared to the category average
SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    AVG(salary_year_avg) OVER (
        PARTITION BY job_title_short
    ) AS avg_salary_by_role
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_title_short, salary_year_avg DESC;

-- Problem 4: Percentile-style comparison using ROW_NUMBER
SELECT
    job_id,
    job_title,
    salary_year_avg,
    ROW_NUMBER() OVER (
        ORDER BY salary_year_avg DESC
    ) AS salary_row_number
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 20;
