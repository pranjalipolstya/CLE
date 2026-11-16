SELECT
    Employees.FirstName,
    Departments.Department
FROM Employees
RIGHT JOIN Departments
ON Employees.Department = Departments.Department;