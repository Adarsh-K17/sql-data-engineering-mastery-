-- ====================================================================
-- Chapter 8 Practice: LEFT JOIN vs INNER JOIN
-- Datasets: job_postings_fact, employers_dim
-- ====================================================================

-- Problem 1: Inner join matching job postings to employers
SELECT
    j.job_id,
    j.job_title,
    e.employer_name,
    j.salary_year_avg
FROM job_postings_fact AS j
INNER JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
LIMIT 20;

-- Problem 2: Left join to show all jobs even when employer metadata is missing
SELECT
    j.job_id,
    j.job_title,
    e.employer_name,
    j.salary_year_avg
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
LIMIT 20;

-- Problem 3: Count how many job postings have a matching employer
SELECT
    COUNT(*) AS matched_jobs
FROM job_postings_fact AS j
INNER JOIN employers_dim AS e
    ON j.employer_id = e.employer_id;

-- Problem 4: Count all jobs, including unmatched employer rows
SELECT
    COUNT(*) AS all_jobs,
    COUNT(e.employer_id) AS matched_employers
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id;

-- Problem 5: Find jobs with missing employer details
SELECT
    j.job_id,
    j.job_title,
    e.employer_name
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
WHERE e.employer_id IS NULL;

-- Problem 6: Pair job titles with employer names for high-paying roles
SELECT
    j.job_title,
    e.employer_name,
    j.salary_year_avg
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
WHERE j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 15;
