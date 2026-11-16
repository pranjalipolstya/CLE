SELECT UPPER(FirstName) AS UpperName,
       LOWER(Department) AS LowerDepartment,
       LEFT(FirstName, 2) AS FirstTwoLetters,
       RIGHT(LastName, 3) AS LastThreeLetters,
       LEN(FirstName) AS NameLength
FROM Employees;