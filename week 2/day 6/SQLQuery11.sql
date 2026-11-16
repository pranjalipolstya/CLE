CREATE TABLE ##EmployeeData
(
    EmployeeID INT,
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);

INSERT INTO ##EmployeeData
SELECT EmployeeID, firstName, Salary
FROM Employees;

SELECT *
FROM ##EmployeeData;