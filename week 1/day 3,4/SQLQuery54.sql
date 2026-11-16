SELECT D.Department
FROM Departments D
WHERE NOT EXISTS
(
    SELECT 1
    FROM Employees E
    WHERE E.Department = D.Department
);