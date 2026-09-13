-- ====================================================================
-- Chapter 7 Practice: HAVING Clause Filters
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Roles with at least 100 job postings
SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM job_postings_fact
GROUP BY job_title_short
HAVING COUNT(*) >= 100
ORDER BY job_count DESC;

-- Problem 2: Roles with average salary above $150,000
SELECT
    job_title_short,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short
HAVING AVG(salary_year_avg) > 150000
ORDER BY avg_salary_year DESC;

-- Problem 3: Locations with at least 50 postings and average salary above $120k
SELECT
    job_location,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_location
HAVING COUNT(*) >= 50
   AND AVG(salary_year_avg) > 120000
ORDER BY avg_salary_year DESC;

-- Problem 4: Employment types with average hourly wage above $75
SELECT
    job_employment_type,
    ROUND(AVG(salary_hour_avg), 2) AS avg_salary_hour
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
GROUP BY job_employment_type
HAVING AVG(salary_hour_avg) > 75
ORDER BY avg_salary_hour DESC;

-- Problem 5: Find schedule types with more than 10,000 postings
SELECT
    job_schedule_type,
    COUNT(*) AS total_posts
FROM job_postings_fact
GROUP BY job_schedule_type
HAVING COUNT(*) > 10000
ORDER BY total_posts DESC;

-- Problem 6: High-demand high-paying role clusters
SELECT
    job_title_short,
    job_schedule_type,
    COUNT(*) AS job_count,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short, job_schedule_type
HAVING COUNT(*) >= 50
   AND AVG(salary_year_avg) > 130000
ORDER BY avg_salary_year DESC;
