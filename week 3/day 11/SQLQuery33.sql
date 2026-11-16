MERGE Employees AS T
USING NewEmployees AS S
ON T.EmployeeID = S.EmployeeID

WHEN MATCHED THEN
    UPDATE SET
        T.firstName = S.firstName,
        T.Salary = S.Salary

WHEN NOT MATCHED BY TARGET THEN
    INSERT (EmployeeID, firstName, Salary)
    VALUES (S.EmployeeID, S.firstName, S.Salary)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

    SELECT * FROM Employees;