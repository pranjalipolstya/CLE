DROP VIEW IF EXISTS dbo.vw_book_author;
DROP TABLE IF EXISTS dbo.BookAuthors;
DROP TABLE IF EXISTS dbo.Authors;
DROP TABLE IF EXISTS dbo.Books;
GO

CREATE TABLE dbo.Books
(
    BookID INT PRIMARY KEY,
    Title VARCHAR(100)
);
GO

CREATE TABLE dbo.Authors
(
    AuthorID INT PRIMARY KEY,
    AuthorName VARCHAR(100)
);
GO

CREATE TABLE dbo.BookAuthors
(
    BookID INT,
    AuthorID INT,

    PRIMARY KEY (BookID, AuthorID),

    FOREIGN KEY (BookID)
        REFERENCES dbo.Books(BookID),

    FOREIGN KEY (AuthorID)
        REFERENCES dbo.Authors(AuthorID)
);
GO

INSERT INTO dbo.Books
VALUES
(1, 'Desert Winds'),
(2, 'River Songs'),
(3, 'The Glass Fort'),
(4, 'Night Train'),
(5, 'Salt and Stone'),
(6, 'Paper Moons');
GO

INSERT INTO dbo.Authors
VALUES
(1, 'Meera Kaul'),
(2, 'Rohan Sen'),
(3, 'Tanvi Bose'),
(4, 'Ishita Roy');
GO

INSERT INTO dbo.BookAuthors
VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 3),
(4, 4),
(5, 2),
(6, 2),
(6, 1);
GO

CREATE VIEW dbo.vw_book_author
AS

WITH AuthorCounts AS
(
    SELECT
        AuthorID,
        COUNT(*) AS BookCount
    FROM dbo.BookAuthors
    GROUP BY AuthorID
)

SELECT
    B.Title AS Booktitle,

    STRING_AGG(A.AuthorName, ',')
        WITHIN GROUP (ORDER BY A.AuthorName) AS Authorname,

    STRING_AGG(CAST(AC.BookCount AS VARCHAR(10)), ',')
        WITHIN GROUP (ORDER BY A.AuthorName) AS Book_count

FROM dbo.Books B

INNER JOIN dbo.BookAuthors BA
    ON B.BookID = BA.BookID

INNER JOIN dbo.Authors A
    ON BA.AuthorID = A.AuthorID

INNER JOIN AuthorCounts AC
    ON A.AuthorID = AC.AuthorID

GROUP BY B.BookID, B.Title;
GO

SELECT *
FROM dbo.vw_book_author
ORDER BY Booktitle;
GO
