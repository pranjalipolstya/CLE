IF OBJECT_ID('order_summary', 'U') IS NOT NULL
    DROP TABLE order_summary;

IF OBJECT_ID('order_items', 'U') IS NOT NULL
    DROP TABLE order_items;

IF OBJECT_ID('payments', 'U') IS NOT NULL
    DROP TABLE payments;

IF OBJECT_ID('orders', 'U') IS NOT NULL
    DROP TABLE orders;

IF OBJECT_ID('products', 'U') IS NOT NULL
    DROP TABLE products;

IF OBJECT_ID('customers', 'U') IS NOT NULL
    DROP TABLE customers;


CREATE TABLE customers (
    customer_id VARCHAR(5) PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30),
    signup_date DATE
);

INSERT INTO customers
(customer_id, customer_name, city, signup_date)
VALUES
('C01', 'Rahul Mehta', 'Jaipur', '2025-11-02'),
('C02', 'Priya Nair', 'Kochi', '2025-12-15'),
('C03', 'Arjun Das', 'Kolkata', '2026-01-08'),
('C04', 'Fatima Sheikh', 'Mumbai', '2026-01-20'),
('C05', 'Karan Malhotra', 'Delhi', '2026-02-11'),
('C06', 'Sneha Kulkarni', 'Pune', '2026-02-25');


CREATE TABLE products (
    product_id VARCHAR(5) PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    unit_price INT
);

INSERT INTO products
(product_id, product_name, category, unit_price)
VALUES
('P1', 'Wireless Mouse', 'Electronics', 799),
('P2', 'USB-C Hub', 'Electronics', 1999),
('P3', 'Notebook A5', 'Stationery', 120),
('P4', 'Gel Pen Pack', 'Stationery', 250),
('P5', 'Desk Lamp', 'Home', 1499),
('P6', 'Water Bottle', 'Home', 499);


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(5),
    order_date DATE,
    status VARCHAR(20)
);

INSERT INTO orders
(order_id, customer_id, order_date, status)
VALUES
(1001, 'C01', '2026-03-02', 'Delivered'),
(1002, 'C02', '2026-03-03', 'Delivered'),
(1003, 'C01', '2026-03-10', 'Delivered'),
(1004, 'C03', '2026-03-12', 'Cancelled'),
(1005, 'C04', '2026-03-15', 'Shipped'),
(1006, 'C05', '2026-03-18', 'Delivered'),
(1007, 'C01', '2026-04-01', 'Shipped'),
(1008, 'C06', '2026-04-03', 'Pending');


CREATE TABLE order_items (
    order_id INT,
    product_id VARCHAR(5),
    qty INT,
    unit_price INT
);

INSERT INTO order_items
(order_id, product_id, qty, unit_price)
VALUES
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


CREATE TABLE payments (
    payment_id VARCHAR(5) PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount INT,
    method VARCHAR(20)
);

INSERT INTO payments
(payment_id, order_id, payment_date, amount, method)
VALUES
('PM01', 1001, '2026-03-02', 2198, 'UPI'),
('PM02', 1002, '2026-03-03', 1000, 'Card'),
('PM03', 1002, '2026-03-05', 999, 'Card'),
('PM04', 1003, '2026-03-10', 500, 'UPI'),
('PM05', 1005, '2026-03-15', 3998, 'NetBanking'),
('PM06', 1006, '2026-03-18', 1497, 'UPI'),
('PM07', 1009, '2026-04-02', 750, 'UPI'),
('PM08', 1004, '2026-03-12', 1499, 'Card');


SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,

    ISNULL(oi.item_count, 0) AS item_count,

    ISNULL(oi.order_value, 0) AS order_value,

    ISNULL(p.paid_amount, 0) AS paid_amount,

    ISNULL(oi.order_value, 0)
        - ISNULL(p.paid_amount, 0) AS balance,

    CASE
        WHEN ISNULL(p.paid_amount, 0)
             >= ISNULL(oi.order_value, 0)
            THEN 'Paid'

        WHEN ISNULL(p.paid_amount, 0) > 0
            THEN 'Partially Paid'

        ELSE 'Unpaid'
    END AS payment_status

INTO order_summary

FROM orders o

INNER JOIN customers c
    ON o.customer_id = c.customer_id

LEFT JOIN
(
    SELECT
        order_id,
        SUM(qty) AS item_count,
        SUM(qty * unit_price) AS order_value
    FROM order_items
    GROUP BY order_id
) oi
    ON o.order_id = oi.order_id

LEFT JOIN
(
    SELECT
        order_id,
        SUM(amount) AS paid_amount
    FROM payments
    GROUP BY order_id
) p
    ON o.order_id = p.order_id;


SELECT *
FROM order_summary
ORDER BY order_id;
