SELECT Departments.Department
FROM Departments
LEFT JOIN Employees
ON Departments.Department = Employees.Department
WHERE Employees.EmployeeID IS NULL;