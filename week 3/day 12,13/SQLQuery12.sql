CREATE TRIGGER trg_AfterUpdate
ON Employees
AFTER UPDATE
AS
BEGIN
    SELECT
        EmployeeID,
        firstName,
        Salary
    FROM inserted;

    SELECT
        EmployeeID,
        firstName,
        Salary
    FROM deleted;
END;