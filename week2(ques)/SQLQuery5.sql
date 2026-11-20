DROP PROCEDURE IF EXISTS dbo.sp_record_payment;

DROP TABLE IF EXISTS dbo.error_log;
DROP TABLE IF EXISTS dbo.payments;
DROP TABLE IF EXISTS dbo.order_items;
DROP TABLE IF EXISTS dbo.orders;

GO


CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    order_date DATE,
    status VARCHAR(30)
);

GO


CREATE TABLE order_items
(
    order_id INT,
    product_id VARCHAR(10),
    qty INT,
    unit_price DECIMAL(10,2),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

GO


INSERT INTO orders VALUES
(1001, 'C01', '2026-03-02', 'Delivered'),
(1002, 'C02', '2026-03-03', 'Delivered'),
(1003, 'C01', '2026-03-10', 'Delivered'),
(1004, 'C03', '2026-03-12', 'Cancelled'),
(1005, 'C04', '2026-03-15', 'Shipped'),
(1006, 'C05', '2026-03-18', 'Delivered'),
(1007, 'C01', '2026-04-01', 'Shipped'),
(1008, 'C06', '2026-04-03', 'Pending');

GO


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

GO


CREATE TABLE payments
(
    payment_id VARCHAR(10) PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount DECIMAL(10,2),
    method VARCHAR(30)
);

GO


INSERT INTO payments VALUES
('PM01', 1001, '2026-03-02', 2198, 'UPI'),
('PM02', 1002, '2026-03-03', 1000, 'Card'),
('PM03', 1002, '2026-03-05', 999, 'Card'),
('PM04', 1003, '2026-03-10', 500, 'UPI'),
('PM05', 1005, '2026-03-15', 3998, 'NetBanking'),
('PM06', 1006, '2026-03-18', 1497, 'UPI'),
('PM07', 1009, '2026-04-02', 750, 'UPI'),
('PM08', 1004, '2026-03-12', 1499, 'Card');

GO


CREATE TABLE error_log
(
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    error_time DATETIME DEFAULT GETDATE(),
    proc_name VARCHAR(100),
    error_number INT,
    error_message VARCHAR(500),
    input_values VARCHAR(200)
);

GO


CREATE PROCEDURE dbo.sp_record_payment
(
    @payment_id VARCHAR(10),
    @order_id INT,
    @amount DECIMAL(10,2),
    @method VARCHAR(30)
)
AS
BEGIN

    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION;


        IF NOT EXISTS
        (
            SELECT 1
            FROM orders
            WHERE order_id = @order_id
        )
        BEGIN
            THROW 50001, 'Order not found', 1;
        END;



        IF EXISTS
        (
            SELECT 1
            FROM orders
            WHERE order_id = @order_id
              AND status = 'Cancelled'
        )
        BEGIN
            THROW 50002, 'Order is cancelled', 1;
        END;



        IF @amount <= 0
        BEGIN
            THROW 50003, 'Amount must be greater than zero', 1;
        END;



        IF
        (
            SELECT COALESCE(SUM(amount), 0)
            FROM payments
            WHERE order_id = @order_id
        ) + @amount
        >
        (
            SELECT SUM(qty * unit_price)
            FROM order_items
            WHERE order_id = @order_id
        )
        BEGIN
            THROW 50004, 'Payment exceeds order value', 1;
        END;



        INSERT INTO payments
        (
            payment_id,
            order_id,
            payment_date,
            amount,
            method
        )
        VALUES
        (
            @payment_id,
            @order_id,
            CAST(GETDATE() AS DATE),
            @amount,
            @method
        );



        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH


        IF XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END;



        INSERT INTO error_log
        (
            proc_name,
            error_number,
            error_message,
            input_values
        )
        VALUES
        (
            'sp_record_payment',
            ERROR_NUMBER(),
            ERROR_MESSAGE(),
            CONCAT(
                @payment_id, ',',
                @order_id, ',',
                @amount, ',',
                @method
            )
        );

    END CATCH;

END;

GO

EXEC dbo.sp_record_payment
    'PM09', 1007, 1499, 'Card';



EXEC dbo.sp_record_payment
    'PM10', 1010, 500, 'UPI';



EXEC dbo.sp_record_payment
    'PM11', 1004, 100, 'UPI';



EXEC dbo.sp_record_payment
    'PM12', 1003, 0, 'UPI';



EXEC dbo.sp_record_payment
    'PM13', 1003, 600, 'UPI';



EXEC dbo.sp_record_payment
    'PM14', 1003, 499, 'UPI';

SELECT
    payment_id,
    order_id,
    amount,
    method
FROM payments
WHERE payment_id IN ('PM09', 'PM10', 'PM11',
                     'PM12', 'PM13', 'PM14')
ORDER BY payment_id;

SELECT
    log_id,
    proc_name,
    error_number,
    error_message,
    input_values
FROM error_log
ORDER BY log_id;

GO
