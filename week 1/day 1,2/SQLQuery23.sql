SELECT FirstName,
       COALESCE(Bonus, Salary, 0) AS Amount
FROM Employees;