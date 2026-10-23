-- CREATE DATABASE pricepulse_db;
-- SHOW DATABASES;
USE pricepulse_db;
SHOW TABLES;

CREATE TABLE IF NOT EXISTS categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS sellers (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(100) NOT NULL,
    seller_city VARCHAR(100),
    seller_rating DECIMAL(3,2)
);


CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    city VARCHAR(100),
    registration_date DATE
);



USE pricepulse_db;

CREATE TABLE IF NOT EXISTS products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    seller_id INT NOT NULL,
    current_price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,

    FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    FOREIGN KEY (seller_id)
        REFERENCES sellers(seller_id)
);

-- DESCRIBE products;

USE pricepulse_db;

CREATE TABLE IF NOT EXISTS price_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT NOT NULL,
    recorded_price DECIMAL(10,2) NOT NULL,
    discount_percentage DECIMAL(5,2) DEFAULT 0.00,
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- DESCRIBE price_history;


USE pricepulse_db;

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(30) DEFAULT 'Placed',
    total_amount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- DESCRIBE orders;


USE pricepulse_db;

CREATE TABLE IF NOT EXISTS order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    purchase_price DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- DESCRIBE order_items;


USE pricepulse_db;

CREATE TABLE IF NOT EXISTS reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT NOT NULL,
    review_text VARCHAR(500),
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CHECK (rating BETWEEN 1 AND 5)
);

-- DESCRIBE reviews;

USE pricepulse_db;

INSERT INTO categories (category_name, description)
VALUES
('Electronics', 'Electronic gadgets and accessories'),
('Fashion', 'Clothing and fashion products'),
('Home Appliances', 'Appliances for home use'),
('Books', 'Educational and general books'),
('Beauty', 'Beauty and personal care products');
SELECT * FROM categories;

USE pricepulse_db;

INSERT INTO sellers (seller_name, seller_city, seller_rating)
VALUES
('Amazon', 'Bangalore', 4.50),
('Flipkart', 'Bangalore', 4.30),
('Reliance Digital', 'Hyderabad', 4.20),
('Myntra', 'Bangalore', 4.40),
('Croma', 'Chennai', 4.10);

SELECT * FROM sellers;


USE pricepulse_db;

INSERT INTO products
    (product_name, category_id, seller_id, current_price, stock_quantity)
VALUES
('Samsung Galaxy M35', 1, 1, 18999.00, 25),
('Apple iPhone 15', 1, 2, 52999.00, 15),
('Boat Airdopes 141', 1, 3, 1299.00, 50),
('Men Casual Shirt', 2, 4, 899.00, 40),
('Women Kurti', 2, 4, 1199.00, 30),
('LG Washing Machine', 3, 5, 24999.00, 10),
('Atomic Habits Book', 4, 1, 399.00, 60),
('Lakme Face Cream', 5, 2, 299.00, 35);

SELECT * FROM products;


USE pricepulse_db;

INSERT INTO price_history
    (product_id, recorded_price, discount_percentage, recorded_at)
VALUES
(1, 20999.00, 5.00, '2026-10-01 10:00:00'),
(1, 19999.00, 10.00, '2026-10-10 10:00:00'),
(1, 18999.00, 15.00, '2026-10-20 10:00:00'),
(2, 55999.00, 5.00, '2026-10-01 10:00:00'),
(2, 52999.00, 10.00, '2026-10-20 10:00:00'),
(3, 1499.00, 10.00, '2026-10-01 10:00:00'),
(3, 1299.00, 20.00, '2026-10-20 10:00:00'),
(4, 999.00, 10.00, '2026-10-01 10:00:00'),
(4, 899.00, 15.00, '2026-10-20 10:00:00'),
(5, 1399.00, 10.00, '2026-10-01 10:00:00'),
(5, 1199.00, 20.00, '2026-10-20 10:00:00'),
(6, 26999.00, 5.00, '2026-10-01 10:00:00'),
(6, 24999.00, 10.00, '2026-10-20 10:00:00'),
(7, 449.00, 10.00, '2026-10-01 10:00:00'),
(7, 399.00, 15.00, '2026-10-20 10:00:00'),
(8, 349.00, 10.00, '2026-10-01 10:00:00'),
(8, 299.00, 20.00, '2026-10-20 10:00:00');

