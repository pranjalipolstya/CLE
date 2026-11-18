IF OBJECT_ID('student_profile_status', 'U') IS NOT NULL
    DROP TABLE student_profile_status;

SELECT
    student_id,
    student_name,

    (CASE WHEN email IS NULL THEN 1 ELSE 0 END +
     CASE WHEN phone IS NULL THEN 1 ELSE 0 END +
     CASE WHEN city IS NULL THEN 1 ELSE 0 END +
     CASE WHEN dob IS NULL THEN 1 ELSE 0 END) AS missing_fields,

    CASE
        WHEN email IS NULL AND phone IS NULL
            THEN 'Contact Missing'

        WHEN email IS NOT NULL
         AND phone IS NOT NULL
         AND city IS NOT NULL
         AND dob IS NOT NULL
            THEN 'Complete'

        ELSE 'Partially Complete'
    END AS profile_status

INTO student_profile_status
FROM students1;

SELECT *
FROM student_profile_status
ORDER BY student_id;


CREATE TABLE fee_payments (
    payment_id VARCHAR(5),
    student_id INT,
    subject_id VARCHAR(5),
    payment_date DATE,
    amount INT NULL,
    status VARCHAR(10)
);

INSERT INTO fee_payments
(payment_id, student_id, subject_id, payment_date, amount, status)
VALUES
('P01', 101, 'S01', '2026-01-06', 4000, 'Success'),
('P02', 101, 'S02', '2026-01-20', 5000, 'Success'),
('P03', 102, 'S01', '2026-01-11', 4000, 'Failed'),
('P04', 102, 'S01', '2026-01-12', 4000, 'Success'),
('P05', 103, 'S02', '2026-01-19', 2500, 'Success'),
('P06', 103, 'S03', '2026-02-01', 3500, 'Success'),
('P07', 104, 'S01', '2026-02-04', 4000, 'Success'),
('P08', 105, 'S02', '2026-02-15', 5000, 'Success'),
('P09', 105, 'S04', '2026-02-16', NULL, 'Pending'),
('P10', 103, 'S02', '2026-02-19', 2500, 'Success'),
('P11', 107, 'S01', '2026-03-02', 4000, 'Success'),
('P12', 107, 'S02', '2026-03-03', 5000, 'Refunded'),
('P13', 108, 'S03', '2026-03-06', 3500, 'Success'),
('P14', 109, 'S01', '2026-03-12', 4000, 'Success'),
('P15', 110, 'S05', '2026-03-21', 4500, 'Success');

IF OBJECT_ID('payment_classification', 'U') IS NOT NULL
    DROP TABLE payment_classification;

SELECT
    payment_id,
    student_id,
    amount,
    status,

    CASE
        WHEN amount IS NULL
            THEN 'Amount Missing'

        WHEN status <> 'Success'
            THEN 'Not Collected'

        ELSE 'Collected'
    END AS payment_class

INTO payment_classification
FROM fee_payments;

SELECT *
FROM payment_classification
ORDER BY payment_id;


IF OBJECT_ID('payment_average_check', 'U') IS NOT NULL
    DROP TABLE payment_average_check;

SELECT
    ROUND(AVG(CAST(amount AS DECIMAL(10,2))), 2)
        AS avg_amount_correct,

    ROUND(AVG(CAST(ISNULL(amount, 0) AS DECIMAL(10,2))), 2)
        AS avg_amount_wrong

INTO payment_average_check
FROM fee_payments;

SELECT *
FROM payment_average_check;