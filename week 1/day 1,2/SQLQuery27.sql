SELECT FirstName,
       Salary,
       CASE
           WHEN Department = 'IT' THEN Salary * 0.10
           WHEN Department = 'HR' THEN Salary * 0.05
           ELSE Salary * 0.03
       END AS ProposedBonus
FROM Employees;