DROP TABLE IF EXISTS dbo.longest_streak;
DROP TABLE IF EXISTS dbo.logins;
GO

CREATE TABLE dbo.logins
(
    user_id VARCHAR(10),
    login_date DATE,

    PRIMARY KEY (user_id, login_date)
);
GO

INSERT INTO dbo.logins
VALUES
('U1', '2026-03-01'),
('U1', '2026-03-02'),
('U1', '2026-03-03'),
('U1', '2026-03-05'),
('U1', '2026-03-06'),
('U1', '2026-03-07'),

('U2', '2026-03-01'),
('U2', '2026-03-03'),
('U2', '2026-03-04'),
('U2', '2026-03-05'),
('U2', '2026-03-06'),
('U2', '2026-03-10'),

('U3', '2026-03-02'),

('U4', '2026-03-01'),
('U4', '2026-03-02'),
('U4', '2026-03-04'),
('U4', '2026-03-05'),
('U4', '2026-03-08'),
('U4', '2026-03-09');
GO

WITH NumberedLogins AS
(
    SELECT
        user_id,
        login_date,

        ROW_NUMBER() OVER
        (
            PARTITION BY user_id
            ORDER BY login_date
        ) AS rn

    FROM dbo.logins
),

LoginGroups AS
(
    SELECT
        user_id,
        login_date,

        DATEADD
        (
            DAY,
            -CAST(rn AS INT),
            login_date
        ) AS grp

    FROM NumberedLogins
),

Streaks AS
(
    SELECT
        user_id,
        MIN(login_date) AS streak_start,
        MAX(login_date) AS streak_end,
        COUNT(*) AS streak_days

    FROM LoginGroups
    GROUP BY user_id, grp
),

RankedStreaks AS
(
    SELECT
        user_id,
        streak_start,
        streak_end,
        streak_days,

        ROW_NUMBER() OVER
        (
            PARTITION BY user_id
            ORDER BY streak_days DESC, streak_end DESC
        ) AS rn

    FROM Streaks
)

SELECT
    user_id,
    streak_start,
    streak_end,
    streak_days
INTO dbo.longest_streak
FROM RankedStreaks
WHERE rn = 1;
GO

SELECT *
FROM dbo.longest_streak
ORDER BY user_id;
GO
