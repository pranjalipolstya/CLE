SELECT Department, COUNT(*) AS TotalEmployees
FROM Employees
WHERE Salary > 40000
GROUP BY Department
HAVING COUNT(*) > 1;