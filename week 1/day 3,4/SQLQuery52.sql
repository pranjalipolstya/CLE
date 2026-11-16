SELECT
    Departments.Department,
    Employees.FirstName
FROM Departments
LEFT JOIN Employees
ON Departments.Department = Employees.Department;