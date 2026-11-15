# DPI Education Analytics

Education Operations and Business Intelligence

A portfolio project modelling the operational data of a small professional-learning business. It demonstrates relational data modelling, data quality checks, SQL analysis and a path toward business intelligence.

## Business questions
- How many learners enrol in each course and cohort?
- What proportion of fees has been collected, and what balances remain?
- Which cohorts have the strongest attendance?
- How are learners performing in assessments?

## Project status
**Phase 1 — synthetic demonstration dataset.** DPI has not yet established a complete, centralised operational dataset for this analysis. All records in the data folder are fictional and generated for demonstration. They are not actual DPI learner, attendance, payment or performance records, and results must not be interpreted as actual business performance.

If approved operational data becomes available, it will be anonymised, minimised and validated before replacing the sample dataset.

## Technology
- PostgreSQL — relational schema and analytical queries
- CSV — portable sample source data
- Python — basic data validation
- Power BI — planned reporting layer

## Repository structure
- data/ — fictional CSV source tables
- sql/ — PostgreSQL schema and analysis queries
- python/ — data validation script
- documentation/ — project scope and data dictionary

## Getting started
1. Create a PostgreSQL database.
2. Run sql/01_schema.sql.
3. Import the CSV files from data/ into their matching tables.
4. Run sql/02_analysis_queries.sql.
5. Run python/validate_data.py from the repository root.

See documentation/project_scope.md and documentation/data_dictionary.md.

## Portfolio integrity
This is a learning and portfolio project. The model is a proposed analytical structure, not a claim that DPI currently operates a production data warehouse or automated reporting platform.