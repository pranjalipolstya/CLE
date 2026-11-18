IF OBJECT_ID('payment_reconciliation', 'U') IS NOT NULL
    DROP TABLE payment_reconciliation;

SELECT
    COALESCE(os.order_id, p.order_id) AS order_id,

    os.status AS order_status,

    os.order_value,

    ISNULL(p.paid_amount, 0) AS paid_amount,

    CASE
        WHEN os.order_id IS NULL
            THEN 'Unknown Order'

        WHEN os.status = 'Cancelled'
             AND p.order_id IS NOT NULL
            THEN 'Refund Required'

        WHEN os.status <> 'Cancelled'
             AND p.order_id IS NULL
            THEN 'Payment Missing'

        WHEN p.paid_amount < os.order_value
            THEN 'Short Paid'
    END AS recon_status

INTO payment_reconciliation

FROM order_summary os

FULL OUTER JOIN
(
    SELECT
        order_id,
        SUM(amount) AS paid_amount
    FROM payments
    GROUP BY order_id
) p
    ON os.order_id = p.order_id

WHERE
       os.order_id IS NULL

    OR (os.status = 'Cancelled'
        AND p.order_id IS NOT NULL)

    OR (os.status <> 'Cancelled'
        AND p.order_id IS NULL)

    OR (p.order_id IS NOT NULL
        AND p.paid_amount < os.order_value);


SELECT *
FROM payment_reconciliation
ORDER BY order_id;
