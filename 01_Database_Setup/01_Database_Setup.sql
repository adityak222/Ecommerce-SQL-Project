USE ecommerce_db;
SELECT DATABASE();
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);
INSERT INTO Customers
(customer_id, customer_name, email, city)
VALUES
(1, 'Rahul', 'rahul@gmail.com', 'Delhi'),
(2, 'Priya', 'priya@gmail.com', 'Mumbai'),
(3, 'Amit', 'amit@gmail.com', 'Delhi'),
(4, 'Neha', 'neha@gmail.com', 'Pune'),
(5, 'Karan', 'karan@gmail.com', 'Jaipur'),
(6, 'Sneha', 'sneha@gmail.com', 'Mumbai'),
(7, 'Arjun', 'arjun@gmail.com', 'Delhi'),
(8, 'Pooja', 'pooja@gmail.com', 'Pune');


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

INSERT INTO Products
(product_id, product_name, category, price)
VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Chair', 'Furniture', 5000),
(104, 'Table', 'Furniture', 8000),
(105, 'Headphones', 'Electronics', 2000),
(106, 'Watch', 'Accessories', 3000),
(107, 'Shoes', 'Fashion', 2500),
(108, 'Keyboard', 'Electronics', 1500);



CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

INSERT INTO Orders
(order_id, customer_id, order_date)
VALUES
(1001, 1, '2026-01-05'),
(1002, 2, '2026-01-10'),
(1003, 1, '2026-02-02'),
(1004, 3, '2026-02-15'),
(1005, 4, '2026-03-01'),
(1006, 2, '2026-03-10'),
(1007, 5, '2026-03-15'),
(1008, 6, '2026-04-02');


CREATE TABLE Order_Details (
    detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

INSERT INTO Order_Details
(detail_id, order_id, product_id, quantity)
VALUES
(1, 1001, 101, 1),
(2, 1001, 105, 2),
(3, 1002, 102, 1),
(4, 1003, 103, 2),
(5, 1004, 101, 1),
(6, 1005, 104, 1),
(7, 1006, 105, 3),
(8, 1007, 106, 2),
(9, 1008, 107, 1);


SELECT
    c.customer_name,
    o.order_id,
    o.order_date
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id;