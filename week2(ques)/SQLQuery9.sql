DROP TABLE IF EXISTS dbo.monthly_sales;
GO

CREATE TABLE dbo.monthly_sales
(
    month_start DATE,
    region VARCHAR(20),
    revenue DECIMAL(12,2),

    PRIMARY KEY (month_start, region)
);
GO

INSERT INTO dbo.monthly_sales
VALUES
('2026-01-01', 'North', 120000),
('2026-02-01', 'North', 135000),
('2026-03-01', 'North', 128000),
('2026-04-01', 'North', 150000),
('2026-05-01', 'North', 160000),
('2026-06-01', 'North', 145000),

('2026-01-01', 'South', 90000),
('2026-02-01', 'South', 85000),
('2026-03-01', 'South', 110000),
('2026-04-01', 'South', 105000),
('2026-05-01', 'South', 130000),
('2026-06-01', 'South', 140000);
GO

SELECT
    region,
    month_start,
    revenue,

    SUM(revenue) OVER
    (
        PARTITION BY region
        ORDER BY month_start
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_total,

    CAST(
        AVG(revenue) OVER
        (
            PARTITION BY region
            ORDER BY month_start
            ROWS BETWEEN 2 PRECEDING
            AND CURRENT ROW
        )
        AS DECIMAL(12,2)
    ) AS moving_avg_3m,

    CAST(
        100.0 * revenue /
        SUM(revenue) OVER
        (
            PARTITION BY region
        )
        AS DECIMAL(6,2)
    ) AS pct_of_total

FROM dbo.monthly_sales
ORDER BY region, month_start;
GO
