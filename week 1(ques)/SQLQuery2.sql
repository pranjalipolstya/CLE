CREATE TABLE students1 (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    gender CHAR(1),
    city VARCHAR(30),
    email VARCHAR(100),
    phone VARCHAR(15),
    dob DATE,
    join_date DATE
);


INSERT INTO students1
(student_id, student_name, gender, city, email, phone, dob, join_date)
VALUES
(101, 'aarav sharma', 'M', 'Jaipur', 'aarav.sharma@gmail.com', '9876543210', '2004-05-12', '2026-01-05'),
(102, 'Diya Patel', 'F', 'Ahmedabad', 'diya.patel@yahoo.com', NULL, '2003-11-23', '2026-01-10'),
(103, 'Kabir Singh', 'M', 'Delhi', NULL, '9812345678', '2004-02-02', '2026-01-18'),
(104, 'Meera Iyer', 'F', 'Chennai', 'meera.iyer@outlook.com', '9900112233', NULL, '2026-02-03'),
(105, 'rohan VERMA', 'M', 'Jaipur', 'rohan.verma@gmail.com', '9811122233', '2005-07-30', '2026-02-14'),
(106, 'Sana Khan', 'F', 'Delhi', NULL, NULL, NULL, '2026-02-20'),
(107, 'Ishaan Gupta', 'M', 'Pune', 'ishaan.gupta@gmail.com', '9822001100', '2004-09-09', '2026-03-01'),
(108, 'Ananya Rao', 'F', NULL, NULL, NULL, '2003-12-19', '2026-03-05'),
(109, 'Vikram Joshi', 'M', 'Jaipur', 'vikram.joshi@yahoo.com', '9876501234', '2004-01-25', '2026-03-11'),
(110, 'Neha Kapoor', 'F', 'Mumbai', 'neha.kapoor@gmail.com', '9800098000', '2005-03-14', '2026-03-20');

SELECT student_id, student_name, city, join_date
INTO call_list
FROM students1
WHERE city IN ('Jaipur', 'Delhi')
  AND join_date BETWEEN '2026-02-01' AND '2026-03-31'
ORDER BY join_date DESC;

SELECT DISTINCT city
INTO campaign_cities
FROM students1
WHERE city IS NOT NULL
ORDER BY city;

SELECT * FROM call_list;

SELECT * FROM campaign_cities;