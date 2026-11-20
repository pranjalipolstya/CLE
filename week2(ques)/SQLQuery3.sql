DROP PROCEDURE IF EXISTS dbo.sp_dateproc;
DROP TABLE IF EXISTS dbo.datepro_data;
DROP TABLE IF EXISTS dbo.datepro;

GO


CREATE TABLE datepro
(
    id INT PRIMARY KEY,
    Dateint INT,
    Datentime VARCHAR(40)
);

GO


INSERT INTO datepro VALUES
(101, 20220510, '2022-05-10T09:30:00+05:30'),
(102, 20220227, '2022-02-27T18:45:00+05:30'),
(103, 20220925, '2022-09-25T12:16:00+05:30'),
(104, 20221229, '2022-12-29T07:05:00+05:30'),
(105, 20221228, '2022-12-28T11:29:00+05:30');

GO


CREATE TABLE datepro_data
(
    id INT,
    Dateint INT,
    Datentime VARCHAR(16),
    Dates DATE
);

GO


CREATE PROCEDURE dbo.sp_dateproc
    @ids VARCHAR(MAX)
AS
BEGIN

    SET NOCOUNT ON;

    TRUNCATE TABLE datepro_data;

    ;WITH Selected AS
    (
        SELECT
            dp.id,
            dp.Dateint,

         
            CONVERT(
                VARCHAR(16),
                TRY_CONVERT(
                    DATETIME2(0),
                    LEFT(dp.Datentime, 19),
                    126
                ),
                120
            ) AS Datentime,

            -- Convert YYYYMMDD integer into DATE
            CONVERT(
                DATE,
                CONVERT(CHAR(8), dp.Dateint),
                112
            ) AS StartDate

        FROM datepro dp
        INNER JOIN
        (
            SELECT DISTINCT
                TRY_CONVERT(INT, LTRIM(RTRIM(value))) AS id
            FROM STRING_SPLIT(@ids, ',')
        ) AS requested
            ON dp.id = requested.id
    ),


    DateSeries AS
    (
        SELECT
            id,
            Dateint,
            Datentime,
            StartDate,
            StartDate AS Dates
        FROM Selected

        UNION ALL

        SELECT
            id,
            Dateint,
            Datentime,
            StartDate,
            DATEADD(DAY, 1, Dates)
        FROM DateSeries
        WHERE Dates < EOMONTH(StartDate)
    )

    INSERT INTO datepro_data
    (
        id,
        Dateint,
        Datentime,
        Dates
    )
    SELECT
        id,
        Dateint,
        Datentime,
        Dates
    FROM DateSeries
    OPTION (MAXRECURSION 100);

    SELECT
        id,
        Dateint,
        Datentime,
        Dates
    FROM datepro_data
    ORDER BY id, Dates;

END;

GO


EXEC dbo.sp_dateproc
    @ids = '101,102,104';

GO
