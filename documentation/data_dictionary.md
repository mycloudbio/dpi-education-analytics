# Data Dictionary

All records currently supplied in the data folder are fictional demonstration records.

| Table | Grain | Key fields | Purpose |
|---|---|---|---|
| learners | One row per learner | learner_id | Basic learner reference |
| courses | One row per course | course_id | Course catalogue and list price |
| cohorts | One row per cohort | cohort_id, course_id | Scheduled course group |
| enrolments | One row per learner-cohort enrolment | enrolment_id | Registration and agreed fee |
| attendance | One row per enrolment per session | attendance_id | Session attendance |
| payments | One row per payment transaction | payment_id | Fee collection |
| assessments | One row per enrolment assessment | assessment_id | Assessment result |

## Metric definitions
- Enrolments: count of enrolment records.
- Expected fees: sum of agreed fees on enrolments.
- Collected revenue: sum of recorded payment amounts. This is not necessarily cash reconciled to a bank statement.
- Outstanding balance: expected fee less payments recorded against the enrolment. Negative balances should be investigated.
- Attendance rate: attended sessions divided by recorded sessions, multiplied by 100. Cancelled sessions are not represented in this sample.
- Average assessment score: arithmetic mean of non-null assessment scores.

## Data handling
Do not commit real learner names, contact details, payment references or sensitive records to this public repository. Use anonymised or synthetic data and obtain appropriate authorisation before using operational data.