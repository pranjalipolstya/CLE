SELECT
    COUNT(CASE
        WHEN Department = 'IT' THEN 1
    END) AS IT_Employees,

    COUNT(CASE
        WHEN Department = 'HR' THEN 1
    END) AS HR_Employees,

    COUNT(CASE
        WHEN Department = 'Sales' THEN 1
    END) AS Sales_Employees
FROM Employees;