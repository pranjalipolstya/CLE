DROP PROCEDURE IF EXISTS dbo.sp_customer_orders;
DROP FUNCTION IF EXISTS dbo.fn_format_us_date;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_id INT,
    product_id VARCHAR(10),
    qty INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


INSERT INTO customers VALUES
('C01', 'Rahul Mehta', 'Jaipur', '2025-11-02'),
('C02', 'Priya Nair', 'Kochi', '2025-12-15'),
('C03', 'Arjun Das', 'Kolkata', '2026-01-08'),
('C04', 'Fatima Sheikh', 'Mumbai', '2026-01-20'),
('C05', 'Karan Malhotra', 'Delhi', '2026-02-11'),
('C06', 'Sneha Kulkarni', 'Pune', '2026-02-25');


INSERT INTO orders VALUES
(1001, 'C01', '2026-03-02', 'Delivered'),
(1002, 'C02', '2026-03-03', 'Delivered'),
(1003, 'C01', '2026-03-10', 'Delivered'),
(1004, 'C03', '2026-03-12', 'Cancelled'),
(1005, 'C04', '2026-03-15', 'Shipped'),
(1006, 'C05', '2026-03-18', 'Delivered'),
(1007, 'C01', '2026-04-01', 'Shipped'),
(1008, 'C06', '2026-04-03', 'Pending');


INSERT INTO order_items VALUES
(1001, 'P1', 2, 799),
(1001, 'P3', 5, 120),
(1002, 'P2', 1, 1999),
(1003, 'P4', 2, 250),
(1003, 'P6', 1, 499),
(1004, 'P5', 1, 1499),
(1005, 'P1', 1, 799),
(1005, 'P2', 1, 1999),
(1005, 'P3', 10, 120),
(1006, 'P6', 3, 499),
(1007, 'P5', 1, 1499),
(1008, 'P4', 4, 250);

go

CREATE FUNCTION dbo.fn_format_us_date
(
    @input_date DATETIME
)
RETURNS VARCHAR(10)
AS
BEGIN
    RETURN CONVERT(VARCHAR(10), @input_date, 101);
END;
go

CREATE PROCEDURE dbo.sp_customer_orders
(
    @customer_id VARCHAR(10),
    @order_count INT OUTPUT,
    @total_value DECIMAL(10,2) OUTPUT
)
AS
BEGIN


    SET @order_count = 0;
    SET @total_value = 0;


    SELECT
        @order_count = COUNT(*),
        @total_value = COALESCE(SUM(order_value), 0)
    FROM
    (
        SELECT
            o.order_id,
            SUM(oi.qty * oi.unit_price) AS order_value
        FROM orders o
        INNER JOIN order_items oi
            ON o.order_id = oi.order_id
        WHERE o.customer_id = @customer_id
          AND o.status <> 'Cancelled'
        GROUP BY o.order_id
    ) AS order_summary;


    SELECT
        o.order_id,
        dbo.fn_format_us_date(o.order_date) AS order_date_us,
        o.status,
        SUM(oi.qty * oi.unit_price) AS order_value
    FROM orders o
    INNER JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.customer_id = @customer_id
      AND o.status <> 'Cancelled'
    GROUP BY
        o.order_id,
        o.order_date,
        o.status
    ORDER BY o.order_id;

END;
go

DECLARE @cnt INT,
        @val DECIMAL(10,2);

EXEC dbo.sp_customer_orders
    @customer_id = 'C01',
    @order_count = @cnt OUTPUT,
    @total_value = @val OUTPUT;

SELECT
    @cnt AS order_count,
    @val AS total_value;

DECLARE @cnt2 INT,
        @val2 DECIMAL(10,2);

EXEC dbo.sp_customer_orders
    @customer_id = 'C99',
    @order_count = @cnt2 OUTPUT,
    @total_value = @val2 OUTPUT;

SELECT
    @cnt2 AS order_count,
    @val2 AS total_value;