SELECT * FROM price_history;


USE pricepulse_db;

INSERT INTO customers
    (customer_name, email, city, registration_date)
VALUES
('Rahul Sharma', 'rahul@example.com', 'Hyderabad', '2026-01-15'),
('Priya Reddy', 'priya@example.com', 'Chennai', '2026-02-10'),
('Arjun Kumar', 'arjun@example.com', 'Bangalore', '2026-03-05'),
('Sneha Patel', 'sneha@example.com', 'Vijayawada', '2026-04-20'),
('Kiran Rao', 'kiran@example.com', 'Hyderabad', '2026-05-12');

SELECT * FROM customers;


USE pricepulse_db;

INSERT INTO orders
    (customer_id, order_date, order_status, total_amount)
VALUES
(1, '2026-10-02 10:30:00', 'Completed', 20298.00),
(2, '2026-10-05 14:15:00', 'Completed', 55998.00),
(3, '2026-10-08 11:00:00', 'Placed', 2598.00),
(1, '2026-10-12 16:45:00', 'Completed', 1798.00),
(4, '2026-10-15 09:20:00', 'Cancelled', 1199.00),
(5, '2026-10-18 18:10:00', 'Completed', 25298.00),
(2, '2026-10-21 12:00:00', 'Completed', 698.00),
(3, '2026-10-22 15:30:00', 'Placed', 399.00);

SELECT * FROM orders;


USE pricepulse_db;

INSERT INTO order_items
    (order_id, product_id, quantity, purchase_price)
VALUES
(1, 1, 1, 18999.00),
(1, 7, 1, 399.00),
(2, 2, 1, 52999.00),
(2, 8, 10, 299.00),
(3, 3, 2, 1299.00),
(4, 4, 2, 899.00),
(5, 5, 1, 1199.00),
(6, 6, 1, 24999.00),
(7, 8, 2, 299.00),
(8, 7, 1, 399.00);

SELECT * FROM order_items;


USE pricepulse_db;

INSERT INTO reviews
    (customer_id, product_id, rating, review_text, review_date)
VALUES
(1, 1, 5, 'Excellent phone for the price', '2026-10-03 10:00:00'),
(2, 2, 4, 'Good performance and camera', '2026-10-06 11:30:00'),
(3, 3, 4, 'Good sound quality', '2026-10-09 14:00:00'),
(1, 4, 3, 'Good shirt but average fabric', '2026-10-13 16:00:00'),
(4, 5, 5, 'Beautiful design and comfortable', '2026-10-16 09:30:00'),
(5, 6, 4, 'Works well and saves time', '2026-10-19 12:00:00'),
(2, 7, 5, 'Very useful and easy to read', '2026-10-21 15:00:00'),
(3, 8, 4, 'Good product for daily use', '2026-10-22 17:00:00');

SELECT * FROM reviews;

SHOW TABLES;

-- 1)SELECT QUERIES


-- 1. Select all details of products
SELECT *
FROM products;

-- 2. Select product ID, name, price, and stock quantity
SELECT product_id, product_name, current_price, stock_quantity
FROM products;

-- 3. Display product name, current price, and annual cost (price × 12)
SELECT product_name, current_price,
       current_price * 12 AS annual_cost
FROM products;

-- 4. Display customer name, email, and city
SELECT customer_name, email, city
FROM customers;

-- 5. Display seller name and seller rating
SELECT seller_name, seller_rating
FROM sellers;


-- 2)SELECT with WHERE Clause

-- 1. Products priced above 10000
SELECT product_name, current_price
FROM products
WHERE current_price > 10000;

-- 2. Customers registered in October 2026
SELECT customer_name, email, registration_date
FROM customers
WHERE registration_date BETWEEN '2026-10-01' AND '2026-10-31';

-- 3. Products belonging to category ID 1
SELECT *
FROM products
WHERE category_id = 1;

-- 4. Products from seller ID 2
SELECT product_name, current_price
FROM products
WHERE seller_id = 2;

-- 5. Products priced between 1000 and 20000
SELECT *
FROM products
WHERE current_price BETWEEN 1000 AND 20000;

-- 6. Customers without an email address
SELECT *
FROM customers
WHERE email IS NULL;

-- 7. Products with stock below 20
SELECT product_name, stock_quantity
FROM products
WHERE stock_quantity < 20;

