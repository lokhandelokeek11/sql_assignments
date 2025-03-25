mysql> SHOW DATABASES;
+-------------------------------+
| Database                      |
+-------------------------------+
| ass6_ecommercedb              |
| bankdb                        |
| customers                     |
| information_schema            |
| intro_sql                     |
| mysql                         |
| performance_schema            |
| smart_urban_transport_service |
| studentattendancedb           |
| sys                           |
+-------------------------------+
10 rows in set (0.00 sec)

mysql>
mysql> CREATE DATABASE StudentManagement;
Query OK, 1 row affected (0.01 sec)

mysql> USE StudentManagement;
Database changed
mysql> CREATE TABLE Courses (
    ->     CourseID INT PRIMARY KEY NOT NULL,
    ->     CourseName VARCHAR(100) NOT NULL UNIQUE,
    ->     Credits INT DEFAULT 3
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE Students (
    ->     StudentID INT PRIMARY KEY NOT NULL,
    ->     FirstName VARCHAR(50) NOT NULL,
    ->     LastName VARCHAR(50),
    ->     Email VARCHAR(100) UNIQUE,
    ->     DOB DATE NOT NULL,
    ->     CourseID INT,
    ->     FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
    -> (1, 'Computer Science', 4),
    -> (2, 'Mathematics', 3),
    -> (3, 'Physics', 3);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID) VALUES
    -> (101, 'Amit', 'Sharma', 'amit.sharma@example.in', '2002-05-15', 1),
    -> (102, 'Priya', 'Iyer', 'priya.iyer@example.in', '2001-08-22', 2),
    -> (103, 'Rahul', 'Patel', 'rahul.patel@example.in', '2003-11-10', 3),
    -> (104, 'Gauri', 'Verma', NULL, '2002-07-19', 1);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> -- Write a query to display the names of students who were born after the year 2000
mysql> SELECT FirstName, LastName FROM Students
    -> WHERE DOB > 2000;
+-----------+----------+
| FirstName | LastName |
+-----------+----------+
| Amit      | Sharma   |
| Priya     | Iyer     |
| Rahul     | Patel    |
| Gauri     | Verma    |
+-----------+----------+
4 rows in set, 1 warning (0.00 sec)

mysql> -- Write a query to update the course credits for "Computer Science" to 4.
mysql> UPDATE Courses SET Credits = 4
    -> WHERE CourseName = "Computer Science";
Query OK, 0 rows affected (0.00 sec)
Rows matched: 1  Changed: 0  Warnings: 0

mysql> UPDATE Students SET Email = "test@example.com"
    -> WHERE StudentID = '104';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Students;
+-----------+-----------+----------+------------------------+------------+----------+
| StudentID | FirstName | LastName | Email                  | DOB        | CourseID |
+-----------+-----------+----------+------------------------+------------+----------+
|       101 | Amit      | Sharma   | amit.sharma@example.in | 2002-05-15 |        1 |
|       102 | Priya     | Iyer     | priya.iyer@example.in  | 2001-08-22 |        2 |
|       103 | Rahul     | Patel    | rahul.patel@example.in | 2003-11-10 |        3 |
|       104 | Gauri     | Verma    | test@example.com       | 2002-07-19 |        1 |
+-----------+-----------+----------+------------------------+------------+----------+
4 rows in set (0.00 sec)

mysql>
mysql> -- Write a query to delete a student record whose email is 'test@example.com'.
mysql> DELETE FROM Students
    -> WHERE Email = 'test@example.com';
Query OK, 1 row affected (0.01 sec)

mysql> -- Write a query to find students who are not enrolled in any course.
mysql> SELECT FirstName, LastName FROM Students
    -> WHERE StudentID IS NULL;
Empty set (0.00 sec)

mysql> -- Test the UNIQUE constraint by inserting a duplicate email into the Students tables
mysql> INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID)
    -> VALUES (105, 'Lokeek', 'Lokhande', 'amit.sharma@example.in', '2002-12-10', 2);
ERROR 1062 (23000): Duplicate entry 'amit.sharma@example.in' for key 'students.Email'
mysql> -- Error Code: 1062. Duplicate entry 'amit.sharma@example.in' for key 'students.Email'
mysql> -- Test the FOREIGN KEY constraint by inserting a student with a CourseID that does not exist in the Courses table
mysql> INSERT INTO Students (StudentID, FirstName, LastName, Email, DOB, CourseID)
    -> VALUES (106, 'Sanya', 'Kapoor', 'sanya.kapoor@example.in', '2001-06-15', 99);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`studentmanagement`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`CourseID`) REFERENCES `courses` (`CourseID`))
