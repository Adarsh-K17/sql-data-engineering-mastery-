-- ====================================================================
-- Chapter 7 Practice: GROUP BY and Aggregation
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Count jobs per role category
SELECT
    job_title_short,
    COUNT(*) AS total_jobs
FROM job_postings_fact
GROUP BY job_title_short
ORDER BY total_jobs DESC;

-- Problem 2: Average annual salary by role
SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
ORDER BY avg_salary_year DESC;

-- Problem 3: Average hourly salaries by employment type
SELECT
    job_employment_type,
    ROUND(AVG(salary_hour_avg), 2) AS avg_salary_hour
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
GROUP BY job_employment_type
ORDER BY avg_salary_hour DESC;

-- Problem 4: Count jobs by location
SELECT
    job_location,
    COUNT(*) AS jobs_by_location
FROM job_postings_fact
GROUP BY job_location
ORDER BY jobs_by_location DESC;

-- Problem 5: Maximum annual salary by schedule type
SELECT
    job_schedule_type,
    MAX(salary_year_avg) AS max_salary_year
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_schedule_type
ORDER BY max_salary_year DESC;

-- Problem 6: Role + schedule combined grouping
SELECT
    job_title_short,
    job_schedule_type,
    COUNT(*) AS role_count,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short, job_schedule_type
ORDER BY role_count DESC, avg_salary_year DESC;
