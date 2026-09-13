-- ====================================================================
-- Chapter 6 Practice: Comparison Operators
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Find all jobs paying above $200,000 annually
SELECT
    job_id,
    job_title,
    employer_name,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg > 200000
ORDER BY salary_year_avg DESC;

-- Problem 2: Find jobs with salary below $80,000
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg < 80000
ORDER BY salary_year_avg ASC;

-- Problem 3: Find jobs where location is exactly 'Remote'
SELECT
    job_id,
    job_title,
    job_location
FROM job_postings_fact
WHERE job_location = 'Remote';

-- Problem 4: Jobs with hourly pay greater than or equal to $100
SELECT
    job_id,
    job_title,
    salary_hour_avg
FROM job_postings_fact
WHERE salary_hour_avg >= 100
ORDER BY salary_hour_avg DESC;

-- Problem 5: Jobs not in the United States
SELECT
    job_id,
    job_title,
    job_location
FROM job_postings_fact
WHERE job_location <> 'United States';

-- Problem 6: Combined filter pipeline for high-value remote jobs
SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE job_location = 'Remote'
  AND salary_year_avg >= 150000
ORDER BY salary_year_avg DESC;
