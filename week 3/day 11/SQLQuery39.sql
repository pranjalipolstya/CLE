SELECT
    C.CustomerName,
    P.ProductName,
    F.Quantity,
    F.Amount
FROM FactSales F
INNER JOIN DimCustomer C
    ON F.CustomerID = C.CustomerID
INNER JOIN DimProduct P
    ON F.ProductID = P.ProductID;