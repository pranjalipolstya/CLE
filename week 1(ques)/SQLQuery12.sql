IF OBJECT_ID('crm_billing_counts', 'U') IS NOT NULL
    DROP TABLE crm_billing_counts;

IF OBJECT_ID('crm_only', 'U') IS NOT NULL
    DROP TABLE crm_only;

IF OBJECT_ID('billing_only', 'U') IS NOT NULL
    DROP TABLE billing_only;

IF OBJECT_ID('common_customers', 'U') IS NOT NULL
    DROP TABLE common_customers;

IF OBJECT_ID('crm_customers', 'U') IS NOT NULL
    DROP TABLE crm_customers;

IF OBJECT_ID('billing_customers', 'U') IS NOT NULL
    DROP TABLE billing_customers;


CREATE TABLE crm_customers (
    customer_id VARCHAR(5),
    email VARCHAR(100)
);


INSERT INTO crm_customers
(customer_id, email)
VALUES
('C01', 'rahul.mehta@mail.com'),
('C02', 'priya.nair@mail.com'),
('C02', 'priya.nair@mail.com'),
('C03', 'arjun.das@mail.com'),
('C04', 'fatima.s@mail.com');


CREATE TABLE billing_customers (
    customer_id VARCHAR(5),
    email VARCHAR(100)
);


INSERT INTO billing_customers
(customer_id, email)
VALUES
('C02', 'priya.nair@mail.com'),
('C04', 'fatima.s@mail.com'),
('C05', 'karan.m@mail.com'),
('C06', 'sneha.k@mail.com');


SELECT
    customer_id,
    email

INTO common_customers

FROM crm_customers

INTERSECT

SELECT
    customer_id,
    email
FROM billing_customers;

SELECT *
FROM common_customers
ORDER BY customer_id;

SELECT
    customer_id,
    email

INTO crm_only

FROM crm_customers

EXCEPT

SELECT
    customer_id,
    email
FROM billing_customers;


SELECT *
FROM crm_only
ORDER BY customer_id;


SELECT
    customer_id,
    email

INTO billing_only

FROM billing_customers

EXCEPT

SELECT
    customer_id,
    email
FROM crm_customers;



SELECT *
FROM billing_only
ORDER BY customer_id;



SELECT
    (SELECT COUNT(*)
     FROM (
         SELECT customer_id, email
         FROM crm_customers

         UNION

         SELECT customer_id, email
         FROM billing_customers
     ) AS U) AS union_rows,

    (SELECT COUNT(*)
     FROM (
         SELECT customer_id, email
         FROM crm_customers

         UNION ALL

         SELECT customer_id, email
         FROM billing_customers
     ) AS UA) AS union_all_rows

INTO crm_billing_counts;


SELECT *
FROM crm_billing_counts;