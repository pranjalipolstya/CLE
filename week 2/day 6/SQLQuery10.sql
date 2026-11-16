
DROP TABLE IF EXISTS #HighSalary;

CREATE TABLE #HighSalary
(
    EmployeeID INT,
    Name VARCHAR(100),
    Salary DECIMAL(10,2)
);

INSERT INTO #HighSalary
SELECT EmployeeID, FirstName, Salary
FROM Employees
WHERE Salary > 50000;

SELECT *
FROM #HighSalary;