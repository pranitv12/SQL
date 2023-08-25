CREATE DATABASE PROJECT;

USE PROJECT;

-- SALESPEOPLE
CREATE TABLE SALESPEOPLE(
SNUM INT PRIMARY KEY , 
SNAME VARCHAR(30),
CITY VARCHAR(25), COMM DECIMAL(5,2));
SELECT * FROM SALESPEOPLE;
INSERT INTO SALESPEOPLE  VALUES (1001,'PEEL', 'LONDON',0.12),
(1002,'SERRES','SAN JOSE', 0.13), (1003,'AXELROD','NEW YORK', 0.10),
(1004,'MOTIKA','LONDON', 0.11),(1007,'RAFKIN','BARCELONA',0.15);

-- CUST TABLE
CREATE TABLE CUST(
CNUM INT PRIMARY KEY ,
CNAME VARCHAR(25), CITY VARCHAR(25), RATING INT, SNUM INT);

INSERT INTO CUST (CNUM,CNAME,CITY,RATING, SNUM) VALUES 
(2001,'HOFFMAN','LONDON',1000,1001),(2002,'GIOVANNE','ROME',200,1003),
(2003,'LIU','SAN JOSE', 300,1002),(2004,'GRASS', 'BERLIN',100,1002),
(2006,'CLEMENS','LONDON',300,1007),(2007,'PEREIRA','ROME',100,1004),
(2008,'JAMES','LONDON',200,1007);
SELECT * FROM CUST;

-- ORDERS TABLE
CREATE TABLE ORDERS(
ONUM INT PRIMARY KEY, AMT DECIMAL(8,2), ODATE DATE, CNUM INT, SNUM INT);

INSERT INTO ORDERS VALUES (3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10, '1994-10-03',2007,1004),(3003,767.19, '1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);
SELECT * FROM ORDERS;

ALTER TABLE ORDERS ADD FOREIGN KEY(SNUM) REFERENCES SALESPEOPLE(SNUM) ;
ALTER TABLE CUST ADD FOREIGN KEY(SNUM) REFERENCES SALESPEOPLE(SNUM);
ALTER TABLE ORDERS ADD FOREIGN KEY(CNUM) REFERENCES CUST(CNUM) ;

-- 4.	Write a query to match the salespeople to the customers according to the city they are living.
SELECT S.sname AS "Salesman",
C.cname, C.city 
FROM SALESPEOPLE S ,CUST C
WHERE S.city=C.city;

-- 5. Write a query to select the names of customers and the salespersons who are providing service to them
SELECT C.CNUM,S.SNUM, C.CNAME, S.SNAME
FROM CUST C
JOIN SALESPEOPLE S 
USING (SNUM);

-- 6. Write a query to find out all orders by customers not located in the same cities as that of their salespeople
SELECT S.sname AS "Salesman",
C.cname, C.city 
FROM SALESPEOPLE S ,CUST C
WHERE S.city!=C.city;

-- 7.Write a query that lists each order number followed by name of customer who made that order
SELECT O.ONUM,C.CNUM,C.CNAME
FROM ORDERS O
JOIN CUST C 
USING (CNUM);

-- 8. Write a query that finds all pairs of customers having the same rating
SELECT * FROM CUST
ORDER BY RATING;

-- 9.Write a query to find out all pairs of customers served by a single salesperson
SELECT  S.SNAME , C.CNAME FROM CUST C
JOIN SALESPEOPLE S
USING (SNUM);

-- 10.Write a query that produces all pairs of salespeople who are living in same city
SELECT SNAME,CITY FROM SALESPEOPLE
ORDER BY CITY;

-- 11.Write a Query to find all orders credited to the same salesperson who services Customer 2008
SELECT O.ONUM, O.CNUM ,O.SNUM , S.SNAME
FROM ORDERS O
JOIN SALESPEOPLE S 
USING (SNUM)
WHERE CNUM=2008;

-- 12.Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT * FROM ORDERS WHERE AMT>(SELECT AVG(AMT) FROM ORDERS WHERE ODATE='1994-10-04');

-- 13.	Write a Query to find all orders attributed to salespeople in London
SELECT O.ONUM,S.SNAME,O.SNUM ,S.CITY
FROM ORDERS O
JOIN SALESPEOPLE S 
USING (SNUM)
WHERE CITY ='LONDON';

-- 14.	Write a query to find all the customers whose cnum is 1000 above the snum of Serres
SELECT C.CNUM,C.CNAME,S.SNUM,S.SNAME
FROM CUST C,SALESPEOPLE S 
WHERE S.SNUM+1000=C.CNUM;

-- 15.Write a query to count customers with ratings above San Jose’s average rating 
SELECT CNUM,RATING FROM CUST 
WHERE RATING>(SELECT AVG(RATING) FROM CUST WHERE CITY='SAN JOSE');

-- 16.	Write a query to show each salesperson with multiple customers
SELECT S.SNAME, C.CNAME 
FROM SALESPEOPLE S,CUST C 
WHERE S.SNUM=C.SNUM;
