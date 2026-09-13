-- ====================================================================
-- Chapter 5 Practice: DISTINCT and Role Exploration
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Count total rows in the table
SELECT COUNT(*) AS total_rows
FROM job_postings_fact;

-- Problem 2: Find all unique job titles in the dataset
SELECT DISTINCT
    job_title
FROM job_postings_fact
ORDER BY job_title;

-- Problem 3: Find all unique role categories or short titles
SELECT DISTINCT
    job_title_short
FROM job_postings_fact
ORDER BY job_title_short;

-- Problem 4: Count distinct employers
SELECT COUNT(DISTINCT employer_name) AS unique_employers
FROM job_postings_fact;

-- Problem 5: Find all unique job locations
SELECT DISTINCT
    job_location
FROM job_postings_fact
ORDER BY job_location;

-- Problem 6: Distinct employment types with counts
SELECT
    job_employment_type,
    COUNT(*) AS role_count
FROM job_postings_fact
GROUP BY job_employment_type
ORDER BY role_count DESC;
