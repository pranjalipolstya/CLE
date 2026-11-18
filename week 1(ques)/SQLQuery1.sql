CREATE TABLE course_batches
(
    batch_id INT PRIMARY KEY,
    subject_id VARCHAR(5) NOT NULL,
    batch_name VARCHAR(40) NOT NULL,
    start_date DATE NOT NULL,
    capacity INT CHECK (capacity > 0),
    trainer VARCHAR(40) NULL,
    status VARCHAR(10) DEFAULT 'Planned'
);

INSERT INTO course_batches
(batch_id, subject_id, batch_name, start_date, capacity, trainer)
VALUES
(1, 'S01', 'SQL Morning Batch', '2026-04-01', 30, NULL),
(2, 'S02', 'Python Weekend Batch', '2026-04-05', 25, 'Ritu Sharma'),
(3, 'S03', 'Visualization Evening', '2026-05-10', 20, NULL),
(4, 'S01', 'SQL Evening Batch', '2026-03-20', 30, 'Amit Bansal');

SELECT * FROM course_batches;

INSERT INTO course_batches
(batch_id, subject_id, batch_name, start_date, capacity, trainer)
VALUES
(5, 'S04', 'Stats Crash Course', '2026-04-15', 0, NULL);

UPDATE course_batches
SET trainer = 'Neha Joshi'
WHERE batch_id = 1;

UPDATE course_batches
SET trainer = 'Ritu Sharma'
WHERE batch_id = 3;


SELECT * FROM course_batches;

BEGIN TRANSACTION;
DELETE FROM course_batches
WHERE status = 'Planned';
SELECT * FROM course_batches;

ROLLBACK TRANSACTION;

SELECT * FROM course_batches;

UPDATE course_batches
SET status = 'Open'
WHERE start_date <= '2026-04-01';

SELECT * FROM course_batches
ORDER BY batch_id;