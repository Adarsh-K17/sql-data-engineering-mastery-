-- ====================================================================
-- Project: Warehouse and Marts ETL
-- Script: 01_create_warehouse_tables.sql
-- Purpose: Create the warehouse schema and core dimension/fact tables
-- ====================================================================

CREATE SCHEMA IF NOT EXISTS warehouse;

CREATE TABLE IF NOT EXISTS warehouse.dim_role (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR,
    role_family VARCHAR,
    role_short_name VARCHAR
);

CREATE TABLE IF NOT EXISTS warehouse.dim_employer (
    employer_id INTEGER PRIMARY KEY,
    employer_name VARCHAR,
    employer_sector VARCHAR
);

CREATE TABLE IF NOT EXISTS warehouse.dim_location (
    location_id INTEGER PRIMARY KEY,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    is_remote BOOLEAN
);

CREATE TABLE IF NOT EXISTS warehouse.fact_job_postings (
    job_id INTEGER PRIMARY KEY,
    role_id INTEGER,
    employer_id INTEGER,
    location_id INTEGER,
    job_title VARCHAR,
    salary_year_avg DECIMAL(18,2),
    salary_hour_avg DECIMAL(18,2),
    job_schedule_type VARCHAR,
    employment_type VARCHAR,
    posting_date DATE,
    FOREIGN KEY (role_id) REFERENCES warehouse.dim_role(role_id),
    FOREIGN KEY (employer_id) REFERENCES warehouse.dim_employer(employer_id),
    FOREIGN KEY (location_id) REFERENCES warehouse.dim_location(location_id)
);

CREATE TABLE IF NOT EXISTS warehouse.stg_job_postings (
    job_id INTEGER,
    role_name VARCHAR,
    employer_name VARCHAR,
    city VARCHAR,
    state VARCHAR,
    country VARCHAR,
    job_title VARCHAR,
    salary_year_avg DECIMAL(18,2),
    salary_hour_avg DECIMAL(18,2),
    job_schedule_type VARCHAR,
    employment_type VARCHAR,
    posting_date DATE
);
