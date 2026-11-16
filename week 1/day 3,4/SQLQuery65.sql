SELECT
    E.FirstName,
    E.Department,
    D.DepartmentID,
    E.City,
    C.CityName
FROM Employees E

INNER JOIN Departments D
ON E.Department = D.Department

INNER JOIN Cities C
ON E.City = C.CityName;