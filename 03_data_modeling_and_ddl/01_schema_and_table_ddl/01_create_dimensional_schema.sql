-- ====================================================================
-- Chapter 13 Practice: Schema and Table DDL
-- Purpose: Create a star-schema style warehouse foundation
-- ====================================================================

CREATE TABLE IF NOT EXISTS dim_role (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR,
    role_family VARCHAR
);

CREATE TABLE IF NOT EXISTS dim_employer (
    employer_id INTEGER PRIMARY KEY,
    employer_name VARCHAR,
    employer_sector VARCHAR
);

CREATE TABLE IF NOT EXISTS dim_location (
    location_id INTEGER PRIMARY KEY,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    is_remote BOOLEAN
);

CREATE TABLE IF NOT EXISTS fact_job_postings (
    job_id INTEGER PRIMARY KEY,
    role_id INTEGER,
    employer_id INTEGER,
    location_id INTEGER,
    salary_year_avg DECIMAL(18,2),
    salary_hour_avg DECIMAL(18,2),
    job_schedule_type VARCHAR,
    employment_type VARCHAR,
    posting_date DATE,
    FOREIGN KEY (role_id) REFERENCES dim_role(role_id),
    FOREIGN KEY (employer_id) REFERENCES dim_employer(employer_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id)
);

-- Optional example insert pattern
-- INSERT INTO dim_role (role_id, role_name, role_family)
-- VALUES (1, 'Data Engineer', 'Data');
