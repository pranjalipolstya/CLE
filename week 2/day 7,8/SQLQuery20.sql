---Multi-Statement Table-Valued Function

CREATE FUNCTION dbo.GetHighSalaryEmployees()
RETURNS @EmployeeTable TABLE
(
    EmployeeID INT,
    FirstName VARCHAR(50),
    Salary DECIMAL(10,2)
)
AS
BEGIN

    INSERT INTO @EmployeeTable
    SELECT EmployeeID, FirstName, Salary
    FROM Employees
    WHERE Salary > 50000;

    RETURN;
END;