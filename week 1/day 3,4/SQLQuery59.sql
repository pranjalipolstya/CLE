SELECT
    E.FirstName AS Employee,
    M.FirstName AS Manager
FROM Employees E
LEFT JOIN Employees M
ON E.ManagerID = M.EmployeeID;

--self join