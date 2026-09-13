# Warehouse and Marts ETL

This project builds a warehouse layer and curated marts from source job market data.

## Architecture

- Raw layer: source CSV files from cloud storage
- Staging layer: typed landing tables and validation checks
- Warehouse layer: dimension and fact tables for analytics
- Mart layer: curated business views for reporting and dashboards

## Workflow

1. Create warehouse tables.
2. Load raw files into staging tables.
3. Transform and clean data.
4. Build flat marts and aggregate role/skill summaries.
5. Validate the final warehouse state.

## Output marts

- Flat job posting mart
- Skills demand mart
- Priority roles mart
- Incremental refresh logic for updated data
