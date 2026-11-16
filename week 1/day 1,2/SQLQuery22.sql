SELECT FirstName,
       ISNULL(Bonus, 0) AS Bonus
FROM Employees;