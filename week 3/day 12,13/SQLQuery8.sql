CREATE TRIGGER trg_AfterInsert
ON Employees
AFTER INSERT
AS
BEGIN
    PRINT 'New employee inserted successfully';
END;