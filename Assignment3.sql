-- Language: sql

-- 1
CREATE DATABASE store;

--2
-- customer table
CREATE TABLE customer (
    customerNumber VARCHAR(5) NOT NULL PRIMARY KEY,
    customerName VARCHAR(255) NOT NULL,
    city VARCHAR(100)
);

-- product table
CREATE TABLE product (
    productNumber VARCHAR(5) NOT NULL PRIMARY KEY,
    productName VARCHAR(100) NOT NULL,
    stock INT(3) DEFAULT 15
);

-- transaction table
CREATE TABLE transaction (
    transactionNumber VARCHAR(5) NOT NULL PRIMARY KEY,
    transactionDate DATE,
    customerNumber VARCHAR(5),
    FOREIGN KEY (customerNumber) REFERENCES customer(customerNumber)
);

--3
-- insert data into customer table
INSERT INTO customer (customerNumber, customerName, city)
VALUES
    ('C-003', 'Geneva Electronic', 'Bandung'),
    ('C-007', 'Gama Store', 'Yogyakarta'),
    ('C-009', 'Family Mart', 'Medan'),
    ('C-011', 'Star Store', 'Bandung')
;

-- insert data into product table
INSERT INTO product (productNumber, productName, stock)
VALUES
    ('P-100', 'Monitor 17', 15),
    ('P-120', 'Keyboard Ps2', 20),
    ('P-123', 'Mouse Ps2', 15),
    ('P-125', 'Memory 512', 10)
;

-- insert data into transaction table
INSERT INTO transaction (transactionNumber, transactionDate, customerNumber)
VALUES
    ('T-001', '2019-10-19', 'C-011'),
    ('T-002', '2020-01-10', 'C-003'),
    ('T-003', '2020-08-07', 'C-009'),
    ('T-004', '2020-09-09', 'C-007')
;


-- 4
-- Tampilkan nama city dari Customer secara unik
-- show unique city name from customer table
SELECT DISTINCT city FROM customer;


-- 5 show all data customer
SELECT * FROM customer;

-- 6 show productName and stock from product table
SELECT productName, stock FROM product;

-- 7 show customerName which city is Bandung
SELECT customerName FROM customer WHERE city = 'Bandung';

-- 8 show transactionDate which costumerNumber is C-007
SELECT transactionDate FROM transaction WHERE customerNumber = 'C-007';

-- 9 show all data from product which stock is 15
SELECT * FROM product WHERE stock = 15;

-- 10 update transactionDate from customer which customerNumber is C-007 to today
UPDATE transaction SET transactionDate = CURDATE() WHERE customerNumber = 'C-007';


-- 11
-- 11 Ubahlah customerName menjadi HappyFamily Mart dan city menjadi Jakarta untuk customer yang memiliki customerNumber C-009
-- change customerName to HappyFamily Mart and city to Jakarta for customer who has customerNumber C-009
UPDATE customer
SET customerName = 'HappyFamily Mart', city = 'Jakarta'
WHERE customerNumber = 'C-009';

-- 12
-- Add data product productNumber P-130, productName NIC D-Link, stock default
INSERT INTO product (productNumber, productName, stock)
VALUES
    ('P-130', 'NIC D-Link', DEFAULT);


-- 13
-- add data transaction transactionNumber T-005, transactionDate current date, customerNumber C-003
INSERT INTO transaction (transactionNumber, transactionDate, customerNumber)
VALUES
    ('T-005', CURRENT_DATE, 'C-003'),
    ('T-006', CURRENT_DATE, 'C-011');


-- 14
-- 14)Hapuslah 2 data transaction pertama yang diurutkan berdasarkan transactionNumber  
-- delete 2 first data transaction sorted by transactionNumber
DELETE FROM transaction
ORDER BY transactionNumber
LIMIT 2;


-- 15 delete 2 last data transaction sorted by transactionNumber
DELETE FROM transaction
ORDER BY transactionNumber DESC
LIMIT 2;
