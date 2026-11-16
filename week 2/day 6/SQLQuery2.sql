WITH HighSalary AS
(
    SELECT *
    FROM Employees
    WHERE Salary > 50000
),
ITEmployees AS
(
    SELECT *
    FROM HighSalary
    WHERE Department = 'IT'
)
SELECT *
FROM ITEmployees;