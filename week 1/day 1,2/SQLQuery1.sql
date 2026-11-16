CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    City VARCHAR(50),
    JoiningDate DATE,
    Bonus DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1, 'Amit', 'Sharma', 'IT', 60000, 'Delhi', '2022-01-15', 5000),
(2, 'Priya', 'Verma', 'HR', 45000, 'Mumbai', '2023-03-10', NULL),
(3, 'Rahul', 'Singh', 'IT', 75000, 'Delhi', '2021-06-20', 8000),
(4, 'Neha', 'Gupta', 'Finance', 55000, 'Pune', '2024-02-01', 3000),
(5, 'Arjun', 'Patel', 'HR', 40000, 'Mumbai', '2022-11-05', NULL);