mysql> SHOW DATABASES;
+---------------------+
| Database            |
+---------------------+
| ass6                |
| ass6_ecommercedb    |
| bankdb              |
| customers           |
| information_schema  |
| intro_sql           |
| mysql               |
| performance_schema  |
| studentattendancedb |
| studentmanagement   |
| sys                 |
+---------------------+
11 rows in set (0.00 sec)

mysql> CREATE DATABASE SmartUrbanMobility;
Query OK, 1 row affected (0.00 sec)

mysql> USE SmartUrbanMobility;
Database changed
mysql> CREATE TABLE Users (
    ->     UserID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100),
    ->     Email VARCHAR(100) UNIQUE,
    ->     Phone VARCHAR(15),
    ->     UserType ENUM('Commuter', 'Driver', 'Administrator'),
    ->     Preferences TEXT
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE PublicTransportServices (
    ->     ServiceID INT PRIMARY KEY AUTO_INCREMENT,
    ->     RouteID INT,
    ->     TransportType ENUM('Bus', 'Metro'),
    ->     Schedule TIME,
    ->     Capacity INT,
    ->     Fare DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE PrivateTransportServices (
    ->     DriverID INT,
    ->     VehicleID INT,
    ->     RideID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Fare DECIMAL(10,2),
    ->     Status ENUM('Active', 'Completed')
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Routes (
    ->     RouteID INT PRIMARY KEY AUTO_INCREMENT,
    ->     StartLocation VARCHAR(100),
    ->     EndLocation VARCHAR(100),
    ->     RouteDetails TEXT,
    ->     Distance DECIMAL(5,2)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Tickets (
    ->     TicketID INT PRIMARY KEY AUTO_INCREMENT,
    ->     UserID INT,
    ->     ServiceID INT,
    ->     Date DATE,
    ->     Price DECIMAL(10,2),
    ->     Status ENUM('Booked', 'Cancelled')
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Vehicles (
    ->     VehicleID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Type ENUM('Car', 'Bus', 'Bike'),
    ->     LicenseNumber VARCHAR(20) UNIQUE,
    ->     Capacity INT,
    ->     OwnerID INT
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE TrafficMonitoring (
    ->     TrafficID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Location VARCHAR(100),
    ->     CongestionLevel ENUM('Low', 'Medium', 'High'),
    ->     Timestamp DATETIME
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE ParkingLots (
    ->     ParkingLotID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Location VARCHAR(100),
    ->     Capacity INT,
    ->     Availability INT,
    ->     Charges DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> CREATE TABLE Bookings (
    ->     BookingID INT PRIMARY KEY AUTO_INCREMENT,
    ->     UserID INT,
    ->     ParkingLotID INT,
    ->     VehicleID INT,
    ->     StartTime DATETIME,
    ->     EndTime DATETIME,
    ->     Amount DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Payments (
    ->     PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    ->     BookingID INT,
    ->     Amount DECIMAL(10,2),
    ->     PaymentMethod ENUM('Cash', 'Credit Card', 'UPI', 'Net Banking'),
    ->     Status ENUM('Completed', 'Pending', 'Failed'),
    ->     Date DATE
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> CREATE TABLE Feedback (
    ->     FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    ->     UserID INT,
    ->     ServiceID INT,
    ->     Rating INT CHECK (Rating BETWEEN 1 AND 5),
    ->     Comments TEXT,
    ->     Date DATE
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Promotions (
    ->     PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Code VARCHAR(20) UNIQUE,
    ->     Discount DECIMAL(5,2),
    ->     ExpiryDate DATE,
    ->     ApplicableServices TEXT
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE Notifications (
    ->     NotificationID INT PRIMARY KEY AUTO_INCREMENT,
    ->     UserID INT,
    ->     Content TEXT,
    ->     Timestamp DATETIME,
    ->     ReadStatus BOOLEAN
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Administrators (
    ->     AdminID INT PRIMARY KEY AUTO_INCREMENT,
    ->     Name VARCHAR(100),
    ->     Role ENUM('Cashier', 'Ticket-distributor'),
    ->     ContactInformation VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> INSERT INTO Users (Name, Email, Phone, UserType, Preferences) VALUES
    -> ('Rajesh Kumar', 'rajesh.kumar@example.com', '9876543210', 'Commuter', 'Prefers AC Buses'),
    -> ('Sneha Verma', 'sneha.verma@example.com', '9823456789', 'Driver', 'N/A'),
    -> ('Amit Shah', 'amit.shah@example.com', '9765432109', 'Administrator', 'Manages Metro Services');
Query OK, 3 rows affected (0.00 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Users;
+--------+--------------+--------------------------+------------+---------------+------------------------+
| UserID | Name         | Email                    | Phone      | UserType      | Preferences            |
+--------+--------------+--------------------------+------------+---------------+------------------------+
|      1 | Rajesh Kumar | rajesh.kumar@example.com | 9876543210 | Commuter      | Prefers AC Buses       |
|      2 | Sneha Verma  | sneha.verma@example.com  | 9823456789 | Driver        | N/A                    |
|      3 | Amit Shah    | amit.shah@example.com    | 9765432109 | Administrator | Manages Metro Services |
+--------+--------------+--------------------------+------------+---------------+------------------------+
3 rows in set (0.00 sec)

mysql> SELECT Name, Email FROM Users;
+--------------+--------------------------+
| Name         | Email                    |
+--------------+--------------------------+
| Rajesh Kumar | rajesh.kumar@example.com |
| Sneha Verma  | sneha.verma@example.com  |
| Amit Shah    | amit.shah@example.com    |
+--------------+--------------------------+
3 rows in set (0.00 sec)

mysql> SELECT DISTINCT UserType FROM Users;
+---------------+
| UserType      |
+---------------+
| Commuter      |
| Driver        |
| Administrator |
+---------------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM Users WHERE UserType = 'Commuter';
+--------+--------------+--------------------------+------------+----------+------------------+
| UserID | Name         | Email                    | Phone      | UserType | Preferences      |
+--------+--------------+--------------------------+------------+----------+------------------+
|      1 | Rajesh Kumar | rajesh.kumar@example.com | 9876543210 | Commuter | Prefers AC Buses |
+--------+--------------+--------------------------+------------+----------+------------------+
1 row in set (0.00 sec)

mysql> SELECT * FROM Users ORDER BY Name ASC;
+--------+--------------+--------------------------+------------+---------------+------------------------+
| UserID | Name         | Email                    | Phone      | UserType      | Preferences            |
+--------+--------------+--------------------------+------------+---------------+------------------------+
|      3 | Amit Shah    | amit.shah@example.com    | 9765432109 | Administrator | Manages Metro Services |
|      1 | Rajesh Kumar | rajesh.kumar@example.com | 9876543210 | Commuter      | Prefers AC Buses       |
|      2 | Sneha Verma  | sneha.verma@example.com  | 9823456789 | Driver        | N/A                    |
+--------+--------------+--------------------------+------------+---------------+------------------------+
3 rows in set (0.00 sec)

mysql> SELECT COUNT(*) FROM Users;
+----------+
| COUNT(*) |
+----------+
|        3 |
+----------+
1 row in set (0.00 sec)

mysql> UPDATE Users SET Phone = '9900990099' WHERE Name = 'Rajesh Kumar';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> DELETE FROM Users WHERE Name = 'Amit Shah';
Query OK, 1 row affected (0.00 sec)

mysql> ALTER TABLE Users ADD COLUMN Gender ENUM('Male', 'Female', 'Other');
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE Users MODIFY COLUMN Phone VARCHAR(20);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> DESCRIBE Users;
+-------------+-------------------------------------------+------+-----+---------+----------------+
| Field       | Type                                      | Null | Key | Default | Extra          |
+-------------+-------------------------------------------+------+-----+---------+----------------+
| UserID      | int                                       | NO   | PRI | NULL    | auto_increment |
| Name        | varchar(100)                              | YES  |     | NULL    |                |
| Email       | varchar(100)                              | YES  | UNI | NULL    |                |
| Phone       | varchar(20)                               | YES  |     | NULL    |                |
| UserType    | enum('Commuter','Driver','Administrator') | YES  |     | NULL    |                |
| Preferences | text                                      | YES  |     | NULL    |                |
| Gender      | enum('Male','Female','Other')             | YES  |     | NULL    |                |
+-------------+-------------------------------------------+------+-----+---------+----------------+
7 rows in set (0.00 sec)

mysql> TRUNCATE TABLE Users;
Query OK, 0 rows affected (0.03 sec)

mysql> DROP TABLE Users;
Query OK, 0 rows affected (0.01 sec)
