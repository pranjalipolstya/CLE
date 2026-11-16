SELECT Employee, [Jan], [Feb]
FROM
(
    SELECT Employee, Month, Amount
    FROM Sales
) AS SourceTable
PIVOT
(
    SUM(Amount)
    FOR Month IN ([Jan], [Feb])
) AS PivotTable;