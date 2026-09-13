-- ====================================================================
-- Chapter 5 Practice: Basic Keywords & Clause Order
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Retrieve job_id, job_title, and job_location (Limit 15)
SELECT 
    job_id,
    job_title,
    job_location
FROM 
    job_postings_fact
LIMIT 15;

-- Problem 2: Find all unique schedule types
SELECT DISTINCT
    job_schedule_type
FROM 
    job_postings_fact;

-- Problem 3: Exact filtering for Data Analyst (Limit 20)
SELECT 
    job_id,
    job_title_short,
    job_location
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
LIMIT 20;

-- Problem 4: Filter out null salary values (Limit 10)
SELECT 
    job_id,
    job_title_short,
    salary_year_avg
FROM 
    job_postings_fact
WHERE 
    salary_year_avg IS NOT NULL
LIMIT 10;

-- Problem 5: Top 5 highest paying hourly jobs
SELECT 
    job_id,
    job_title,
    salary_hour_avg
FROM 
    job_postings_fact
WHERE 
    salary_hour_avg IS NOT NULL
ORDER BY 
    salary_hour_avg DESC
LIMIT 5;

-- Problem 6: Combined Pipeline - Top 10 Data Engineer annual salaries
SELECT 
    job_id,
    job_title,
    job_location,
    salary_year_avg
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Engineer'
    AND salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
