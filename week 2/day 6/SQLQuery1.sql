WITH HighSalary AS
(
    SELECT firstName, Salary
    FROM Employees
    WHERE Salary > 50000
)
SELECT *
FROM HighSalary;