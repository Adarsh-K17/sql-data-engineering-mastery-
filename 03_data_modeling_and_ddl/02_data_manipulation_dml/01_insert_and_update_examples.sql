-- ====================================================================
-- Chapter 14 Practice: DML Examples
-- Purpose: Insert and update dimensional warehouse data
-- ====================================================================

INSERT INTO dim_role (role_id, role_name, role_family)
VALUES
    (1, 'Data Engineer', 'Data'),
    (2, 'Data Analyst', 'Analytics'),
    (3, 'Data Scientist', 'Data');

INSERT INTO dim_employer (employer_id, employer_name, employer_sector)
VALUES
    (1, 'Acme Corp', 'Technology'),
    (2, 'Northwind Labs', 'Consulting');

INSERT INTO dim_location (location_id, city, state, country, is_remote)
VALUES
    (1, 'New York', 'NY', 'USA', FALSE),
    (2, 'Remote', NULL, 'USA', TRUE);

INSERT INTO fact_job_postings (
    job_id, role_id, employer_id, location_id,
    salary_year_avg, salary_hour_avg, job_schedule_type, employment_type, posting_date
)
VALUES
    (101, 1, 1, 1, 210000.00, 101.00, 'Full-time', 'Full-time', '2026-01-15'),
    (102, 2, 2, 2, 145000.00, 69.71, 'Remote', 'Full-time', '2026-02-10');

UPDATE fact_job_postings
SET salary_year_avg = 220000.00
WHERE job_id = 101;

DELETE FROM fact_job_postings
WHERE job_id = 102 AND salary_year_avg IS NULL;
