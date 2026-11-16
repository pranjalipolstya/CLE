SELECT
    D.DepartmentID,
    D.Department,
    E.TotalEmployees
FROM Departments D
INNER JOIN
(
    SELECT
        Department,
        COUNT(*) AS TotalEmployees
    FROM Employees
    GROUP BY Department
) E
ON D.Department = E.Department;

--row aggreagtion before joining