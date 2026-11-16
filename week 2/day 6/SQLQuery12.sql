DECLARE @EmployeeData TABLE
(
    EmployeeID INT,
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);

INSERT INTO @EmployeeData
SELECT EmployeeID, firstName, Salary
FROM Employees
WHERE Salary > 50000;

SELECT *
FROM @EmployeeData;