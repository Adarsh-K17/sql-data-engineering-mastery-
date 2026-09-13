-- ====================================================================
-- Chapter 6 Practice: Pattern Matching with LIKE
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Find job titles that start with 'Data'
SELECT
    job_id,
    job_title,
    job_title_short
FROM job_postings_fact
WHERE job_title LIKE 'Data%';

-- Problem 2: Find job titles containing 'Engineer'
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE job_title LIKE '%Engineer%'
ORDER BY salary_year_avg DESC;

-- Problem 3: Find titles ending in 'Analyst'
SELECT
    job_id,
    job_title,
    job_location
FROM job_postings_fact
WHERE job_title LIKE '%Analyst';

-- Problem 4: Find roles with a single-word title pattern
SELECT
    job_id,
    job_title
FROM job_postings_fact
WHERE job_title NOT LIKE '% %';

-- Problem 5: Match job locations containing 'San'
SELECT
    job_id,
    job_title,
    job_location
FROM job_postings_fact
WHERE job_location LIKE '%San%';

-- Problem 6: Combined pipeline using LIKE and salary filter
SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE job_title LIKE '%Data%'
  AND salary_year_avg IS NOT NULL
  AND job_location LIKE '%Remote%'
ORDER BY salary_year_avg DESC;
