SELECT
    Employees.FirstName,
    Departments.Department
FROM Employees
FULL OUTER JOIN Departments
ON Employees.Department = Departments.Department;