CREATE TABLE DimProduct
(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO DimProduct (ProductID, ProductName, Category)
VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Mobile', 'Electronics'),
(103, 'Chair', 'Furniture'),
(104, 'Table', 'Furniture');