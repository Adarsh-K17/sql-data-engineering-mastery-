-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: 02_load_warehouse_from_cloud.sql
-- Purpose: Load raw cloud CSV files into staging and warehouse tables
-- ====================================================================

CREATE TABLE IF NOT EXISTS warehouse.stg_job_postings AS
SELECT *
FROM read_csv_auto(
    'data/raw/job_postings.csv',
    header = true,
    all_varchar = true
);

-- Load roles
INSERT INTO warehouse.dim_role (role_id, role_name, role_family, role_short_name)
SELECT
    ROW_NUMBER() OVER () AS role_id,
    role_name,
    CASE
        WHEN role_name LIKE '%Engineer%' THEN 'Engineering'
        WHEN role_name LIKE '%Analyst%' THEN 'Analytics'
        WHEN role_name LIKE '%Scientist%' THEN 'Science'
        ELSE 'Other'
    END AS role_family,
    role_name AS role_short_name
FROM (
    SELECT DISTINCT role_name
    FROM warehouse.stg_job_postings
) AS deduped_roles
ON CONFLICT (role_id) DO NOTHING;

-- Load employers
INSERT INTO warehouse.dim_employer (employer_id, employer_name, employer_sector)
SELECT
    ROW_NUMBER() OVER () AS employer_id,
    employer_name,
    'Unknown' AS employer_sector
FROM (
    SELECT DISTINCT employer_name
    FROM warehouse.stg_job_postings
    WHERE employer_name IS NOT NULL
) AS deduped_employers
ON CONFLICT (employer_id) DO NOTHING;

-- Load locations
INSERT INTO warehouse.dim_location (location_id, city, state, country, is_remote)
SELECT
    ROW_NUMBER() OVER () AS location_id,
    city,
    state,
    country,
    CASE WHEN city = 'Remote' THEN TRUE ELSE FALSE END AS is_remote
FROM (
    SELECT DISTINCT city, state, country
    FROM warehouse.stg_job_postings
) AS deduped_locations
ON CONFLICT (location_id) DO NOTHING;

-- Load warehouse fact table
INSERT INTO warehouse.fact_job_postings (
    job_id,
    role_id,
    employer_id,
    location_id,
    job_title,
    salary_year_avg,
    salary_hour_avg,
    job_schedule_type,
    employment_type,
    posting_date
)
SELECT
    s.job_id,
    r.role_id,
    e.employer_id,
    l.location_id,
    s.job_title,
    CAST(s.salary_year_avg AS DECIMAL(18,2)),
    CAST(s.salary_hour_avg AS DECIMAL(18,2)),
    s.job_schedule_type,
    s.employment_type,
    CAST(s.posting_date AS DATE)
FROM warehouse.stg_job_postings AS s
LEFT JOIN warehouse.dim_role AS r
    ON s.role_name = r.role_name
LEFT JOIN warehouse.dim_employer AS e
    ON s.employer_name = e.employer_name
LEFT JOIN warehouse.dim_location AS l
    ON COALESCE(s.city, 'Remote') = COALESCE(l.city, 'Remote')
ON CONFLICT (job_id) DO NOTHING;
