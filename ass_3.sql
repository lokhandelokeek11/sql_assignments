-- Create the database
CREATE DATABASE StudentManagement;
USE StudentManagement;

--  Create the Courses table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY NOT NULL,
    CourseName VARCHAR(100) NOT NULL UNIQUE,
    Credits INT DEFAULT 3
);

--  Create the Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    DOB DATE NOT NULL,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

--  Insert records into Courses
INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(1, 'Computer Science', 4),
(2, 'Mathematics', 3),
(3, 'Physics', 3);

--  Insert records into Students
INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID) VALUES
(101, 'Amit', 'Sharma', 'amit.sharma@example.in', '2002-05-15', 1),
(102, 'Priya', 'Iyer', 'priya.iyer@example.in', '2001-08-22', 2),
(103, 'Rahul', 'Patel', 'rahul.patel@example.in', '2003-11-10', 3),
(104, 'Gauri', 'Verma', NULL, '2002-07-19', 1); -- No email provided, which is valid

-- Write a query to display the names of students who were born after the year 2000
SELECT FirstName, LastName FROM Students
WHERE DOB > 2000;

-- Write a query to update the course credits for "Computer Science" to 4.
UPDATE Courses SET Credits = 4 
WHERE CourseName = "Computer Science";

UPDATE Students SET Email = "test@example.com" 
WHERE StudentID = '104';

SELECT * FROM Students;

-- Write a query to delete a student record whose email is 'test@example.com'.
DELETE FROM Students
WHERE Email = 'test@example.com';

-- Write a query to find students who are not enrolled in any course.
SELECT FirstName, LastName FROM Students 
WHERE StudentID IS NULL;

-- Test the UNIQUE constraint by inserting a duplicate email into the Students tables
INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID) 
VALUES (105, 'Lokeek', 'Lokhande', 'amit.sharma@example.in', '2002-12-10', 2);
-- Error Code: 1062. Duplicate entry 'amit.sharma@example.in' for key 'students.Email'

-- Test the FOREIGN KEY constraint by inserting a student with a CourseID that does not exist in the Courses table
INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID) 
VALUES (106, 'Sanya', 'Kapoor', 'sanya.kapoor@example.in', '2001-06-15', 99);
-- Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`studentmanagement`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`))












	
