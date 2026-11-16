SELECT FirstName,
       Salary,
       CASE
           WHEN Salary >= 70000 THEN 'High Salary'
           WHEN Salary >= 50000 THEN 'Medium Salary'
           ELSE 'Low Salary'
       END AS SalaryCategory
FROM Employees;