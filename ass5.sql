mysql> SHOW DATABASES;
+-------------------------------+
| Database                      |
+-------------------------------+
| ass6_ecommercedb              |
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
10 rows in set (0.00 sec)

mysql> CREATE DATABASE BankDB;
Query OK, 1 row affected (0.01 sec)

mysql> USE BankDB;
Database changed
mysql> CREATE TABLE Customers (
    ->     customer_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     email VARCHAR(100),
    ->     city VARCHAR(50)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE Accounts (
    ->     account_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     branch VARCHAR(50),
    ->     account_type VARCHAR(50),
    ->     balance DECIMAL(10,2),
    ->     FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE Loans (
    ->     loan_id INT PRIMARY KEY,
    ->     customer_id INT,
    ->     loan_type VARCHAR(50),
    ->     loan_status VARCHAR(20),
    ->     FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> CREATE TABLE Transactions (
    ->     transaction_id INT PRIMARY KEY,
    ->     account_id INT,
    ->     transaction_date DATE,
    ->     transaction_type VARCHAR(50),
    ->     amount DECIMAL(10,2),
    ->     FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO Customers (customer_id, name, email, city) VALUES
    -> (1, 'Amit Sharma', 'amit.sharma@gmail.com', 'New York'),
    -> (2, 'Priya Iyer', 'priya.iyer@yahoo.com', 'Los Angeles'),
    -> (3, 'Rahul Patel', 'rahul.patel@gmail.com', 'Chicago'),
    -> (4, 'Neha Verma', 'neha.verma@hotmail.com', 'San Francisco'),
    -> (5, 'Rohan Desai', 'rohan.desai@gmail.com', 'Miami');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Accounts (account_id, customer_id, branch, account_type, balance) VALUES
    -> (1, 1, 'NY Main', 'Savings', 30000.00),
    -> (2, 2, 'LA Central', 'Checking', 20000.00),
    -> (3, 3, 'Chicago West', 'Savings', 60000.00),
    -> (4, 4, 'SF Downtown', 'Business', 70000.00),
    -> (5, 5, 'Miami East', 'Savings', 5000.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Loans (loan_id, customer_id, loan_type, loan_status) VALUES
    -> (1, 1, 'Home Loan', 'Approved'),
    -> (2, 2, 'Car Loan', 'Approved'),
    -> (3, 3, 'Personal Loan', 'Pending'),
    -> (4, 4, 'Business Loan', 'Approved'),
    -> (5, 5, 'Education Loan', 'Rejected');
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Transactions (transaction_id, account_id, transaction_date, transaction_type, amount) VALUES
    -> (1, 1, '2024-02-20', 'Deposit', 5000.00),
    -> (2, 2, '2024-02-18', 'Withdrawal', 3000.00),
    -> (3, 3, '2024-02-19', 'Deposit', 7000.00),
    -> (4, 4, '2024-02-21', 'Withdrawal', 10000.00),
    -> (5, 5, '2024-02-22', 'Deposit', 2000.00);
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> -- 1. Retrieve the total balance for each account type
mysql> SELECT account_type, SUM(balance) AS total_balance
    -> FROM Accounts
    -> GROUP BY account_type;
+--------------+---------------+
| account_type | total_balance |
+--------------+---------------+
| Savings      |      95000.00 |
| Checking     |      20000.00 |
| Business     |      70000.00 |
+--------------+---------------+
3 rows in set (0.00 sec)

mysql> -- 2. Count the number of accounts in each branch
mysql> SELECT branch, COUNT(*) AS total_accounts
    -> FROM Accounts
    -> GROUP BY branch;
+--------------+----------------+
| branch       | total_accounts |
+--------------+----------------+
| NY Main      |              1 |
| LA Central   |              1 |
| Chicago West |              1 |
| SF Downtown  |              1 |
| Miami East   |              1 |
+--------------+----------------+
5 rows in set (0.00 sec)

mysql> -- 3. Find the number of customers in each city
mysql> SELECT city, COUNT(*) AS total_customers
    -> FROM Customers
    -> GROUP BY city;
+---------------+-----------------+
| city          | total_customers |
+---------------+-----------------+
| New York      |               1 |
| Los Angeles   |               1 |
| Chicago       |               1 |
| San Francisco |               1 |
| Miami         |               1 |
+---------------+-----------------+
5 rows in set (0.00 sec)

mysql> -- 4. Show the number of loans approved per loan type
mysql> SELECT loan_type, COUNT(*) AS total_approved
    -> FROM Loans
    -> WHERE loan_status = 'Approved'
    -> GROUP BY loan_type;
+---------------+----------------+
| loan_type     | total_approved |
+---------------+----------------+
| Home Loan     |              1 |
| Car Loan      |              1 |
| Business Loan |              1 |
+---------------+----------------+
3 rows in set (0.00 sec)

mysql> -- 5. Find the total number of transactions for each transaction type
mysql> SELECT transaction_type, COUNT(*) AS total_transactions
    -> FROM Transactions
    -> GROUP BY transaction_type;
+------------------+--------------------+
| transaction_type | total_transactions |
+------------------+--------------------+
| Deposit          |                  3 |
| Withdrawal       |                  2 |
+------------------+--------------------+
2 rows in set (0.00 sec)

mysql> -- 6. Show the customers who do not have a loan
mysql> SELECT name FROM Customers
    -> WHERE customer_id NOT IN (SELECT customer_id FROM Loans);
Empty set (0.00 sec)

mysql> -- 7. Retrieve customers who have accounts in more than one branch
mysql> SELECT customer_id, COUNT(DISTINCT branch) AS branch_count
    -> FROM Accounts
    -> GROUP BY customer_id
    -> HAVING branch_count > 1;
Empty set (0.01 sec)

mysql> -- 8. Find all accounts that have not had any deposits in the last 3 months
mysql> SELECT account_id FROM Accounts
    -> WHERE account_id NOT IN (SELECT account_id FROM Transactions
    -> WHERE transaction_type = 'Deposit' AND transaction_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH));
+------------+
| account_id |
+------------+
|          1 |
|          2 |
|          3 |
|          4 |
|          5 |
+------------+
5 rows in set (0.00 sec)

mysql> -- 9. Display the account types where the total balance is below ₹25,000
mysql> SELECT account_type
    -> FROM Accounts
    -> GROUP BY account_type
    -> HAVING SUM(balance) < 25000;
+--------------+
| account_type |
+--------------+
| Checking     |
+--------------+
1 row in set (0.00 sec)

mysql> -- 10. Find the total balance per account type where the balance is above ₹50,000
mysql> SELECT account_type, SUM(balance) AS total_balance
    -> FROM Accounts
    -> GROUP BY account_type
    -> HAVING total_balance > 50000;
+--------------+---------------+
| account_type | total_balance |
+--------------+---------------+
| Savings      |      95000.00 |
| Business     |      70000.00 |
+--------------+---------------+
2 rows in set (0.00 sec)

mysql> -- 11. Retrieve the count of transactions made on dates where more than 5 transactions occurred
mysql> SELECT transaction_date, COUNT(*) AS transaction_count
    -> FROM Transactions
    -> GROUP BY transaction_date
    -> HAVING transaction_count > 5;
Empty set (0.00 sec)

mysql> -- 12. Find the top 3 transaction days with the highest total transaction amount
mysql> SELECT transaction_date, SUM(amount) AS total_amount
    -> FROM Transactions
    -> GROUP BY transaction_date
    -> ORDER BY total_amount DESC
    -> LIMIT 3;
+------------------+--------------+
| transaction_date | total_amount |
+------------------+--------------+
| 2024-02-21       |     10000.00 |
| 2024-02-19       |      7000.00 |
| 2024-02-20       |      5000.00 |
+------------------+--------------+
3 rows in set (0.00 sec)

mysql> -- 13.Find customers who have a loan but no account in the bank.
mysql> SELECT c.name
    -> FROM Customers c
    -> LEFT JOIN Accounts a ON c.customer_id = a.customer_id
    -> WHERE a.customer_id IS NULL
    -> AND c.customer_id IN (SELECT customer_id FROM Loans);
Empty set (0.00 sec)
