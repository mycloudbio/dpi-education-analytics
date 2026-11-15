# Project Scope

## Context
Data Path Integrated Limited (DPI) delivers professional learning programmes. This project designs a small analytical model to show how structured operational data could support decisions about enrolment, course delivery, attendance, payments and learner assessment.

## Problem statement
Operational information held in separate records is difficult to analyse consistently. A structured data model can provide a foundation for reliable reporting and better operational decisions.

## Objectives
1. Define a relational model for learners, courses, cohorts, enrolments, attendance, payments and assessments.
2. Validate source CSV files for basic structural and referential integrity.
3. Write SQL queries that answer practical management questions.
4. Prepare the model for a future dashboard.

## Scope
Included: data modelling, synthetic sample data, validation, SQL analysis and documentation.

Excluded from this phase: live integrations, production deployment, automated ETL, personally identifiable learner data, and claims about real DPI performance.

## Data and assumptions
All current records are fictional demonstration data. Course prices in the sample reflect illustrative programme prices: Data Analytics ₦150,000 and Generative AI ₦80,000. The small sample is intended to test the model, not support statistically meaningful conclusions.

## Future phases
- Replace synthetic records only with authorised, anonymised and quality-checked operational data.
- Build repeatable ingestion and transformation workflows.
- Develop a Power BI dashboard with clearly defined metrics.
- Add refresh, access-control and documentation practices.

## Success criteria
- Tables have clear primary and foreign keys.
- Sample data passes validation.
- SQL outputs reconcile to the source records.
- Metrics have documented definitions and limitations.