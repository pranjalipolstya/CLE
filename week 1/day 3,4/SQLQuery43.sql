SELECT Department, Name, SUM(Salary)
FROM Employees
GROUP BY Department;


---Because Name is neither grouped nor aggregated.