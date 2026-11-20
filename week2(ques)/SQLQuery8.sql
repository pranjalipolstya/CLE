DROP VIEW IF EXISTS dbo.VW_EMP_DEPT;
DROP TABLE IF EXISTS dbo.Employee;
DROP TABLE IF EXISTS dbo.Dept_loc;
GO

CREATE TABLE dbo.Employee
(
    Empid INT PRIMARY KEY,
    Full_name VARCHAR(100),
    Salary INT,
    Hiredate DATE,
    deptid INT
);
GO

CREATE TABLE dbo.Dept_loc
(
    deptid INT PRIMARY KEY,
    deptname VARCHAR(100),
    loc VARCHAR(50)
);
GO

INSERT INTO dbo.Employee
VALUES
(1012, 'Raji K Nair', 35500, '2018-04-09', 1),
(1009, 'Jeena', 12000, '2018-11-17', 2),
(1005, 'Nidhi R Shetty', 10000, '2019-01-16', 3),
(1011, 'Jiya Shetty', 45500, '2019-03-27', 4),
(1003, 'Arun Kumar Menon', 45500, '2019-08-02', 5),
(1007, 'Farah Ali', 30000, '2020-02-10', NULL),
(1001, 'Manoj P Iyer', 52000, '2020-07-15', 2);
GO

INSERT INTO dbo.Dept_loc
VALUES
(1, 'HR', 'Dallas'),
(2, 'Sales', 'Chicago'),
(3, 'Customer service', 'Chicago'),
(4, 'IT', 'Boston'),
(5, 'Research', 'Seattle'),
(6, 'Legal', 'New York');
GO

CREATE VIEW dbo.VW_EMP_DEPT
AS
WITH PreviousSalary AS
(
    SELECT
        Empid,
        Full_name,
        Salary,
        Hiredate,
        deptid,

        LAG(Salary) OVER
        (
            ORDER BY Hiredate, Empid
        ) AS Previous_emp_sal

    FROM dbo.Employee
),
CleanNames AS
(
    SELECT
        *,
        LTRIM(RTRIM(Full_name)) AS trimmed_name
    FROM PreviousSalary
)
SELECT
    c.Empid,

    CASE
        WHEN CHARINDEX(' ', c.trimmed_name) = 0
            THEN c.trimmed_name
        ELSE
            LEFT(c.trimmed_name,
                 CHARINDEX(' ', c.trimmed_name) - 1)
            + ' ' +
            RIGHT(c.trimmed_name,
                  CHARINDEX(' ', REVERSE(c.trimmed_name)) - 1)
    END AS Full_name,

    c.Salary,

    CAST(
        c.Salary *
        CASE
            WHEN d.loc = 'Chicago' THEN 1.05
            WHEN d.loc = 'Boston' THEN 1.03
            WHEN d.loc IN ('Dallas', 'New York') THEN 1.10
            ELSE 1.00
        END
        AS DECIMAL(12,2)
    ) AS Inc_Sal,

    c.Previous_emp_sal,
    c.Hiredate,

    COALESCE(d.deptname, 'NA') AS deptname,
    COALESCE(d.loc, 'NA') AS loc,

    CASE
        WHEN c.Previous_emp_sal IS NULL
            THEN 'No previous employee'

        WHEN c.Salary > c.Previous_emp_sal
            THEN 'Salary is greater than previously hired employee'

        WHEN c.Salary < c.Previous_emp_sal
            THEN 'Salary is less than previously hired employee'

        ELSE 'Salary is same as previously hired employee'
    END AS message

FROM CleanNames c
LEFT JOIN dbo.Dept_loc d
    ON c.deptid = d.deptid;
GO

SELECT *
FROM dbo.VW_EMP_DEPT
ORDER BY Hiredate, Empid;
GO
