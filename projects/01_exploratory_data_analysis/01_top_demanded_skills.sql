-- ====================================================================
-- Project: Exploratory Data Analysis
-- Exercise: Top Demanded Skills
-- Dataset: job_postings_fact / skills_dim (example schema)
-- ====================================================================

-- Identify the most common skills across job postings
SELECT
    s.skill_name,
    COUNT(*) AS job_postings,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary_year
FROM job_postings_fact AS j
LEFT JOIN skill_mapping AS s
    ON j.job_id = s.job_id
WHERE s.skill_name IS NOT NULL
GROUP BY s.skill_name
ORDER BY job_postings DESC, avg_salary_year DESC
LIMIT 20;

-- Optional version using a normalized skills table if present
SELECT
    skill_name,
    COUNT(*) AS demand_count
FROM job_skills
GROUP BY skill_name
ORDER BY demand_count DESC
LIMIT 20;
