# Exploratory Data Analysis

This project analyzes job market data to answer practical questions about skills, salary, and role quality.

## Goals

- Identify the most in-demand skills across job postings
- Measure which skills pay the most
- Build a composite index combining demand and salary signals
- Support strategic hiring and career planning decisions

## Typical workflow

1. Load source job posting data into DuckDB or MotherDuck.
2. Join job postings with skill metadata.
3. Aggregate by skill, role, and location.
4. Rank opportunities using both market demand and compensation.

## Outputs

- Top demanded skills
- Top paying skills
- Optimal skills index
