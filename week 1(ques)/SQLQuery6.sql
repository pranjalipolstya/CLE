SELECT *
FROM fee_payments;

IF OBJECT_ID('monthly_revenue', 'U') IS NOT NULL
    DROP TABLE monthly_revenue;

SELECT
    CONVERT(VARCHAR(7), payment_date, 120) AS pay_month,

    COUNT(CASE
        WHEN status = 'Success' THEN 1
    END) AS successful_payments,

    SUM(CASE
        WHEN status = 'Success' THEN amount
        ELSE 0
    END) AS total_revenue,

    AVG(CASE
        WHEN status = 'Success'
        THEN CAST(amount AS DECIMAL(10,2))
    END) AS avg_payment,

    SUM(CASE
        WHEN status <> 'Success' THEN 1
        ELSE 0
    END) AS other_payments

INTO monthly_revenue

FROM fee_payments

GROUP BY CONVERT(VARCHAR(7), payment_date, 120)

HAVING SUM(CASE
    WHEN status = 'Success' THEN amount
    ELSE 0
END) >= 15000;

SELECT *
FROM monthly_revenue
ORDER BY pay_month;

IF OBJECT_ID('subject_revenue', 'U') IS NOT NULL
    DROP TABLE subject_revenue;

SELECT
    s.subject_name,
    SUM(fp.amount) AS total_revenue

INTO subject_revenue

FROM fee_payments fp

INNER JOIN subjects s
    ON fp.subject_id = s.subject_id

WHERE fp.status = 'Success'

GROUP BY s.subject_name

HAVING SUM(fp.amount) > 8000;

SELECT *
FROM subject_revenue
ORDER BY total_revenue DESC;