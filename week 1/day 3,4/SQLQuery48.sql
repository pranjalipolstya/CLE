SELECT Department, AVG(Salary) AS AvgSalary
FROM Employees
WHERE Salary > 30000
GROUP BY Department
HAVING AVG(Salary) > 40000
ORDER BY AvgSalary DESC;