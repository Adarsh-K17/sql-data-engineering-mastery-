-- ====================================================================
-- Chapter 12 Practice: Set Operations
-- Dataset: job_postings_fact
-- ====================================================================

-- Problem 1: Roles present in both Data Engineer and Data Scientist sets
SELECT job_title_short
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'

UNION

SELECT job_title_short
FROM job_postings_fact
WHERE job_title_short = 'Data Scientist';

-- Problem 2: Jobs available in both remote and hybrid locations
SELECT job_id, job_title, job_location
FROM job_postings_fact
WHERE job_location = 'Remote'

INTERSECT

SELECT job_id, job_title, job_location
FROM job_postings_fact
WHERE job_location = 'Hybrid';

-- Problem 3: Roles appearing in one category but not the other
SELECT job_title_short
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'

EXCEPT

SELECT job_title_short
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst';

-- Problem 4: Combined set output for top candidate role families
SELECT job_title_short
FROM job_postings_fact
WHERE job_title_short IN ('Data Engineer', 'Data Analyst', 'Data Scientist')

UNION ALL

SELECT job_title_short
FROM job_postings_fact
WHERE job_title_short IN ('Machine Learning Engineer', 'Analytics Engineer');
