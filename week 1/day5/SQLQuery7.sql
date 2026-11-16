SELECT FirstName, Department
FROM Employees
WHERE Department IN (
    SELECT Department
    FROM Employees
    WHERE Salary > 60000
);

--in operator