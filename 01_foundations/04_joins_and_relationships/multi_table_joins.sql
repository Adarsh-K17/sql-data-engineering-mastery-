-- ====================================================================
-- Chapter 8 Practice: Multi-Table Joins
-- Datasets: job_postings_fact, employers_dim, locations_dim
-- ====================================================================

-- Problem 1: Join postings, employer, and location metadata
SELECT
    j.job_id,
    j.job_title,
    e.employer_name,
    l.location_name,
    j.salary_year_avg
FROM job_postings_fact AS j
INNER JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
INNER JOIN locations_dim AS l
    ON j.location_id = l.location_id
LIMIT 20;

-- Problem 2: Show remote and hybrid jobs with employer + location context
SELECT
    j.job_id,
    j.job_title,
    e.employer_name,
    l.location_name,
    j.job_location,
    j.salary_year_avg
FROM job_postings_fact AS j
INNER JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
INNER JOIN locations_dim AS l
    ON j.location_id = l.location_id
WHERE j.job_location IN ('Remote', 'Hybrid')
ORDER BY j.salary_year_avg DESC;

-- Problem 3: Show jobs and employer name for the top 10 salaries
SELECT
    j.job_id,
    j.job_title,
    e.employer_name,
    j.salary_year_avg
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
WHERE j.salary_year_avg IS NOT NULL
ORDER BY j.salary_year_avg DESC
LIMIT 10;

-- Problem 4: Join postings to locations and count jobs by city
SELECT
    l.location_name,
    COUNT(*) AS job_count
FROM job_postings_fact AS j
INNER JOIN locations_dim AS l
    ON j.location_id = l.location_id
GROUP BY l.location_name
ORDER BY job_count DESC;

-- Problem 5: Compare salary by employer and location
SELECT
    e.employer_name,
    l.location_name,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
LEFT JOIN locations_dim AS l
    ON j.location_id = l.location_id
WHERE j.salary_year_avg IS NOT NULL
GROUP BY e.employer_name, l.location_name
ORDER BY avg_salary_year DESC;

-- Problem 6: High-value combined metadata lookup
SELECT
    j.job_id,
    j.job_title_short,
    e.employer_name,
    l.location_name,
    j.job_schedule_type,
    j.salary_year_avg
FROM job_postings_fact AS j
LEFT JOIN employers_dim AS e
    ON j.employer_id = e.employer_id
LEFT JOIN locations_dim AS l
    ON j.location_id = l.location_id
WHERE j.salary_year_avg >= 180000
ORDER BY j.salary_year_avg DESC;
