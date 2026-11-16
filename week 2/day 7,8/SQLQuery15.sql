ALTER FUNCTION dbo.GetAnnualSalary
(
    @MonthlySalary DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN (@MonthlySalary * 12) * 1.10;
END;