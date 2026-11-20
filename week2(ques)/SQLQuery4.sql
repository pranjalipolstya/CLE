DROP PROCEDURE IF EXISTS dbo.sp_allot_subjects;

DROP TABLE IF EXISTS dbo.Allotments;
DROP TABLE IF EXISTS dbo.UnallotedStudents;
DROP TABLE IF EXISTS dbo.StudentPreference;
DROP TABLE IF EXISTS dbo.SubjectDetails;
DROP TABLE IF EXISTS dbo.StudentDetails;

GO


CREATE TABLE StudentDetails
(
    StudentId INT PRIMARY KEY,
    StudentName VARCHAR(100),
    GPA DECIMAL(3,2),
    Branch VARCHAR(20),
    Section VARCHAR(10)
);

GO


CREATE TABLE SubjectDetails
(
    SubjectId VARCHAR(10) PRIMARY KEY,
    SubjectName VARCHAR(100),
    MaxSeats INT,
    RemainingSeats INT
);

GO


CREATE TABLE StudentPreference
(
    StudentId INT,
    SubjectId VARCHAR(10),
    Preference INT,

    FOREIGN KEY (StudentId)
        REFERENCES StudentDetails(StudentId),

    FOREIGN KEY (SubjectId)
        REFERENCES SubjectDetails(SubjectId),

    CONSTRAINT UQ_Student_Subject
        UNIQUE (StudentId, SubjectId),

    CONSTRAINT PK_StudentPreference
        PRIMARY KEY (StudentId, Preference)
);

GO


CREATE TABLE Allotments
(
    SubjectId VARCHAR(10),
    StudentId INT,

    FOREIGN KEY (SubjectId)
        REFERENCES SubjectDetails(SubjectId),

    FOREIGN KEY (StudentId)
        REFERENCES StudentDetails(StudentId)
);

GO


CREATE TABLE UnallotedStudents
(
    StudentId INT PRIMARY KEY,

    FOREIGN KEY (StudentId)
        REFERENCES StudentDetails(StudentId)
);

GO


INSERT INTO StudentDetails VALUES
(159103036, 'Mohit Agarwal', 8.90, 'CCE', 'A'),
(159103037, 'Rohit Agarwal', 5.20, 'CCE', 'A'),
(159103038, 'Shohit Garg', 7.10, 'CCE', 'B'),
(159103039, 'Mrinal Malhotra', 7.90, 'CCE', 'A'),
(159103040, 'Mehreet Singh', 5.60, 'CCE', 'A'),
(159103041, 'Arjun Tehlan', 9.20, 'CCE', 'B');

GO


INSERT INTO SubjectDetails VALUES
('PO1491', 'Basics of Political Science', 60, 2),
('PO1492', 'Basics of Accounting', 120, 1),
('PO1493', 'Basics of Financial Markets', 90, 1),
('PO1494', 'Eco philosophy', 60, 1),
('PO1495', 'Automotive Trends', 60, 0);

GO


INSERT INTO StudentPreference VALUES
(159103036, 'PO1491', 1),
(159103036, 'PO1492', 2),
(159103036, 'PO1493', 3),
(159103036, 'PO1494', 4),
(159103036, 'PO1495', 5),

(159103037, 'PO1494', 1),
(159103037, 'PO1495', 2),
(159103037, 'PO1492', 3),
(159103037, 'PO1491', 4),
(159103037, 'PO1493', 5),

(159103038, 'PO1492', 1),
(159103038, 'PO1491', 2),
(159103038, 'PO1494', 3),
(159103038, 'PO1495', 4),
(159103038, 'PO1493', 5),

(159103039, 'PO1491', 1),
(159103039, 'PO1492', 2),
(159103039, 'PO1495', 3),
(159103039, 'PO1493', 4),
(159103039, 'PO1494', 5),


(159103040, 'PO1492', 1),
(159103040, 'PO1494', 2),
(159103040, 'PO1491', 3),
(159103040, 'PO1493', 4),
(159103040, 'PO1495', 5),


(159103041, 'PO1491', 1),
(159103041, 'PO1493', 2),
(159103041, 'PO1492', 3),
(159103041, 'PO1494', 4),
(159103041, 'PO1495', 5);

GO

CREATE PROCEDURE dbo.sp_allot_subjects
AS
BEGIN

    SET NOCOUNT ON;

    DELETE FROM Allotments;
    DELETE FROM UnallotedStudents;

    DECLARE
        @StudentId INT,
        @AllocatedSubject VARCHAR(10);

    DECLARE student_cursor CURSOR LOCAL FAST_FORWARD
    FOR
        SELECT StudentId
        FROM StudentDetails
        ORDER BY GPA DESC, StudentId;

    OPEN student_cursor;

    FETCH NEXT FROM student_cursor
    INTO @StudentId;

    WHILE @@FETCH_STATUS = 0
    BEGIN

        SET @AllocatedSubject = NULL;

        SELECT TOP 1
            @AllocatedSubject = sp.SubjectId
        FROM StudentPreference sp
        INNER JOIN SubjectDetails sd
            ON sp.SubjectId = sd.SubjectId
        WHERE sp.StudentId = @StudentId
          AND sd.RemainingSeats > 0
        ORDER BY sp.Preference;

        IF @AllocatedSubject IS NOT NULL
        BEGIN

            UPDATE SubjectDetails
            SET RemainingSeats = RemainingSeats - 1
            WHERE SubjectId = @AllocatedSubject;

            INSERT INTO Allotments
            VALUES (@AllocatedSubject, @StudentId);

        END

        ELSE
        BEGIN

            INSERT INTO UnallotedStudents
            VALUES (@StudentId);

        END;

        FETCH NEXT FROM student_cursor
        INTO @StudentId;

    END;

    CLOSE student_cursor;
    DEALLOCATE student_cursor;

END;

GO

EXEC dbo.sp_allot_subjects;

GO


SELECT SubjectId, StudentId
FROM Allotments
ORDER BY
    CASE SubjectId
        WHEN 'PO1491' THEN 1
        WHEN 'PO1492' THEN 2
        WHEN 'PO1494' THEN 3
        WHEN 'PO1493' THEN 4
        ELSE 5
    END;


SELECT StudentId
FROM UnallotedStudents;


SELECT *
FROM SubjectDetails;
