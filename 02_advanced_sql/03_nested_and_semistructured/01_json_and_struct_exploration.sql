-- ====================================================================
-- Chapter 11 Practice: Semi-Structured and Nested Data
-- Dataset: job_postings_fact with JSON-like metadata
-- ====================================================================

-- Problem 1: Inspect the raw metadata column if present
SELECT
    job_id,
    job_title,
    metadata
FROM job_postings_fact
LIMIT 10;

-- Problem 2: Extract a nested string field using DuckDB JSON functions
SELECT
    job_id,
    job_title,
    json_extract_string(metadata, '$.job_type') AS job_type
FROM job_postings_fact
WHERE metadata IS NOT NULL
LIMIT 20;

-- Problem 3: Extract the location from nested metadata
SELECT
    job_id,
    job_title,
    json_extract_string(metadata, '$.location') AS nested_location
FROM job_postings_fact
WHERE metadata IS NOT NULL
LIMIT 20;

-- Problem 4: Filter rows where metadata includes a specific skill tag
SELECT
    job_id,
    job_title,
    metadata
FROM job_postings_fact
WHERE json_extract_string(metadata, '$.skills') LIKE '%SQL%'
LIMIT 20;
