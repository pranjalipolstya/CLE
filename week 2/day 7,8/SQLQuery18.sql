--Inline Table-Valued Function

CREATE FUNCTION dbo.GetEmployeesByDept
(
    @DeptName VARCHAR(50)
)
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM Employees
    WHERE Department = @DeptName
);

