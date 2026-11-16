SELECT firstName, Salary
FROM (
    SELECT firstName,
           Salary,
           ROW_NUMBER() OVER (
               ORDER BY Salary DESC
           ) AS RowNum
    FROM Employees
) AS RankedEmployees
WHERE RowNum = 2;

--rownum