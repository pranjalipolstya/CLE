IF OBJECT_ID('fourth_highest_salary', 'U') IS NOT NULL
    DROP TABLE fourth_highest_salary;

IF OBJECT_ID('employees_above_dept_avg', 'U') IS NOT NULL
    DROP TABLE employees_above_dept_avg;

IF OBJECT_ID('manager_direct_reports', 'U') IS NOT NULL
    DROP TABLE manager_direct_reports;

SELECT
    MAX(salary) AS fourth_highest_salary

INTO fourth_highest_salary

FROM employees2

WHERE salary < (
    SELECT MAX(salary)
    FROM employees2
    WHERE salary < (
        SELECT MAX(salary)
        FROM employees2
        WHERE salary < (
            SELECT MAX(salary)
            FROM employees2
        )
    )
);


SELECT *
FROM fourth_highest_salary;


SELECT
    e.emp_name,
    e.dept_id,
    e.salary,

    CAST(
        ROUND(
            (
                SELECT AVG(CAST(e2.salary AS DECIMAL(10,2)))
                FROM employees2 e2
                WHERE e2.dept_id = e.dept_id
            ), 2
        ) AS DECIMAL(10,2)
    ) AS dept_avg_salary

INTO employees_above_dept_avg

FROM employees2 e

WHERE e.dept_id IS NOT NULL

AND e.salary > (
    SELECT AVG(CAST(e2.salary AS DECIMAL(10,2)))
    FROM employees2 e2
    WHERE e2.dept_id = e.dept_id
);

SELECT *
FROM employees_above_dept_avg
ORDER BY dept_id, salary DESC;


SELECT
    e.emp_id,
    e.emp_name,

    (
        SELECT COUNT(*)
        FROM employees2 r
        WHERE r.manager_id = e.emp_id
    ) AS direct_reports

INTO manager_direct_reports

FROM employees2 e

WHERE EXISTS (
    SELECT 1
    FROM employees2 r
    WHERE r.manager_id = e.emp_id
);

SELECT *
FROM manager_direct_reports
ORDER BY emp_id;
