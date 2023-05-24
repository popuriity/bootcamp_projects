-- Practice SQL with 5 Quizzes
-- Store Sales

-- SQLite command  
.mode markdown
.head on
.schema

--------- create table ------------
-- customers table --
CREATE TABLE CUSTOMER(
  customer_id TEXT PRIMARY KEY,
  customer_name TEXT
);

INSERT INTO CUSTOMER VALUES
  ('C00001', 'Jack'),
  ('C00002', 'John'),
  ('C00003', 'Colin'),
  ('C00004', 'Janet'),
  ('C00005', 'Lisa');

-- product table --
CREATE TABLE PRODUCT(
  product_id TEXT PRIMARY KEY,
  product_name TEXT
);

INSERT INTO PRODUCT VALUES
  ('P00001',	'Asus TP412FA-EC491T'),
  ('P00002', 'SWIFT SFX14-41G-R3AD-GOLD'),
  ('P00003',	'MateBook D 14 โน๊ตบุ๊ค (14", Intel Core i5, RAM 8GB, 512GB, สี Mystic Silver)'),
  ('P00004',	'NITRO Acer AN515-57-584CBK'),
  ('P00005',	'Asus TP1400KA-ECP11W'),
  ('P00006',	'Infinix INBOOK X2'),
  ('P00007',	'Swift X Acer SFX1441GR15AGL'),
  ('P00008',	'Asus TP1400KA-ECP11W');

-- sales table --
CREATE TABLE SALES(
  order_date TEXT,
  customer_id TEXT,
  product_id TEXT,
  quantity INT,
  unit_price REAL,
  amount REAL,
  FOREIGN KEY(customer_id)
    REFERENCES customers(customer_id),
  FOREIGN KEY(product_id)
    REFERENCES customers(product_id)
);

INSERT INTO SALES VALUES
  ('2022-05-01', 'C00001', 'P00008',	1,	15000,	15000),
  ('2022-05-01', 'C00005', 'P00002',	3,	25000,	75000),
  ('2022-05-01', 'C00002', 'P00002',	1,	25000,	25000),
  ('2022-05-02', 'C00003', 'P00003',	1,	32000,	32000),
  ('2022-05-02', 'C00005', 'P00002',	3,	25000,	75000),
  ('2022-05-02', 'C00004', 'P00001',	2,	45000,	90000),
  ('2022-05-03', 'C00001', 'P00002',	1,	25000,	25000);


--------- create table ------------
-- 1. How many rows from result of the query below?
-- SELECT * FROM PRODUCT, CUSTOMER, SALES;
SELECT COUNT(*) FROM PRODUCT, CUSTOMER, SALES;
--Ans : 280 rows from 5*8*7

-- 2. List the customers name and total amount of each, sort by max spending to min spending --
SELECT
  c.customer_name,
  SUM(s.amount) AS total_spending
FROM CUSTOMER AS c
LEFT JOIN SALES AS s
ON c.customer_id = s.customer_id
GROUP BY c.customer_name
ORDER BY total_spending DESC;

-- 3. Show 3rd and 4th customer's name and total spending
WITH sub AS
  (SELECT
    c.customer_name,
    SUM(s.amount) AS total_spending,
    RANK() OVER(ORDER BY SUM(s.amount) DESC) AS rank_spending
  FROM CUSTOMER AS c
  LEFT JOIN SALES AS s
  ON c.customer_id = s.customer_id
  GROUP BY c.customer_name)

SELECT customer_name, total_spending
FROM sub
WHERE rank_spending IN (3,4);


-- 4. Show product id of never-been-sold products. --
SELECT 
  p.product_id,
  p.product_name
FROM PRODUCT AS p
LEFT JOIN SALES AS s
ON p.product_id = s.product_id
WHERE s.product_id IS NULL;


-- 5. Show customers' purchase time, order date, customer name, quantity, sales amount
SELECT
  c.customer_name,
  ROW_NUMBER() OVER(PARTITION BY c.customer_name) AS purchase_time,
  s.order_date,
  s.quantity,
  s.amount
FROM SALES AS s
LEFT JOIN CUSTOMER AS c
ON s.customer_id = c.customer_id
ORDER BY order_date;
