DROP TABLE IF EXISTS dbo.customer_latest;
DROP TABLE IF EXISTS dbo.customer_updates;
GO

CREATE TABLE dbo.customer_updates
(
    load_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    email VARCHAR(100),
    city VARCHAR(50),
    updated_at DATETIME2
);
GO

INSERT INTO dbo.customer_updates
VALUES
(1, 'C01', 'rahul@mail.com', 'Jaipur', '2026-05-01 10:00:00'),
(2, 'C02', 'priya@mail.com', 'Kochi', '2026-05-01 10:05:00'),
(3, 'C01', 'rahul.m@mail.com', 'Jaipur', '2026-05-03 09:00:00'),
(4, 'C03', 'arjun@mail.com', 'Kolkata', '2026-05-02 12:00:00'),
(5, 'C02', 'priya@mail.com', 'Kochi', '2026-05-01 10:05:00'),
(6, 'C01', 'rahul.m@mail.com', 'Delhi', '2026-05-03 09:00:00'),
(7, 'C04', 'fatima@mail.com', 'Mumbai', '2026-05-04 08:30:00'),
(8, 'C03', 'arjun.d@mail.com', 'Kolkata', '2026-05-05 18:45:00');
GO

WITH RankedCustomers AS
(
    SELECT
        load_id,
        customer_id,
        email,
        city,
        updated_at,

        ROW_NUMBER() OVER
        (
            PARTITION BY customer_id
            ORDER BY updated_at DESC, load_id DESC
        ) AS rn

    FROM dbo.customer_updates
)

SELECT
    customer_id,
    email,
    city,
    updated_at,
    load_id
INTO dbo.customer_latest
FROM RankedCustomers
WHERE rn = 1;
GO

SELECT *
FROM dbo.customer_latest
ORDER BY customer_id;
GO

SELECT
    (SELECT COUNT(*)
     FROM dbo.customer_updates) AS rows_loaded,

    (SELECT COUNT(*)
     FROM dbo.customer_latest) AS rows_kept,

    (SELECT COUNT(*)
     FROM dbo.customer_updates)
    -
    (SELECT COUNT(*)
     FROM dbo.customer_latest) AS rows_removed;
GO
