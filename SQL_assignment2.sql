/*Database Design and Implementation
Objective
In this assignment, students will practice designing and implementing a database using MySQL, 
focusing on creating a table with a foreign key to establish relationships between different entities.

Background / Context
A company wants to manage its sales data, including information about customers, orders, and products. 
The company needs a database that can store this information efficiently and allow for queries that provide insights into sales trends and 
customer behavior. Students will design and implement a database that meets these requirements.

Tasks / Requirements
Design a database schema that includes at least three tables: customers, orders, and products
Create a table for customers with the following attributes: customer_id (primary key), name, email, and address
Create a table for products with the following attributes: product_id (primary key), product_name, price, and description
Create a table for orders with the following attributes: order_id (primary key), customer_id (foreign key referencing the customers table),
 product_id (foreign key referencing the products table), order_date, and total_cost
Use MySQL to create the tables and establish the relationships between them
Insert at least five records into each table to test the database
Write a query that retrieves the order history for a specific customer, including the product name, order date, and total cost
Write a query that retrieves the total sales for a specific product
Submit a SQL script that creates the database schema, inserts the sample data, and executes the queries*/

--Step 1: Create a tables for customers, products and orders
CREATE TABLE CUSTOMERS
(
    CUSTOMER_ID VARCHAR2(20) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,
    ADDRESS VARCHAR2(50) NOT NULL
);

CREATE TABLE PRODUCTS
(
    PRODUCT_ID VARCHAR2(20) PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(30) NOT NULL,
    PRICE NUMBER(10,2) NOT NULL,
    DESCRIPTION VARHCAR2(50) NOT NULL
);

CREATE TABLE ORDERS
(
    ORDER_ID VARCHAR2(20) PRIMARY KEY,
    CUSTOMER_ID VARCHAR2(20) NOT NULL,
    PRODUCT_ID VARCHAR2(20) NOT NULL,
    ORDER_DATE DATE NOT NULL,
    TOTAL_COST NUMBER(10,2) NOT NULL,

    CONSTRAINT FK_CUST
        FOREIGN KEY (CUSTOMER_ID)
        REFERENCES CUSTOMERS(CUSTOMER_ID),

    CONSTRAINT FK_PROD
        FOREIGN KEY (PRODUCT_ID)
        REFERENCES PRODUCTS(PRODUCT_ID)
);

--Step 2: Insert records into these tables
INSERT ALL 
    INTO CUSTOMERS VALUES ('C1', 'PRAGNA', 'pragna@gmail.com', 'HYDERABAD')
    INTO CUSTOMERS VALUES ('C2', 'PRANAV', 'pranav@gmail.com', 'WARANGAL')
    INTO CUSTOMERS VALUES ('C3', 'ANITHA', 'anitha@gmail.com', 'SANGAREDDY')
    INTO CUSTOMERS VALUES ('C4', 'RAJ KUMAR', 'rajkumar@gmail.com', 'NIZAMABAD')
    INTO CUSTOMERS VALUES ('C5', 'SIRI', 'siri@gmail.com', 'GUNTHAKAL');

INSERT ALL
    INTO PRODUCTS VALUES ('P1', 'PENCIL', '8', 'This pencil is made of wood and is eco friendly')
    INTO PRODUCTS VALUES ('P2', 'PEN', '10', 'Blue ink pen and is made it plastic')
    INTO PRODUCTS VALUES ('P3', 'BOOK', '30', '200 pages plain book')
    INTO PRODUCTS VALUES ('P4', 'CHART PAPER', '5', '1 feet plain char paper')
    INTO PRODUCTS VALUES ('P5', 'KEY CHAIN', '20', 'It is a girl keychain');

INSERT ALL
    INTO ORDERS VALUES ('O1', 'C1', 'P3', TO_DATE('2026-07-22','YYYY-MM-DD'), 30)
    INTO ORDERS VALUES ('O2', 'C2', 'P4', TO_DATE('2026-07-23','YYYY-MM-DD'), 5)
    INTO ORDERS VALUES ('O3', 'C5', 'P2', TO_DATE('2026-07-24','YYYY-MM-DD'), 10)
    INTO ORDERS VALUES ('O4', 'C4', 'P2', TO_DATE('2026-07-25','YYYY-MM-DD'), 10)
    INTO ORDERS VALUES ('O5', 'C3', 'P1', TO_DATE('2026-08-01','YYYY-MM-DD'), 8);

--Write a query that retrieves the order history for a specific customer, including the product name, order date, and total cost
SELECT O.ORDER_ID,
       P.PRODUCT_NAME,
       O.ORDER_DATE,
       O.TOTAL_COST
FROM ORDERS O
JOIN CUSTOMERS C
    ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN PRODUCTS P
    ON O.PRODUCT_ID = P.PRODUCT_ID
WHERE C.NAME = 'PRAGNA';

--Write a query that retrieves the total sales for a specific product
SELECT PRODUCT_ID,
       SUM(TOTAL_COST) AS TOTAL_SALES
FROM ORDERS
WHERE PRODUCT_ID = 'P2'
GROUP BY PRODUCT_ID;