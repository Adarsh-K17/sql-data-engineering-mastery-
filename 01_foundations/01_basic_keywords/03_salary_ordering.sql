-- ====================================================================
-- Chapter 5 Practice: ORDER BY and Salary Ranking
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Show the highest average annual salary values first
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 20;

-- Problem 2: Show the lowest average annual salary values first
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY salary_year_avg ASC
LIMIT 20;

-- Problem 3: Rank hourly pay by descending value
SELECT
    job_id,
    job_title,
    salary_hour_avg
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC
LIMIT 20;

-- Problem 4: Order by job title alphabetically and salary descending
SELECT
    job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY job_title ASC, salary_year_avg DESC;

-- Problem 5: Top 10 Data Scientist salaries by year
SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short = 'Data Scientist'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

-- Problem 6: Top 10 Data Engineer salary rows, sorted by location then salary
SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
  AND salary_year_avg IS NOT NULL
ORDER BY job_location ASC, salary_year_avg DESC
LIMIT 10;
