SELECT
    FirstName,
    Salary,
    dbo.GetAnnualSalary(Salary) AS AnnualSalary
FROM Employees;