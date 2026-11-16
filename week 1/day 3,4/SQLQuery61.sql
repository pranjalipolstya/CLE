SELECT
    Employees.FirstName,
    Projects.ProjectName
FROM Employees
CROSS JOIN Projects;