-- 8. Products priced between 8000-10000 or 20000-30000
SELECT product_name, current_price
FROM products
WHERE current_price BETWEEN 8000 AND 10000
   OR current_price BETWEEN 20000 AND 30000;

-- 9. Orders with IDs between 1 and 5
SELECT *
FROM orders
WHERE order_id BETWEEN 1 AND 5;

-- 10. Products whose names contain Samsung
SELECT *
FROM products
WHERE product_name LIKE '%Samsung%';

-- 11. Products whose second letter is 'a'
SELECT *
FROM products
WHERE product_name LIKE '_a%';

-- 12. Unique customer cities
SELECT DISTINCT city
FROM customers;

-- 13. Unique category and price combinations
SELECT DISTINCT category_id, current_price
FROM products;

-- 3)JOIN QUERIES

-- 1. Display product name, seller name, and current price
SELECT p.product_name, s.seller_name, p.current_price
FROM products p
JOIN sellers s ON p.seller_id = s.seller_id;


-- 2. Display customer name, product name, and purchase price
SELECT c.customer_name, p.product_name, oi.purchase_price
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;


-- 3. Display product name, category name, and seller name
SELECT p.product_name, c.category_name, s.seller_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
JOIN sellers s ON p.seller_id = s.seller_id;


-- 4. Display products belonging to the Electronics category
SELECT p.product_name, c.category_name
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics';


-- 5. Display customer name, order ID, order date, and total amount
-- for completed orders
SELECT c.customer_name, o.order_id, o.order_date, o.total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed';


-- 6. Display customers who have not placed any orders
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- 7. Display product name, rating, and review text
SELECT p.product_name, r.rating, r.review_text
FROM products p
JOIN reviews r ON p.product_id = r.product_id;

-- 4)GROUP BY Queries

-- 1. Count the number of products in each category
SELECT category_id, COUNT(*) AS total_products
FROM products
GROUP BY category_id;


-- 2. Count the number of customers in each city
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city;


-- 3. Find the average product price for each seller
SELECT seller_id, AVG(current_price) AS average_price
FROM products
GROUP BY seller_id;


-- 4. Find the highest product price in each category
SELECT category_id, MAX(current_price) AS highest_price
FROM products
GROUP BY category_id;


-- 5. Find the minimum product price in each category
SELECT category_id, MIN(current_price) AS minimum_price
FROM products
GROUP BY category_id;


-- 6. Find the total order amount for each order status
SELECT order_status, SUM(total_amount) AS total_amount
FROM orders
GROUP BY order_status;


-- 7. Count the number of orders placed by each customer
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;


-- 8. Find the average rating for each product
SELECT product_id, AVG(rating) AS average_rating
FROM reviews
GROUP BY product_id;


-- 9. Display categories having more than one product
SELECT category_id, COUNT(*) AS total_products
FROM products
GROUP BY category_id
HAVING COUNT(*) > 1;


-- 10. Display customers who have placed more than one order
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 5)SUBQUERIES

-- 1. Display products whose price is greater than the average product price
SELECT product_name, current_price
FROM products
WHERE current_price > (
    SELECT AVG(current_price)
    FROM products
);


-- 2. Display product name, category ID, and price
-- for products whose category ID is greater than 2
SELECT product_name, category_id, current_price
FROM products
WHERE category_id IN (
    SELECT category_id
    FROM categories
    WHERE category_id > 2
);


-- 3. Display customers who have not placed any orders
SELECT customer_id, customer_name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);


-- 4. Display the most expensive product(s)
SELECT product_name, current_price
FROM products
WHERE current_price = (
    SELECT MAX(current_price)
    FROM products
);


-- 5. Display products whose price is greater than the cheapest product price
SELECT product_name, current_price
FROM products
WHERE current_price > (
    SELECT MIN(current_price)
    FROM products
);


-- 6. Display sellers whose rating is greater than the average seller rating
SELECT seller_name, seller_rating
FROM sellers
WHERE seller_rating > (
    SELECT AVG(seller_rating)
    FROM sellers
);


-- 7. Display price history records whose recorded price
-- is greater than the average recorded price
SELECT history_id, product_id, recorded_price
FROM price_history
WHERE recorded_price > (
    SELECT AVG(recorded_price)
    FROM price_history
);