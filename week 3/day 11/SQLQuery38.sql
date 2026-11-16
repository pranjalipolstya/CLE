CREATE TABLE DimCustomer
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50)
);

INSERT INTO DimCustomer (CustomerID, CustomerName, City)
VALUES
(1, 'Amit', 'Delhi'),
(2, 'Priya', 'Mumbai'),
(3, 'Rahul', 'Pune'),
(4, 'Neha', 'Bangalore');