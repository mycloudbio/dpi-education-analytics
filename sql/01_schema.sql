-- DPI Education Analytics: PostgreSQL starter schema
-- Sample data is fictional. Create a database before running this script.

CREATE TABLE learners (
    learner_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    registration_date DATE NOT NULL
);

CREATE TABLE courses (
    course_id VARCHAR(10) PRIMARY KEY,
    course_name VARCHAR(120) NOT NULL,
    list_price_ngn NUMERIC(12,2) NOT NULL CHECK (list_price_ngn >= 0)
);

CREATE TABLE cohorts (
    cohort_id VARCHAR(10) PRIMARY KEY,
    course_id VARCHAR(10) NOT NULL REFERENCES courses(course_id),
    cohort_name VARCHAR(120) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    CHECK (end_date >= start_date)
);

CREATE TABLE enrolments (
    enrolment_id VARCHAR(10) PRIMARY KEY,
    learner_id VARCHAR(10) NOT NULL REFERENCES learners(learner_id),
    cohort_id VARCHAR(10) NOT NULL REFERENCES cohorts(cohort_id),
    enrolment_date DATE NOT NULL,
    agreed_fee_ngn NUMERIC(12,2) NOT NULL CHECK (agreed_fee_ngn >= 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'completed', 'withdrawn')),
    UNIQUE (learner_id, cohort_id)
);

CREATE TABLE attendance (
    attendance_id VARCHAR(10) PRIMARY KEY,
    enrolment_id VARCHAR(10) NOT NULL REFERENCES enrolments(enrolment_id),
    session_date DATE NOT NULL,
    attendance_status VARCHAR(20) NOT NULL CHECK (attendance_status IN ('present', 'absent')),
    UNIQUE (enrolment_id, session_date)
);

CREATE TABLE payments (
    payment_id VARCHAR(10) PRIMARY KEY,
    enrolment_id VARCHAR(10) NOT NULL REFERENCES enrolments(enrolment_id),
    payment_date DATE NOT NULL,
    amount_ngn NUMERIC(12,2) NOT NULL CHECK (amount_ngn > 0),
    payment_method VARCHAR(30) NOT NULL
);

CREATE TABLE assessments (
    assessment_id VARCHAR(10) PRIMARY KEY,
    enrolment_id VARCHAR(10) NOT NULL REFERENCES enrolments(enrolment_id),
    assessment_name VARCHAR(120) NOT NULL,
    assessment_date DATE NOT NULL,
    score_percent NUMERIC(5,2) CHECK (score_percent BETWEEN 0 AND 100),
    UNIQUE (enrolment_id, assessment_name)
);