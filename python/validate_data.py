from __future__ import annotations

import csv
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"

FILES = {
    "learners.csv": ["learner_id", "first_name", "last_name", "email", "registration_date"],
    "courses.csv": ["course_id", "course_name", "list_price_ngn"],
    "cohorts.csv": ["cohort_id", "course_id", "cohort_name", "start_date", "end_date"],
    "enrolments.csv": ["enrolment_id", "learner_id", "cohort_id", "enrolment_date", "agreed_fee_ngn", "status"],
    "attendance.csv": ["attendance_id", "enrolment_id", "session_date", "attendance_status"],
    "payments.csv": ["payment_id", "enrolment_id", "payment_date", "amount_ngn", "payment_method"],
    "assessments.csv": ["assessment_id", "enrolment_id", "assessment_name", "assessment_date", "score_percent"],
}

def load_csv(filename: str, expected_columns: list[str]) -> list[dict[str, str]]:
    path = DATA / filename
    if not path.exists():
        raise FileNotFoundError(f"Missing file: {path}")
    with path.open("r", newline="", encoding="utf-8") as file:
        reader = csv.DictReader(file)
        if reader.fieldnames != expected_columns:
            raise ValueError(f"{filename}: expected columns {expected_columns}, got {reader.fieldnames}")
        rows = list(reader)
    if not rows:
        raise ValueError(f"{filename}: file contains no data rows")
    return rows

def unique_ids(rows: list[dict[str, str]], key: str, filename: str) -> set[str]:
    values = [row[key] for row in rows]
    if len(values) != len(set(values)):
        raise ValueError(f"{filename}: duplicate {key} values")
    return set(values)

def main() -> None:
    tables = {name: load_csv(name, columns) for name, columns in FILES.items()}
    ids = {
        "learners": unique_ids(tables["learners.csv"], "learner_id", "learners.csv"),
        "courses": unique_ids(tables["courses.csv"], "course_id", "courses.csv"),
        "cohorts": unique_ids(tables["cohorts.csv"], "cohort_id", "cohorts.csv"),
        "enrolments": unique_ids(tables["enrolments.csv"], "enrolment_id", "enrolments.csv"),
        "attendance": unique_ids(tables["attendance.csv"], "attendance_id", "attendance.csv"),
        "payments": unique_ids(tables["payments.csv"], "payment_id", "payments.csv"),
        "assessments": unique_ids(tables["assessments.csv"], "assessment_id", "assessments.csv"),
    }

    checks = [
        ("cohorts.csv", "course_id", ids["courses"]),
        ("enrolments.csv", "learner_id", ids["learners"]),
        ("enrolments.csv", "cohort_id", ids["cohorts"]),
        ("attendance.csv", "enrolment_id", ids["enrolments"]),
        ("payments.csv", "enrolment_id", ids["enrolments"]),
        ("assessments.csv", "enrolment_id", ids["enrolments"]),
    ]
    for filename, column, valid_ids in checks:
        invalid = sorted({row[column] for row in tables[filename]} - valid_ids)
        if invalid:
            raise ValueError(f"{filename}: invalid {column} references: {invalid}")

    print("PASS: all seven CSV files exist, have expected columns and contain rows.")
    print("PASS: primary-key values are unique.")
    print("PASS: all tested foreign-key references resolve.")
    print("Reminder: these checks do not replace business-rule, privacy or financial reconciliation.")

if __name__ == "__main__":
    main()
