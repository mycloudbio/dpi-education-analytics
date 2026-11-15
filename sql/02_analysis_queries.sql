-- DPI Education Analytics: management analysis queries
-- Run after loading the CSV sample data into the matching tables.

-- 1. Enrolments by course and cohort
SELECT c.course_name, co.cohort_name, COUNT(e.enrolment_id) AS enrolment_count
FROM enrolments e
JOIN cohorts co ON co.cohort_id = e.cohort_id
JOIN courses c ON c.course_id = co.course_id
GROUP BY c.course_name, co.cohort_name
ORDER BY c.course_name, co.cohort_name;

-- 2. Expected fees, collected payments and outstanding balance by enrolment
WITH payment_totals AS (
    SELECT enrolment_id, SUM(amount_ngn) AS collected_ngn
    FROM payments
    GROUP BY enrolment_id
)
SELECT e.enrolment_id, l.first_name || ' ' || l.last_name AS learner,
       e.agreed_fee_ngn AS expected_ngn,
       COALESCE(p.collected_ngn, 0) AS collected_ngn,
       e.agreed_fee_ngn - COALESCE(p.collected_ngn, 0) AS outstanding_ngn
FROM enrolments e
JOIN learners l ON l.learner_id = e.learner_id
LEFT JOIN payment_totals p ON p.enrolment_id = e.enrolment_id
ORDER BY e.enrolment_id;

-- 3. Attendance rate by cohort
SELECT co.cohort_name,
       COUNT(a.attendance_id) AS recorded_sessions,
       COUNT(*) FILTER (WHERE a.attendance_status = 'present') AS attended_sessions,
       ROUND(100.0 * COUNT(*) FILTER (WHERE a.attendance_status = 'present')
             / NULLIF(COUNT(a.attendance_id), 0), 1) AS attendance_rate_pct
FROM cohorts co
JOIN enrolments e ON e.cohort_id = co.cohort_id
LEFT JOIN attendance a ON a.enrolment_id = e.enrolment_id
GROUP BY co.cohort_name
ORDER BY co.cohort_name;

-- 4. Assessment performance by course
SELECT c.course_name, COUNT(a.assessment_id) AS assessed_learners,
       ROUND(AVG(a.score_percent), 1) AS average_score_pct
FROM assessments a
JOIN enrolments e ON e.enrolment_id = a.enrolment_id
JOIN cohorts co ON co.cohort_id = e.cohort_id
JOIN courses c ON c.course_id = co.course_id
GROUP BY c.course_name
ORDER BY c.course_name;

-- 5. Overall financial summary
SELECT SUM(e.agreed_fee_ngn) AS expected_fees_ngn,
       COALESCE(SUM(p.amount_ngn), 0) AS recorded_collections_ngn
FROM enrolments e
LEFT JOIN payments p ON p.enrolment_id = e.enrolment_id;