SELECT Name
FROM students s
WHERE NOT EXISTS (
    SELECT 1
    FROM Department1 D
    WHERE s.DepartmentID = D.DepartmentID
);