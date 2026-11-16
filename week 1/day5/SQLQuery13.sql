SELECT FirstName, Department, Salary
FROM Employees E
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
    WHERE Department = E.Department
);

--correlated subqueries