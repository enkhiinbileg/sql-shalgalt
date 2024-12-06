SELECT p.name, od.quantity, p.price, (od.quantity * p.price) AS total_price
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
WHERE od.order_id = 1;

SELECT u.name, COUNT(o.order_id) AS total_orders, SUM(o.total_price) AS total_spent
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.user_id;

CREATE VIEW order_summary AS
SELECT o.order_id, u.name AS user_name, o.order_date, p.name AS product_name, od.quantity, p.price, (od.quantity * p.price) AS total_price
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Products p ON od.product_id = p.product_id;

UPDATE Products 
SET stock_quantity = 150 
WHERE product_id = 1;

DELETE FROM Order_Details 
WHERE order_detail_id = 1;

DELETE FROM Products 
WHERE stock_quantity = 0;

DELETE FROM Products 
WHERE expiry_date < CURDATE();  -- Хугацаа дууссан бүтээгдэхүүнийг устгах

SELECT * 
FROM Products 
WHERE price >= 100000;

SELECT * 
FROM Users 
WHERE email LIKE '%@gmail.com';

SELECT u.name 
FROM Users u 
WHERE u.user_id = (
    SELECT o.user_id
    FROM Orders o
    JOIN Order_Details od ON o.order_id = od.order_id
    GROUP BY o.user_id
    ORDER BY COUNT(od.product_id) DESC
    LIMIT 1
);

SELECT category 
FROM Products p
WHERE p.product_id IN (
    SELECT od.product_id 
    FROM Order_Details od
    GROUP BY od.product_id
    ORDER BY SUM(od.quantity) DESC
    LIMIT 1
);

ALTER TABLE Products
ADD CONSTRAINT price_min CHECK (price >= 10000);

SELECT u.name, o.order_date, SUM(od.quantity) AS total_quantity
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY u.name, o.order_date
ORDER BY o.order_date;

CREATE TABLE Product_Summary (
    category VARCHAR(100),
    total_quantity INT
);

INSERT INTO Product_Summary (category, total_quantity)
SELECT p.category, SUM(od.quantity)
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.category;

SELECT u.name, MAX(o.order_date) AS last_order_date
FROM Users u
JOIN Orders o ON u.user_id = o.user_id
GROUP BY u.name;

SELECT p.name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.name
ORDER BY total_sold DESC
LIMIT 1;


