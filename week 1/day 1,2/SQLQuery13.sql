SELECT DATEPART(YEAR, JoiningDate) AS JoinYear,
       DATEPART(MONTH, JoiningDate) AS JoinMonth,
       DATEPART(DAY, JoiningDate) AS JoinDay
FROM Employees;