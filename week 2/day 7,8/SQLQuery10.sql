DECLARE @Count INT;

EXEC GetEmployeeCount
    @TotalEmployees = @Count OUTPUT;

SELECT @Count AS TotalEmployees;