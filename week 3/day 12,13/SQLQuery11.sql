CREATE TRIGGER trg_InsteadOfDelete
ON Employees
INSTEAD OF DELETE
AS
BEGIN
    PRINT 'Employee deletion is not allowed';
END;

DELETE FROM Employees
WHERE EmployeeID = 1;