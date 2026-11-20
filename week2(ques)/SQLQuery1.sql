CREATE TABLE author (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100)
);

CREATE TABLE book (
    book_id INT PRIMARY KEY,
    author_id INT,
    title VARCHAR(150),
    publish_year INT,

    FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

CREATE TABLE adaptation (
    book_id INT PRIMARY KEY,
    type VARCHAR(20),
    title VARCHAR(150),
    release_year INT,
    rating DECIMAL(3,2),

    FOREIGN KEY (book_id)
    REFERENCES book(book_id)
);

CREATE TABLE book_review (
    review_id INT PRIMARY KEY,
    book_id INT,
    rating INT,

    FOREIGN KEY (book_id)
    REFERENCES book(book_id)
);


INSERT INTO author VALUES
(1, 'Anita Rao'),
(2, 'Dev Malhotra'),
(3, 'Kiran Sethi'),
(4, 'Leela Thomas');

INSERT INTO book VALUES
(101, 1, 'The Monsoon Letters', 2015),
(102, 1, 'City of Lanterns', 2018),
(103, 2, 'Code of the Hills', 2012),
(104, 3, 'The Last Tea Garden', 2019),
(105, 4, 'Silent Harbour', 2016),
(106, 2, 'Paper Kites', 2020);

INSERT INTO adaptation VALUES
(101, 'Movie', 'Monsoon Letters', 2017, 8.10),
(102, 'Series', 'Lanterns', 2024, 7.90),
(103, 'Movie', 'Hill Code', 2014, 7.00),
(104, 'Series', 'Tea Garden', 2022, 8.60),
(105, 'Movie', 'Harbour', 2018, 6.50),
(106, 'Movie', 'Kites', 2021, 7.40);

INSERT INTO book_review VALUES
(1, 101, 7),
(2, 101, 8),
(3, 102, 6),
(4, 102, 7),
(5, 103, 8),
(6, 103, 7),
(7, 103, 9),
(8, 104, 8),
(9, 104, 8),
(10, 105, 6),
(11, 105, 7),
(12, 106, 7),
(13, 106, 7);

SELECT * FROM author;
SELECT * FROM book;
SELECT * FROM adaptation;
SELECT * FROM book_review;