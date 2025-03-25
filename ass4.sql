Microsoft Windows [Version 10.0.26100.3476]
(c) Microsoft Corporation. All rights reserved.

C:\Users\lokha>mysql -u root -p
Enter password: ***********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.41 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+-------------------------------+
| Database                      |
+-------------------------------+
| ass6_ecommercedb              |
| bankdb                        |
| information_schema            |
| intro_sql                     |
| mysql                         |
| performance_schema            |
| smart_urban_transport_service |
| studentattendancedb           |
| studentmanagement             |
| sys                           |
+-------------------------------+
10 rows in set (0.00 sec)

mysql> CREATE DATABASE customers;
Query OK, 1 row affected (0.01 sec)

mysql> USE customers;
Database changed
mysql> CREATE TABLE Customers (
    ->     customer_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     email VARCHAR(100),
    ->     city VARCHAR(50),
    ->     age INT
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE Orders (
    ->     order_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_date DATE,
    ->     total_amount DECIMAL(10,2),
    ->     status VARCHAR(20),
    ->     FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE Products (
    ->     product_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     category VARCHAR(50),
    ->     price DECIMAL(10,2),
    ->     stock INT
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE Order_Items (
    ->     order_item_id INT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     subtotal DECIMAL(10,2),
    ->     FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    ->     FOREIGN KEY (product_id) REFERENCES Products(product_id)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO Customers (customer_id, name, email, city, age) VALUES
    -> (1, 'Amit', 'amit.sharma@gmail.com', 'New York', 32),
    -> (2, 'Priya', 'priya.iyer@yahoo.com', 'Los Angeles', 28),
    -> (3, 'Rahul', 'rahul.patel@gmail.com', 'Chicago', 35),
    -> (4, 'Neha', 'neha.verma@hotmail.com', 'San Francisco', 30),
    -> (5, 'Rohan', 'rohan.desai@gmail.com', 'Miami', 27),
    -> (6, 'Sonia', 'sonia.kapoor@gmail.com', 'New York', 40),
    -> (7, 'Ravi', 'ravi.mehta@gmail.com', 'Los Angeles', 29),
    -> (8, 'Ankit', 'ankit.bose@yahoo.com', 'Chicago', 36);
Query OK, 8 rows affected (0.02 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Orders (order_id, customer_id, order_date, total_amount, status) VALUES
    -> (1, 1, '2024-02-20', 1000.00, 'Shipped'),
    -> (2, 2, '2024-02-18', 2300.50, 'Delivered'),
    -> (3, 3, '2024-02-19', 1200.75, 'Pending'),
    -> (4, 4, '2024-02-21', 4500.00, 'Completed'),
    -> (5, 5, '2024-02-22', 500.00, 'Shipped'),
    -> (6, 6, '2024-03-05', 300.00, 'Pending'),
    -> (7, 7, '2024-03-07', 700.00, 'Completed'),
    -> (8, 8, '2024-01-10', 200.00, 'Completed');
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Products (product_id, name, category, price, stock) VALUES
    -> (1, 'Laptop', 'Electronics', 550.00, 10),
    -> (2, 'Smartphone', 'Electronics', 200.00, 20),
    -> (3, 'Tablet', 'Electronics', 150.00, 15),
    -> (4, 'Headphones', 'Accessories', 40.00, 25),
    -> (5, 'Smartwatch', 'Accessories', 120.00, 18),
    -> (6, 'Mouse', 'Electronics', 30.00, 0),
    -> (7, 'Keyboard', 'Accessories', 80.00, 4),
    -> (8, 'T-Shirt', 'Clothing', 25.00, 50);
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal) VALUES
    -> (1, 1, 1, 1, 550.00),
    -> (2, 2, 2, 2, 400.00),
    -> (3, 3, 3, 1, 150.00),
    -> (4, 4, 4, 3, 120.00),
    -> (5, 5, 5, 2, 240.00),
    -> (6, 6, 6, 1, 30.00),
    -> (7, 7, 7, 2, 160.00),
    -> (8, 8, 8, 5, 125.00);
Query OK, 8 rows affected (0.01 sec)
Records: 8  Duplicates: 0  Warnings: 0

mysql>
mysql> SELECT * FROM Customers;
+-------------+-------+------------------------+---------------+------+
| customer_id | name  | email                  | city          | age  |
+-------------+-------+------------------------+---------------+------+
|           1 | Amit  | amit.sharma@gmail.com  | New York      |   32 |
|           2 | Priya | priya.iyer@yahoo.com   | Los Angeles   |   28 |
|           3 | Rahul | rahul.patel@gmail.com  | Chicago       |   35 |
|           4 | Neha  | neha.verma@hotmail.com | San Francisco |   30 |
|           5 | Rohan | rohan.desai@gmail.com  | Miami         |   27 |
|           6 | Sonia | sonia.kapoor@gmail.com | New York      |   40 |
|           7 | Ravi  | ravi.mehta@gmail.com   | Los Angeles   |   29 |
|           8 | Ankit | ankit.bose@yahoo.com   | Chicago       |   36 |
+-------------+-------+------------------------+---------------+------+
8 rows in set (0.00 sec)

mysql> SELECT * FROM Orders;
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|        1 |           1 | 2024-02-20 |      1000.00 | Shipped   |
|        2 |           2 | 2024-02-18 |      2300.50 | Delivered |
|        3 |           3 | 2024-02-19 |      1200.75 | Pending   |
|        4 |           4 | 2024-02-21 |      4500.00 | Completed |
|        5 |           5 | 2024-02-22 |       500.00 | Shipped   |
|        6 |           6 | 2024-03-05 |       300.00 | Pending   |
|        7 |           7 | 2024-03-07 |       700.00 | Completed |
|        8 |           8 | 2024-01-10 |       200.00 | Completed |
+----------+-------------+------------+--------------+-----------+
8 rows in set (0.00 sec)

mysql> SELECT * FROM Products;
+------------+------------+-------------+--------+-------+
| product_id | name       | category    | price  | stock |
+------------+------------+-------------+--------+-------+
|          1 | Laptop     | Electronics | 550.00 |    10 |
|          2 | Smartphone | Electronics | 200.00 |    20 |
|          3 | Tablet     | Electronics | 150.00 |    15 |
|          4 | Headphones | Accessories |  40.00 |    25 |
|          5 | Smartwatch | Accessories | 120.00 |    18 |
|          6 | Mouse      | Electronics |  30.00 |     0 |
|          7 | Keyboard   | Accessories |  80.00 |     4 |
|          8 | T-Shirt    | Clothing    |  25.00 |    50 |
+------------+------------+-------------+--------+-------+
8 rows in set (0.00 sec)

mysql> SELECT * FROM Order_Items;
+---------------+----------+------------+----------+----------+
| order_item_id | order_id | product_id | quantity | subtotal |
+---------------+----------+------------+----------+----------+
|             1 |        1 |          1 |        1 |   550.00 |
|             2 |        2 |          2 |        2 |   400.00 |
|             3 |        3 |          3 |        1 |   150.00 |
|             4 |        4 |          4 |        3 |   120.00 |
|             5 |        5 |          5 |        2 |   240.00 |
|             6 |        6 |          6 |        1 |    30.00 |
|             7 |        7 |          7 |        2 |   160.00 |
|             8 |        8 |          8 |        5 |   125.00 |
+---------------+----------+------------+----------+----------+
8 rows in set (0.00 sec)

mysql> -- 1. Find the total amount spent by customer ID 3 (sum of all their orders).
mysql> SELECT SUM(total_amount) AS total_spent
    -> FROM Orders
    -> WHERE customer_id = 3;
+-------------+
| total_spent |
+-------------+
|     1200.75 |
+-------------+
1 row in set (0.01 sec)

mysql> -- 2. Find the total revenue generated from all orders.
mysql> SELECT SUM(total_amount) AS total_revenue_generated
    -> FROM orders;
+-------------------------+
| total_revenue_generated |
+-------------------------+
|                10701.25 |
+-------------------------+
1 row in set (0.00 sec)

mysql> -- 3. Calculate the stock value (price × stock) for each product.
mysql> SELECT product_id, name ,(price * stock) AS stock_value
    -> FROM products;
+------------+------------+-------------+
| product_id | name       | stock_value |
+------------+------------+-------------+
|          1 | Laptop     |     5500.00 |
|          2 | Smartphone |     4000.00 |
|          3 | Tablet     |     2250.00 |
|          4 | Headphones |     1000.00 |
|          5 | Smartwatch |     2160.00 |
|          6 | Mouse      |        0.00 |
|          7 | Keyboard   |      320.00 |
|          8 | T-Shirt    |     1250.00 |
+------------+------------+-------------+
8 rows in set (0.01 sec)

mysql> -- 4. Retrieve customers who are above 30 years old and live in "New York".
mysql> SELECT customer_id, name, city, age
    -> FROM customers
    -> WHERE age > 30 AND city = "New York";
+-------------+-------+----------+------+
| customer_id | name  | city     | age  |
+-------------+-------+----------+------+
|           1 | Amit  | New York |   32 |
|           6 | Sonia | New York |   40 |
+-------------+-------+----------+------+
2 rows in set (0.00 sec)

mysql> -- 5. Find customers who either live in "Los Angeles" or have placed an order worth more than $500.
mysql> SELECT DISTINCT c.customer_id, c.name, c.city
    -> FROM customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id
    -> WHERE c.city = "Los Angeles" OR o.total_amount>500;
+-------------+-------+---------------+
| customer_id | name  | city          |
+-------------+-------+---------------+
|           1 | Amit  | New York      |
|           2 | Priya | Los Angeles   |
|           3 | Rahul | Chicago       |
|           4 | Neha  | San Francisco |
|           7 | Ravi  | Los Angeles   |
+-------------+-------+---------------+
5 rows in set (0.01 sec)

mysql> -- 6. List products that are in stock but cost less than $50.
mysql> SELECT product_id, name, price, stock
    -> FROM Products
    -> WHERE stock > 0 AND price < 50;
+------------+------------+-------+-------+
| product_id | name       | price | stock |
+------------+------------+-------+-------+
|          4 | Headphones | 40.00 |    25 |
|          8 | T-Shirt    | 25.00 |    50 |
+------------+------------+-------+-------+
2 rows in set (0.00 sec)

mysql>
mysql> -- 7. Find products that have less than 5 items in stock.
mysql> SELECT product_id, name, price, stock
    -> FROM Products
    -> WHERE stock < 5;
+------------+----------+-------+-------+
| product_id | name     | price | stock |
+------------+----------+-------+-------+
|          6 | Mouse    | 30.00 |     0 |
|          7 | Keyboard | 80.00 |     4 |
+------------+----------+-------+-------+
2 rows in set (0.00 sec)

mysql> -- 8. Find orders that are not completed (status is not 'Completed').
mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE status <> 'Completed';
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|        1 |           1 | 2024-02-20 |      1000.00 | Shipped   |
|        2 |           2 | 2024-02-18 |      2300.50 | Delivered |
|        3 |           3 | 2024-02-19 |      1200.75 | Pending   |
|        5 |           5 | 2024-02-22 |       500.00 | Shipped   |
|        6 |           6 | 2024-03-05 |       300.00 | Pending   |
+----------+-------------+------------+--------------+-----------+
5 rows in set (0.00 sec)

mysql> -- 9. Find products that are out of stock or belong to the "Electronics" category.
mysql> SELECT product_id, name, category, stock
    -> FROM Products
    -> WHERE stock = 0 OR category = 'Electronics';
+------------+------------+-------------+-------+
| product_id | name       | category    | stock |
+------------+------------+-------------+-------+
|          1 | Laptop     | Electronics |    10 |
|          2 | Smartphone | Electronics |    20 |
|          3 | Tablet     | Electronics |    15 |
|          6 | Mouse      | Electronics |     0 |
+------------+------------+-------------+-------+
4 rows in set (0.00 sec)

mysql>
mysql> -- 10. List all email addresses that belong to Gmail.
mysql> SELECT name, email
    -> FROM Customers
    -> WHERE email LIKE '%@gmail.com';
+-------+------------------------+
| name  | email                  |
+-------+------------------------+
| Amit  | amit.sharma@gmail.com  |
| Rahul | rahul.patel@gmail.com  |
| Rohan | rohan.desai@gmail.com  |
| Sonia | sonia.kapoor@gmail.com |
| Ravi  | ravi.mehta@gmail.com   |
+-------+------------------------+
5 rows in set (0.00 sec)

mysql> -- 11. Find product names containing the word "Phone".
mysql> SELECT product_id, name, category
    -> FROM Products
    -> WHERE name LIKE '%Phone%';
+------------+------------+-------------+
| product_id | name       | category    |
+------------+------------+-------------+
|          2 | Smartphone | Electronics |
|          4 | Headphones | Accessories |
+------------+------------+-------------+
2 rows in set (0.00 sec)

mysql> -- 12. Find customers whose names have exactly 5 characters.
mysql> SELECT customer_id, name
    -> FROM Customers
    -> WHERE LENGTH(name) = 5;
+-------------+-------+
| customer_id | name  |
+-------------+-------+
|           2 | Priya |
|           3 | Rahul |
|           5 | Rohan |
|           6 | Sonia |
|           8 | Ankit |
+-------------+-------+
5 rows in set (0.00 sec)

mysql> -- 13. Find products that have "Laptop" or "Tablet" in their name.
mysql> SELECT product_id, name, category
    -> FROM Products
    -> WHERE name LIKE '%Laptop%' OR name LIKE '%Tablet%';
+------------+--------+-------------+
| product_id | name   | category    |
+------------+--------+-------------+
|          1 | Laptop | Electronics |
|          3 | Tablet | Electronics |
+------------+--------+-------------+
2 rows in set (0.00 sec)

mysql> -- 14. Retrieve orders placed in the year 2024.
mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE YEAR(order_date) = 2024;
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|        1 |           1 | 2024-02-20 |      1000.00 | Shipped   |
|        2 |           2 | 2024-02-18 |      2300.50 | Delivered |
|        3 |           3 | 2024-02-19 |      1200.75 | Pending   |
|        4 |           4 | 2024-02-21 |      4500.00 | Completed |
|        5 |           5 | 2024-02-22 |       500.00 | Shipped   |
|        6 |           6 | 2024-03-05 |       300.00 | Pending   |
|        7 |           7 | 2024-03-07 |       700.00 | Completed |
|        8 |           8 | 2024-01-10 |       200.00 | Completed |
+----------+-------------+------------+--------------+-----------+
8 rows in set (0.00 sec)

mysql> -- 15. Find customers who live in "New York", "Los Angeles", or "Chicago".
mysql> SELECT customer_id, name, city
    -> FROM Customers
    -> WHERE city IN ('New York', 'Los Angeles', 'Chicago');
+-------------+-------+-------------+
| customer_id | name  | city        |
+-------------+-------+-------------+
|           1 | Amit  | New York    |
|           2 | Priya | Los Angeles |
|           3 | Rahul | Chicago     |
|           6 | Sonia | New York    |
|           7 | Ravi  | Los Angeles |
|           8 | Ankit | Chicago     |
+-------------+-------+-------------+
6 rows in set (0.00 sec)

mysql> -- 16. List products that do not belong to the 'Electronics' or 'Clothing' categories.
mysql> SELECT product_id, name, category
    -> FROM Products
    -> WHERE category NOT IN ('Electronics', 'Clothing');
+------------+------------+-------------+
| product_id | name       | category    |
+------------+------------+-------------+
|          4 | Headphones | Accessories |
|          5 | Smartwatch | Accessories |
|          7 | Keyboard   | Accessories |
+------------+------------+-------------+
3 rows in set (0.00 sec)

mysql>
mysql> -- 17. Find orders placed by customers with IDs 1, 3, or 5.
mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE customer_id IN (1, 3, 5);
+----------+-------------+------------+--------------+---------+
| order_id | customer_id | order_date | total_amount | status  |
+----------+-------------+------------+--------------+---------+
|        1 |           1 | 2024-02-20 |      1000.00 | Shipped |
|        3 |           3 | 2024-02-19 |      1200.75 | Pending |
|        5 |           5 | 2024-02-22 |       500.00 | Shipped |
+----------+-------------+------------+--------------+---------+
3 rows in set (0.00 sec)

mysql> -- 18. Find customers who have not placed any orders.
mysql> SELECT c.customer_id, c.name
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id
    -> WHERE o.customer_id IS NULL;
Empty set (0.00 sec)

mysql> -- 19. Show all orders placed in the last 30 days.
mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE order_date >= CURDATE() - INTERVAL 30 DAY;
Empty set (0.00 sec)

mysql> -- 20. Find orders where the total amount is an exact multiple of 100.
mysql> SELECT order_id, customer_id, order_date, total_amount, status
    -> FROM Orders
    -> WHERE total_amount % 100 = 0;
+----------+-------------+------------+--------------+-----------+
| order_id | customer_id | order_date | total_amount | status    |
+----------+-------------+------------+--------------+-----------+
|        1 |           1 | 2024-02-20 |      1000.00 | Shipped   |
|        4 |           4 | 2024-02-21 |      4500.00 | Completed |
|        5 |           5 | 2024-02-22 |       500.00 | Shipped   |
|        6 |           6 | 2024-03-05 |       300.00 | Pending   |
|        7 |           7 | 2024-03-07 |       700.00 | Completed |
|        8 |           8 | 2024-01-10 |       200.00 | Completed |
+----------+-------------+------------+--------------+-----------+
6 rows in set (0.00 sec)
