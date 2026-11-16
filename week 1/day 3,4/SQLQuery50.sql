SELECT
    Employees.FirstName,
    Employees.Department,
    Departments.DepartmentID
FROM Employees
INNER JOIN Departments
ON Employees.Department = Departments.Department;