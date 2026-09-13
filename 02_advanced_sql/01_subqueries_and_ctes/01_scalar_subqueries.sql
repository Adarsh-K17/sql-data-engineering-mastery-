-- ====================================================================
-- Chapter 9 Practice: Scalar Subqueries
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Find jobs above the average annual salary
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg > (
    SELECT AVG(salary_year_avg)
    FROM job_postings_fact
)
ORDER BY salary_year_avg DESC;

-- Problem 2: Show the highest salary across all jobs
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE salary_year_avg = (
    SELECT MAX(salary_year_avg)
    FROM job_postings_fact
);

-- Problem 3: Jobs that pay above the role-specific average for Data Engineer
SELECT
    job_id,
    job_title,
    salary_year_avg
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
  AND salary_year_avg > (
      SELECT AVG(salary_year_avg)
      FROM job_postings_fact
      WHERE job_title_short = 'Data Engineer'
  )
ORDER BY salary_year_avg DESC;

-- Problem 4: Compare each job to the maximum salary in its location
SELECT
    j.job_id,
    j.job_title,
    j.job_location,
    j.salary_year_avg,
    (
        SELECT MAX(salary_year_avg)
        FROM job_postings_fact AS x
        WHERE x.job_location = j.job_location
    ) AS max_salary_in_location
FROM job_postings_fact AS j
WHERE j.salary_year_avg IS NOT NULL
ORDER BY j.job_location, j.salary_year_avg DESC;
