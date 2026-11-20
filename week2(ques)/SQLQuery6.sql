DROP TABLE IF EXISTS dbo.top3_salary_levels;
DROP TABLE IF EXISTS dbo.emp_salary;

GO


CREATE TABLE emp_salary
(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

GO


INSERT INTO emp_salary VALUES
(1, 'Aditi', 'Engineering', 100000),
(2, 'Bharat', 'Engineering', 100000),
(3, 'Chetan', 'Engineering', 90000),
(4, 'Divya', 'Engineering', 80000),
(5, 'Eshan', 'Engineering', 80000),
(6, 'Farhan', 'Engineering', 70000),
(7, 'Gauri', 'Sales', 75000),
(8, 'Harsh', 'Sales', 72000),
(9, 'Ira', 'Sales', 72000),
(10, 'Jatin', 'Support', 50000),
(11, 'Kavya', 'HR', 60000),
(12, 'Lokesh', 'HR', 60000);

GO

SELECT
    emp_id,
    emp_name,
    department,
    salary,

    ROW_NUMBER() OVER
    (
        PARTITION BY department
        ORDER BY salary DESC, emp_id
    ) AS row_num,

    RANK() OVER
    (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS rnk,

    DENSE_RANK() OVER
    (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS dense_rnk

FROM emp_salary

ORDER BY department, salary DESC, emp_id;

GO

WITH SalaryRanking AS
(
    SELECT
        department,
        emp_name,
        salary,

        DENSE_RANK() OVER
        (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS salary_level

    FROM emp_salary
)

SELECT
    department,
    emp_name,
    salary,
    salary_level
INTO top3_salary_levels
FROM SalaryRanking
WHERE salary_level <= 3;

GO


SELECT *
FROM top3_salary_levels
ORDER BY department, salary DESC, emp_name;

GO
