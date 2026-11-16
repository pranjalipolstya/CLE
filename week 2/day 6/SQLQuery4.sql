CREATE VIEW HighSalaryEmployees
AS
SELECT firstName, Department, Salary
FROM Employees
WHERE Salary > 50000;

