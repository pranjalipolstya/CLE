SELECT Salary / NULLIF(Bonus, 0) AS SalaryBonusRatio
FROM Employees;