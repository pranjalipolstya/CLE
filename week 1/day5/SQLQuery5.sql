SELECT FirstName, Department
FROM Employees

EXCEPT

SELECT FirstName, Department
FROM FormerEmployees;