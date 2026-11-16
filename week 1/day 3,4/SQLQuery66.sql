SELECT
    E.FirstName,
    D.DepartmentID,
    D.department
FROM employees E
INNER JOIN departments D
ON e.department = d.department;