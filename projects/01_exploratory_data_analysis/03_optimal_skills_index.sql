-- ====================================================================
-- Project: Exploratory Data Analysis
-- Exercise: Optimal Skills Index
-- Goal: Balance demand and pay to identify high-value skills
-- ====================================================================

WITH skill_metrics AS (
    SELECT
        s.skill_name,
        COUNT(*) AS demand_count,
        ROUND(AVG(j.salary_year_avg), 2) AS avg_salary_year
    FROM job_postings_fact AS j
    LEFT JOIN skill_mapping AS s
        ON j.job_id = s.job_id
    WHERE s.skill_name IS NOT NULL
      AND j.salary_year_avg IS NOT NULL
    GROUP BY s.skill_name
),
ranked_skills AS (
    SELECT
        skill_name,
        demand_count,
        avg_salary_year,
        RANK() OVER (ORDER BY demand_count DESC) AS demand_rank,
        RANK() OVER (ORDER BY avg_salary_year DESC) AS pay_rank
    FROM skill_metrics
)
SELECT
    skill_name,
    demand_count,
    avg_salary_year,
    demand_rank,
    pay_rank,
    (demand_rank + pay_rank) AS combined_score
FROM ranked_skills
ORDER BY combined_score ASC, avg_salary_year DESC
LIMIT 25;
