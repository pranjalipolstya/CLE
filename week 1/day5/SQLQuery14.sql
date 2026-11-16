SELECT Department, AvgSalary
FROM (
    SELECT Department,
           AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY Department
) AS DepartmentSalary
WHERE AvgSalary > 50000;

--derived tables