CREATE TABLE subjects (
    subject_id VARCHAR(5) PRIMARY KEY,
    subject_name VARCHAR(50),
    fee INT,
    max_seats INT
);
INSERT INTO subjects
(subject_id, subject_name, fee, max_seats)
VALUES
('S01', 'SQL Fundamentals', 4000, 30),
('S02', 'Python Programming', 5000, 30),
('S03', 'Data Visualization', 3500, 20),
('S04', 'Statistics', 3000, 25),
('S05', 'Cloud Basics', 4500, 20),
('S06', 'Machine Learning', 6000, 15);

SELECT *
FROM subjects;

CREATE TABLE enrollments (
    enrollment_id VARCHAR(5) PRIMARY KEY,
    student_id INT,
    subject_id VARCHAR(5),
    enroll_date DATE
);

INSERT INTO enrollments
(enrollment_id, student_id, subject_id, enroll_date)
VALUES
('E01', 101, 'S01', '2026-01-06'),
('E02', 101, 'S02', '2026-01-06'),
('E03', 102, 'S01', '2026-01-11'),
('E04', 103, 'S02', '2026-01-19'),
('E05', 103, 'S03', '2026-02-01'),
('E06', 104, 'S01', '2026-02-04'),
('E07', 105, 'S02', '2026-02-15'),
('E08', 105, 'S04', '2026-02-15'),
('E09', 107, 'S01', '2026-03-02'),
('E10', 107, 'S02', '2026-03-02'),
('E11', 108, 'S03', '2026-03-06'),
('E12', 109, 'S01', '2026-03-12'),
('E13', 110, 'S05', '2026-03-21'),
('E14', 112, 'S02', '2026-03-25');

SELECT *
FROM enrollments;

IF OBJECT_ID('subject_demand', 'U') IS NOT NULL
    DROP TABLE subject_demand;

SELECT
    s.subject_id,
    s.subject_name,

    COUNT(e.enrollment_id) AS enrolled_students,

    s.max_seats - COUNT(e.enrollment_id) AS seats_left,

    CASE
        WHEN COUNT(e.enrollment_id) >= 4
            THEN 'High'

        WHEN COUNT(e.enrollment_id) BETWEEN 2 AND 3
            THEN 'Medium'

        WHEN COUNT(e.enrollment_id) = 1
            THEN 'Low'

        ELSE 'No Demand'
    END AS demand_level

INTO subject_demand

FROM subjects s

LEFT JOIN (
    SELECT
        e.enrollment_id,
        e.subject_id
    FROM enrollments e
    INNER JOIN students1 st
        ON e.student_id = st.student_id
) e
    ON s.subject_id = e.subject_id

GROUP BY
    s.subject_id,
    s.subject_name,
    s.max_seats;

    SELECT *
FROM subject_demand
ORDER BY enrolled_students DESC, subject_id;