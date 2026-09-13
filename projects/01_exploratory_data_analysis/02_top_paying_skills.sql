-- ====================================================================
-- Project: Exploratory Data Analysis
-- Exercise: Top Paying Skills
-- Dataset: job_postings_fact / skills_dim
-- ====================================================================

-- Rank skills by average salary
SELECT
    s.skill_name,
    ROUND(AVG(j.salary_year_avg), 2) AS avg_salary_year,
    COUNT(*) AS role_count
FROM job_postings_fact AS j
LEFT JOIN skill_mapping AS s
    ON j.job_id = s.job_id
WHERE j.salary_year_avg IS NOT NULL
  AND s.skill_name IS NOT NULL
GROUP BY s.skill_name
ORDER BY avg_salary_year DESC, role_count DESC
LIMIT 20;

-- Alternative if a skills table already exists
SELECT
    skill_name,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_year,
    COUNT(*) AS posting_count
FROM job_skills
WHERE salary_year_avg IS NOT NULL
GROUP BY skill_name
ORDER BY avg_salary_year DESC
LIMIT 20;
