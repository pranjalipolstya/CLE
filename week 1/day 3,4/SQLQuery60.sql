--cross join

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50)
);
INSERT INTO Projects VALUES
(1, 'Website Development'),
(2, 'Database Management'),
(3, 'Mobile App');
SELECT * FROM Projects;