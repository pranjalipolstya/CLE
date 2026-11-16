SELECT firstName, Salary
FROM (
    SELECT firstName,
           Salary,
           DENSE_RANK() OVER (
               ORDER BY Salary DESC
           ) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank = 2;


--denserank