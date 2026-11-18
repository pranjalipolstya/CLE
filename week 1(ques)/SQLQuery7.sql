IF OBJECT_ID('store_orders', 'U') IS NOT NULL
    DROP TABLE store_orders;

IF OBJECT_ID('store_customers', 'U') IS NOT NULL
    DROP TABLE store_customers;

CREATE TABLE store_customers (
    customer_id VARCHAR(5) PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(30)
);

INSERT INTO store_customers
(customer_id, customer_name, city)
VALUES
('C01', 'Rahul Mehta', 'Jaipur'),
('C02', 'Priya Nair', 'Kochi'),
('C03', 'Arjun Das', 'Kolkata'),
('C04', 'Fatima Sheikh', 'Mumbai'),
('C05', 'Karan Malhotra', 'Delhi');


CREATE TABLE store_orders (
    order_id VARCHAR(5) PRIMARY KEY,
    customer_id VARCHAR(5) NULL,
    order_date DATE,
    amount INT
);

INSERT INTO store_orders
(order_id, customer_id, order_date, amount)
VALUES
('O1001', 'C01', '2026-03-01', 1200),
('O1002', 'C02', '2026-03-02', 850),
('O1003', 'C01', '2026-03-05', 430),
('O1004', 'C07', '2026-03-06', 999),
('O1005', 'C04', '2026-03-08', 2100),
('O1006', NULL, '2026-03-09', 300);


IF OBJECT_ID('students_not_enrolled', 'U') IS NOT NULL
    DROP TABLE students_not_enrolled;

SELECT
    st.student_id,
    st.student_name,
    st.city

INTO students_not_enrolled

FROM students1 st

LEFT JOIN enrollments e
    ON st.student_id = e.student_id

WHERE e.enrollment_id IS NULL;


IF OBJECT_ID('customers_without_orders', 'U') IS NOT NULL
    DROP TABLE customers_without_orders;

SELECT
    c.customer_id,
    c.customer_name,
    c.city

INTO customers_without_orders

FROM store_customers c

LEFT JOIN store_orders o
    ON c.customer_id = o.customer_id

WHERE o.order_id IS NULL;


IF OBJECT_ID('unmatched_orders', 'U') IS NOT NULL
    DROP TABLE unmatched_orders;

SELECT
    o.order_id,
    o.customer_id,
    o.amount,

    CASE
        WHEN o.customer_id IS NULL
            THEN 'Guest order - no customer'

        WHEN c.customer_id IS NULL
            THEN 'Customer not found'
    END AS issue

INTO unmatched_orders

FROM store_orders o

LEFT JOIN store_customers c
    ON o.customer_id = c.customer_id

WHERE c.customer_id IS NULL;


SELECT *
FROM students_not_enrolled;

SELECT *
FROM customers_without_orders;

SELECT *
FROM unmatched_orders
ORDER BY order_id;