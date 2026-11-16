SELECT Employee, Month, Amount
FROM MonthlySales
UNPIVOT
(
    Amount
    FOR Month IN ([Jan], [Feb], [March])
) AS UnpivotTable;