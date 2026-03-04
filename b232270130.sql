DROP DATABASE IF EXISTS join_lab_db;
CREATE DATABASE join_lab_db;
USE join_lab_db;
CREATE TABLE customers (
customer_id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(50),
city VARCHAR(50)
);
CREATE TABLE orders (
order_id INT PRIMARY KEY AUTO_INCREMENT,
customer_id INT,
order_date DATE,
FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES employees (employee_id)
);
INSERT INTO customers (name, city) VALUES
('Bat', 'Ulaanbaatar'),
('Sara', 'Darkhan'),
('Bold', 'Ulaanbaatar');

INSERT INTO orders (customer_id, order_date) VALUES
(1, '2026-01-01'),
(1, '2026-01-05'),
(2, '2026-02-01');

INSERT INTO products (product_name, price) VALUES
('Keyboard', 120000),
('Mouse', 80000),
('Monitor', 600000);

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 1, 1);

INSERT INTO employees (name, manager_id) VALUES
('Manager A', NULL),
('Employee B', 1),
('Employee C', 1);
##inner
select c.name, order_id
from customers c
inner join orders o on c.customer_id = o. customer_id;
##left
select c.name ,o.order_id
from customers c
left join orders o on c.customer_id = o.customer_id;
##zahialaggvi vichlvvlegch
SELECT c.name
FROM customers c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
##right join
select c.name, o.order_id
from customers c
right join orders o on c.customer_id = o.customer_id;
##full join enhbat
select  c.name, o.order_id
from customers c
left join orders o on c.customer_id = o.customer_id
union
select c.name, order_id
from customers c
right join orders o on c.customer_id = o.customer_id;
##join where
select *
from orders o 
left join
customers c on o.customer_id = c.customer_id
where c.city = 'Ulaanbaater';
##self join
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

SELECT c.name, p.product_name, oi.quantity
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;

SELECT c.name, p.product_name
FROM customers c
CROSS JOIN products p;

## daalgawar

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS table_a;
DROP TABLE IF EXISTS table_b;

CREATE TABLE table_a (
    id INT,
    name VARCHAR(50)
);

CREATE TABLE table_b (
    id INT,
    name VARCHAR(50)
);

INSERT INTO table_a VALUES
(1,'Bat'),
(2,'Bold'),
(3,'Sara');

INSERT INTO table_b VALUES
(3,'Sara'),
(4,'Nara');

SELECT name FROM table_a
UNION
SELECT name FROM table_b;

SELECT name FROM table_a
UNION ALL
SELECT name FROM table_b;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees VALUES
(1,'Bat',NULL),
(2,'Bold',1),
(3,'Sara',1);

SELECT e.name AS employee,
       m.name AS manager
FROM employees e
JOIN employees m
ON e.manager_id = m.emp_id;

SELECT e.name AS employee,
       m.name AS manager
FROM employees e
JOIN employees m
ON m.emp_id = e.manager_id;


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    qty INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


INSERT INTO customers VALUES
(1,'Bat'),
(2,'Sara');

INSERT INTO orders VALUES
(101,1),
(102,1),
(103,2);

INSERT INTO products VALUES
(1,'Mouse'),
(2,'Keyboard'),
(3,'Monitor');

INSERT INTO order_items VALUES
(1,101,1,2),
(2,101,2,1),
(3,102,3,1),
(4,103,1,1);

SELECT c.name, COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name;

SELECT o.order_id, p.product_name, oi.qty
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
ORDER BY o.order_id;

SELECT p.product_name, COUNT(DISTINCT oi.order_id) AS total_orders
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_name;

