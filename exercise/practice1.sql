SELECT * FROM nikovits.emp;

-- 1. List the employees whose salary is greater than 2800.
SELECT ENAME FROM nikovits.emp WHERE SAL > 2800;

-- 2.  List the employees working on department 10 or 20.
SELECT ENAME FROM nikovits.emp WHERE DEPTNO = 10 OR DEPTNO = 20;

-- 3.  List the employees whose commission is greater than 600.
SELECT ENAME FROM nikovits.emp WHERE COMM > 600;

-- 4.  List the employees whose commission is NOT greater than 600.
SELECT ENAME FROM nikovits.emp WHERE COMM <= 600;

-- 5.  List the employees whose commission is not known (that is NULL).
SELECT ENAME FROM nikovits.emp WHERE COMM IS NULL;

-- 6.  List the jobs of the employees (with/without duplication).
-- with duplication
SELECT JOB FROM nikovits.emp;
-- without duplication
SELECT DISTINCT JOB FROM nikovits.emp;

-- 7.  Give the name and double salary of employees working on department 10.
SELECT ENAME, SAL*2 FROM nikovits.emp WHERE DEPTNO = 10;

-- 8.  List the employees whose hiredate is greater than 1982.01.01.
SELECT ENAME FROM nikovits.emp WHERE HIREDATE > TO_Date('1982.01.01', 'YYYY.MM.DD'); 

-- 9.  List the employees who doesn't have a manager.
SELECT ENAME FROM nikovits.emp WHERE MGR IS NULL;

-- 10. List the employees whose name contains a letter 'A'.
SELECT ENAME FROM nikovits.emp WHERE ENAME LIKE '%A%';

-- 11. List the employees whose name contains two letters 'L'.
SELECT ENAME FROM nikovits.emp WHERE ENAME LIKE '%L%L%';

-- 12. List the employees whose salary is between 2000 and 3000.
SELECT ENAME FROM nikovits.emp WHERE SAL BETWEEN 2000 AND 3000;
SELECT ENAME FROM nikovits.emp WHERE SAL >= 2000 AND SAL <= 3000;

-- 13. List the name and salary of employees ordered by salary.
SELECT ENAME, SAL FROM nikovits.emp ORDER BY SAL;

/* 14. List the name and salary of employees ordered by salary in descending order
and within that order, ordered by name in ascending order.*/
SELECT ENAME, SAL FROM nikovits.emp ORDER BY ENAME ASC, SAL DESC;

-- 15. List the employees whose manager is KING. (reading empno of KING from monitor)
SELECT ENAME FROM nikovits.emp WHERE MGR = 7839;

DESC nikovits.likes

-- New table
CREATE TABLE PRACTICE1(NAME VARCHAR2(14), FRUITS VARCHAR2(14));

    insert into PRACTICE1 values ('Piglet', 'apple');
    insert into PRACTICE1 values ('Piglet','pear');
    insert into PRACTICE1 values ('Piglet','raspberry');
    insert into PRACTICE1 values ('Winnie','apple');
    insert into PRACTICE1 values ('Winnie','pear');
    insert into PRACTICE1 values ('Kanga','apple');
    insert into PRACTICE1 values ('Tiger','apple');
    insert into PRACTICE1 values ('Tiger','pear');

SELECT * FROM PRACTICE1;
--DROP TABLE PRACTICE1;


-- 1. List the fruits that Winnie likes.
SELECT FRUITS FROM PRACTICE1 WHERE NAME = 'Winnie';

-- 2. List the fruits that Winnie doesn't like but someone else does.
SELECT FRUITS FROM PRACTICE1 WHERE FRUITS NOT IN(SELECT FRUITS FROM PRACTICE1 WHERE NAME = 'Winnie');

SELECT FRUITS FROM PRACTICE1
MINUS
SELECT FRUITS FROM PRACTICE1 WHERE NAME = 'Winnie';

-- GROUP BY clause groups the results by attributes to eliminate duplicates  
SELECT FRUITS FROM PRACTICE1 WHERE NAME != 'Winnie' AND FRUITS NOT IN(
SELECT FRUITS FROM PRACTICE1 WHERE NAME = 'Winnie')
GROUP BY FRUITS;

-- 3. Who likes apple?
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'apple';

-- 4. List those names who doesn't like pear but like something else.
SELECT NAME FROM PRACTICE1
MINUS
SELECT FRUITS FROM PRACTICE1 WHERE FRUITS = 'pear';

-- 5. Who likes raspberry or pear? 
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'raspberry'
UNION
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear';

SELECT DISTINCT NAME FROM PRACTICE1 WHERE NAME IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear') 
OR NAME IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'raspberry');

SELECT DISTINCT NAME FROM PRACTICE1 WHERE FRUITS IN('raspberry', 'pear');

-- 6. Who likes both apple and pear?
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'apple'
INTERSECT
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear';

SELECT DISTINCT NAME FROM PRACTICE1 WHERE NAME IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear') 
AND NAME IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'apple');

-- 7. Who likes apple but doesn't like pear?
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'apple'
MINUS
SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear';

SELECT NAME FROM PRACTICE1 WHERE NAME IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'apple')  
AND NAME NOT IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear');

SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'apple' AND NAME NOT IN(SELECT NAME FROM PRACTICE1 WHERE FRUITS = 'pear');
