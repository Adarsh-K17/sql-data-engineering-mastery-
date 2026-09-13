-- ====================================================================
-- Chapter 6 Practice: Logical Filters
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: High-paying Data Engineer role in remote or hybrid settings
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
  AND salary_year_avg >= 180000
  AND (job_location = 'Remote' OR job_location = 'Hybrid');

-- Problem 2: Jobs in New York or San Francisco with valid salary data
SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE (job_location = 'New York' OR job_location = 'San Francisco')
  AND salary_year_avg IS NOT NULL;

-- Problem 3: Exclude internship and contractor roles
SELECT
    job_id,
    job_title,
    job_employment_type,
    salary_year_avg
FROM job_postings_fact
WHERE job_employment_type NOT IN ('Internship', 'Contract')
  AND salary_year_avg IS NOT NULL;

-- Problem 4: Filter only analyst and scientist roles with average pay above 120k
SELECT
    job_id,
    job_title_short,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short IN ('Data Analyst', 'Data Scientist')
  AND salary_year_avg > 120000
ORDER BY salary_year_avg DESC;

-- Problem 5: Show jobs with missing compensation data but valid job title
SELECT
    job_id,
    job_title,
    salary_year_avg,
    salary_hour_avg
FROM job_postings_fact
WHERE salary_year_avg IS NULL
  OR salary_hour_avg IS NULL
ORDER BY job_title;

-- Problem 6: Combine several logical conditions for a focused filtering pipeline
SELECT
    job_id,
    job_title,
    employer_name,
    job_location,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short IN ('Data Engineer', 'Data Analyst', 'Data Scientist')
  AND salary_year_avg IS NOT NULL
  AND job_schedule_type IN ('Full-time', 'Hybrid')
  AND job_location NOT IN ('United States');
