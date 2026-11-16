SELECT Salary,
       ROUND(Salary * 1.075, 2) AS SalaryAfterRaise,
       CEILING(Salary / 1000.0) AS RoundedUpThousands,
       FLOOR(Salary / 1000.0) AS RoundedDownThousands
FROM Employees;