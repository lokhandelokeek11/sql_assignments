Microsoft Windows [Version 10.0.26100.3476]
(c) Microsoft Corporation. All rights reserved.

C:\Users\lokha>mysql -u root -p
Enter password: ***********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 20
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
| customers                     |
| information_schema            |
| intro_sql                     |
| mysql                         |
| performance_schema            |
| smart_urban_transport_service |
| studentattendancedb           |
| studentmanagement             |
| sys                           |
+-------------------------------+
11 rows in set (0.00 sec)

mysql> CREATE DATABASE ass6;
Query OK, 1 row affected (0.00 sec)

mysql> USE ass6;
Database changed
mysql> CREATE TABLE Customers (
    ->     customer_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     email VARCHAR(50),
    ->     city VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE Orders (
    ->     order_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     order_date DATE,
    ->     total_amount DECIMAL(10,2),
    ->     FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Products (
    ->     product_id INT PRIMARY KEY,
    ->     product_name VARCHAR(50),
    ->     category VARCHAR(50),
    ->     price DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Order_Items (
    ->     order_item_id INT PRIMARY KEY,
    ->     order_id INT,
    ->     product_id INT,
    ->     quantity INT,
    ->     subtotal DECIMAL(10,2),
    ->     FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    ->     FOREIGN KEY (product_id) REFERENCES Products(product_id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TABLE Sellers (
    ->     seller_id INT PRIMARY KEY,
    ->     seller_name VARCHAR(30),
    ->     city VARCHAR(20)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> CREATE TABLE Product_Sellers (
    ->     seller_id INT,
    ->     product_id INT,
    ->     PRIMARY KEY (seller_id, product_id),
    ->     FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id),
    ->     FOREIGN KEY (product_id) REFERENCES Products(product_id)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO Customers (customer_id, name, email, city) VALUES
    -> (1, 'RAHUL SHARMA', 'rahul.sharma@gmail.com', 'Delhi'),
    -> (2, 'PRIYA SINGH', 'priya.singh@yahoo.com', 'Kolkata'),
    -> (3, 'VIKAS VERMA', 'vikas.verma@hotmail.com', 'Chennai'),
    -> (4, 'ANUSHKA PATEL', 'anushka.patel@gmail.com', 'Bangalore');
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Products (product_id, product_name, category, price) VALUES
    -> (1, 'Tablet', 'Electronics', 600.00),
    -> (2, 'Wireless Earbuds', 'Accessories', 120.00),
    -> (3, 'Backpack', 'Apparel', 45.00),
    -> (4, 'Wrist Watch', 'Fashion', 150.00),
    -> (5, 'Sunglasses', 'Fashion', 75.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Sellers (seller_id, seller_name, city) VALUES
    -> (1, 'SellerA', 'Ahmedabad'),
    -> (2, 'SellerB', 'Jaipur'),
    -> (3, 'SellerC', 'Lucknow'),
    -> (4, 'SellerD', 'Indore'),
    -> (5, 'SellerE', 'Bhubaneswar');
Query OK, 5 rows affected (0.00 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql>
mysql> INSERT INTO Orders (order_id, customer_id, order_date, total_amount) VALUES
    -> (1, 1, '2025-03-15', 720.00),
    -> (2, 2, '2025-03-16', 165.00),
    -> (3, 3, '2025-03-17', 195.00),
    -> (4, 4, '2025-03-18', 300.00);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Order_Items (order_item_id, order_id, product_id, quantity, subtotal) VALUES
    -> (1, 1, 1, 1, 600.00),
    -> (2, 1, 2, 1, 120.00),
    -> (3, 2, 3, 1, 45.00),
    -> (4, 2, 5, 1, 75.00),
    -> (5, 3, 4, 1, 150.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> -- 1. Retrieve all customers along with their corresponding orders (including customers who haven't ordered).
mysql> SELECT c.customer_id, c.name, c.email, c.city, o.order_id, o.order_date, o.total_amount
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id;
+-------------+---------------+-------------------------+-----------+----------+------------+--------------+
| customer_id | name          | email                   | city      | order_id | order_date | total_amount |
+-------------+---------------+-------------------------+-----------+----------+------------+--------------+
|           1 | RAHUL SHARMA  | rahul.sharma@gmail.com  | Delhi     |        1 | 2025-03-15 |       720.00 |
|           2 | PRIYA SINGH   | priya.singh@yahoo.com   | Kolkata   |        2 | 2025-03-16 |       165.00 |
|           3 | VIKAS VERMA   | vikas.verma@hotmail.com | Chennai   |        3 | 2025-03-17 |       195.00 |
|           4 | ANUSHKA PATEL | anushka.patel@gmail.com | Bangalore |        4 | 2025-03-18 |       300.00 |
+-------------+---------------+-------------------------+-----------+----------+------------+--------------+
4 rows in set (0.00 sec)

mysql> -- 2. List all orders along with the product names and their quantities.
mysql> SELECT o.order_id, p.product_name, oi.quantity
    -> FROM Order_Items oi
    -> JOIN Products p ON oi.product_id = p.product_id
    -> JOIN Orders o ON oi.order_id = o.order_id;
+----------+------------------+----------+
| order_id | product_name     | quantity |
+----------+------------------+----------+
|        1 | Tablet           |        1 |
|        1 | Wireless Earbuds |        1 |
|        2 | Backpack         |        1 |
|        2 | Sunglasses       |        1 |
|        3 | Wrist Watch      |        1 |
+----------+------------------+----------+
5 rows in set (0.00 sec)

mysql>
mysql> -- 3. Find the total number of orders placed by each customer.
mysql> SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id, c.name;
+-------------+---------------+--------------+
| customer_id | name          | total_orders |
+-------------+---------------+--------------+
|           1 | RAHUL SHARMA  |            1 |
|           2 | PRIYA SINGH   |            1 |
|           3 | VIKAS VERMA   |            1 |
|           4 | ANUSHKA PATEL |            1 |
+-------------+---------------+--------------+
4 rows in set (0.00 sec)

mysql> -- 4. Find the total number of products available in each category.
mysql> SELECT category, COUNT(product_id) AS total_products
    -> FROM Products
    -> GROUP BY category;
+-------------+----------------+
| category    | total_products |
+-------------+----------------+
| Electronics |              1 |
| Accessories |              1 |
| Apparel     |              1 |
| Fashion     |              2 |
+-------------+----------------+
4 rows in set (0.00 sec)

mysql> -- 5. Retrieve the order details, including customer name and total amount, for all orders placed in the last 30 days.
mysql> SELECT o.order_id, c.name, o.total_amount, o.order_date
    -> FROM Orders o
    -> JOIN Customers c ON o.customer_id = c.customer_id
    -> WHERE o.order_date >= CURDATE() - INTERVAL 30 DAY;
+----------+---------------+--------------+------------+
| order_id | name          | total_amount | order_date |
+----------+---------------+--------------+------------+
|        1 | RAHUL SHARMA  |       720.00 | 2025-03-15 |
|        2 | PRIYA SINGH   |       165.00 | 2025-03-16 |
|        3 | VIKAS VERMA   |       195.00 | 2025-03-17 |
|        4 | ANUSHKA PATEL |       300.00 | 2025-03-18 |
+----------+---------------+--------------+------------+
4 rows in set (0.00 sec)

mysql> -- 6. Retrieve the names of sellers who sell a specific product (e.g., "Laptop").
mysql> SELECT DISTINCT s.seller_name
    -> FROM Sellers s
    -> JOIN Product_Sellers ps ON s.seller_id = ps.seller_id
    -> JOIN Products p ON ps.product_id = p.product_id
    -> WHERE p.product_name = 'Laptop';
Empty set (0.00 sec)

mysql> -- 7. Show all customers who have never placed an order.
mysql> SELECT c.customer_id, c.name, c.email, c.city
    -> FROM Customers c
    -> LEFT JOIN Orders o ON c.customer_id = o.customer_id
    -> WHERE o.order_id IS NULL;
Empty set (0.00 sec)

mysql> -- 8. Retrieve details of orders where the total amount is greater than the average order total.
mysql> SELECT order_id, customer_id, order_date, total_amount
    -> FROM Orders
    -> WHERE total_amount > (SELECT AVG(total_amount) FROM Orders);
+----------+-------------+------------+--------------+
| order_id | customer_id | order_date | total_amount |
+----------+-------------+------------+--------------+
|        1 |           1 | 2025-03-15 |       720.00 |
+----------+-------------+------------+--------------+
1 row in set (0.00 sec)

mysql> -- 9. Find customers who have placed at least two orders.
mysql> SELECT c.customer_id, c.name
    -> FROM Customers c
    -> JOIN Orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id, c.name
    -> HAVING COUNT(o.order_id) >= 2;
Empty set (0.00 sec)

mysql> -- 10. Find the top 3 most ordered products based on quantity sold.
mysql> SELECT p.product_name, SUM(oi.quantity) AS total_quantity
    -> FROM Order_Items oi
    -> JOIN Products p ON oi.product_id = p.product_id
    -> GROUP BY p.product_name
    -> ORDER BY total_quantity DESC
    -> LIMIT 3;
+------------------+----------------+
| product_name     | total_quantity |
+------------------+----------------+
| Tablet           |              1 |
| Wireless Earbuds |              1 |
| Backpack         |              1 |
+------------------+----------------+
3 rows in set (0.00 sec)

mysql> -- 11. Display the product names that are sold by multiple sellers.
mysql> SELECT p.product_name
    -> FROM Products p
    -> JOIN Product_Sellers ps ON p.product_id = ps.product_id
    -> GROUP BY p.product_name
    -> HAVING COUNT(DISTINCT ps.seller_id) > 1;
Empty set (0.00 sec)

mysql> -- 12. Retrieve sellers who have never sold any product.
mysql> SELECT s.seller_id, s.seller_name, s.city
    -> FROM Sellers s
    -> LEFT JOIN Product_Sellers ps ON s.seller_id = ps.seller_id
    -> WHERE ps.product_id IS NULL;
+-----------+-------------+-------------+
| seller_id | seller_name | city        |
+-----------+-------------+-------------+
|         1 | SellerA     | Ahmedabad   |
|         2 | SellerB     | Jaipur      |
|         3 | SellerC     | Lucknow     |
|         4 | SellerD     | Indore      |
|         5 | SellerE     | Bhubaneswar |
+-----------+-------------+-------------+
5 rows in set (0.00 sec)

mysql> -- 13. Find all products that have never been ordered.
mysql> SELECT p.product_id, p.product_name
    -> FROM Products p
    -> LEFT JOIN Order_Items oi ON p.product_id = oi.product_id
    -> WHERE oi.product_id IS NULL;
Empty set (0.00 sec)

mysql> -- 14. Retrieve the names of customers who have placed the highest number of orders.
mysql> SELECT c.name
    -> FROM Customers c
    -> JOIN Orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id, c.name
    -> ORDER BY COUNT(o.order_id) DESC
    -> LIMIT 1;
+--------------+
| name         |
+--------------+
| RAHUL SHARMA |
+--------------+
1 row in set (0.00 sec)

mysql> -- 15. Find all customers who have ordered more than 5 different products.
mysql> SELECT o.customer_id, c.name
    -> FROM Orders o
    -> JOIN Order_Items oi ON o.order_id = oi.order_id
    -> JOIN Customers c ON o.customer_id = c.customer_id
    -> GROUP BY o.customer_id, c.name
    -> HAVING COUNT(DISTINCT oi.product_id) > 5;
Empty set (0.00 sec)

mysql> ^C
mysql> -- 16. Find products that are sold by at least two different sellers but have never been ordered.
mysql> SELECT p.product_id, p.product_name
    -> FROM Products p
    -> JOIN Product_Sellers ps ON p.product_id = ps.product_id
    -> GROUP BY p.product_id, p.product_name
    -> HAVING COUNT(DISTINCT ps.seller_id) > 1
    -> AND NOT EXISTS (
    ->     SELECT 1 FROM Order_Items oi WHERE oi.product_id = p.product_id
    -> );
Empty set (0.00 sec)

mysql> -- 17. Find the customer who has spent the most money overall.
mysql> SELECT c.customer_id, c.name, SUM(o.total_amount) AS total_spent
    -> FROM customers c
    -> JOIN orders o ON c.customer_id = o.customer_id
    -> GROUP BY c.customer_id, c.name
    -> ORDER BY total_spent DESC
    -> LIMIT 1;
+-------------+--------------+-------------+
| customer_id | name         | total_spent |
+-------------+--------------+-------------+
|           1 | RAHUL SHARMA |      720.00 |
+-------------+--------------+-------------+
1 row in set (0.00 sec)

mysql> -- 18. Find all customers who have either placed an order or live in the same city as a seller.
mysql> SELECT customer_id, name FROM customers WHERE customer_id IN (SELECT customer_id FROM orders)
    -> UNION
    -> SELECT customer_id, name FROM customers WHERE city IN (SELECT city FROM sellers);
+-------------+---------------+
| customer_id | name          |
+-------------+---------------+
|           1 | RAHUL SHARMA  |
|           2 | PRIYA SINGH   |
|           3 | VIKAS VERMA   |
|           4 | ANUSHKA PATEL |
+-------------+---------------+
4 rows in set (0.00 sec)

mysql> -- 19. Retrieve all products that are either in stock with at least one seller or have been ordered at least once.
mysql> SELECT product_id, product_name FROM Products WHERE product_id IN (SELECT product_id FROM Product_Sellers)
    -> UNION
    -> SELECT product_id, product_name FROM Products WHERE product_id IN (SELECT product_id FROM order_Items);
+------------+------------------+
| product_id | product_name     |
+------------+------------------+
|          1 | Tablet           |
|          2 | Wireless Earbuds |
|          3 | Backpack         |
|          4 | Wrist Watch      |
|          5 | Sunglasses       |
+------------+------------------+
5 rows in set (0.00 sec)

mysql> -- 22. Retrieve all customers who have placed at least one order in each year available in the database.
mysql> SELECT customer_id, name FROM customers
    -> WHERE customer_id IN (
    ->     SELECT customer_id FROM orders GROUP BY customer_id HAVING COUNT(DISTINCT EXTRACT(YEAR FROM order_date)) =
    ->     (SELECT COUNT(DISTINCT EXTRACT(YEAR FROM order_date)) FROM orders)
    -> );
+-------------+---------------+
| customer_id | name          |
+-------------+---------------+
|           1 | RAHUL SHARMA  |
|           2 | PRIYA SINGH   |
|           3 | VIKAS VERMA   |
|           4 | ANUSHKA PATEL |
+-------------+---------------+
4 rows in set (0.00 sec)

mysql>
