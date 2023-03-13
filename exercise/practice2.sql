CREATE TABLE practice2 AS
SELECT name FROM nikovits.likes where fruits = 'apple' 
INTERSECT
SELECT name FROM nikovits.likes where fruits = 'pear';

DROP TABLE practice2;

-- check the table exist oer not
SELECT object_name "TABLE", created FROM user_objects 
WHERE object_type='TABLE' AND object_name LIKE 'PRACTICE2%'
ORDER BY object_name;

SELECT * FROM practice2;

DESC practice2

CREATE TABLE likes AS SELECT * FROM nikovits.likes;

SELECT * FROM likes;

-- 1. List the fruits that Winnie likes.
SELECT fruits FROM likes WHERE name = 'Winnie';

-- 2. List the fruits that Winnie doesn't like but someone else does.
SELECT fruits FROM likes
MINUS
SELECT fruits FROM likes WHERE name = 'Winnie';

-- 3. Who likes apple?
SELECT name FROM likes WHERE fruits = 'apple';

-- 4. List those names who doesn't like pear but like something else.
SELECT name FROM likes 
MINUS
SELECT name FROM likes WHERE fruits = 'pear';

-- 5. Who likes raspberry or pear? 
SELECT name FROM likes WHERE fruits = 'raspberry'
UNION
SELECT name FROM likes WHERE fruits = 'pear';

-- 6. Who likes both apple and pear?
SELECT name FROM likes WHERE fruits = 'apple'
INTERSECT
SELECT name FROM likes WHERE fruits = 'pear';

-- 7. Who likes apple but doesn't like pear? 
SELECT name FROM likes WHERE fruits = 'apple'
MINUS
SELECT name FROM likes WHERE fruits = 'pear';

----------- so far in db1_exercise1.txt
-- 8.  List the names who like at least two different fruits.
SELECT name FROM (SELECT name, COUNT(*) from likes GROUP BY name HAVING COUNT(*) >= 2);

-- 9.  List the names who like at least three different fruits.
SELECT name FROM (SELECT name, COUNT(*) from likes GROUP BY name HAVING COUNT(*) >= 3);

-- 10. List the names who like at most two different fruits.
SELECT name FROM (SELECT name, COUNT(*) from likes GROUP BY name HAVING COUNT(*) <= 2);

-- 11. List the names who like exactly two different fruits.
SELECT name FROM (SELECT name, COUNT(*) from likes GROUP BY name HAVING COUNT(*) = 2);

CREATE TABLE dept(
 deptno   NUMERIC(2),    -- department number
 dname    VARCHAR(14),   -- department name 
 loc      VARCHAR(13)    -- location of the department
);

INSERT INTO dept VALUES(10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES(20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES(30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES(40, 'OPERATIONS', 'BOSTON');

SELECT * FROM dept;

CREATE TABLE emp AS
SELECT * FROM nikovits.emp;

SELECT * FROM emp;

-- 1.  List the employees whose salary is greater than 2800.
SELECT ename FROM emp WHERE sal > 2800;

-- 2.  List the employees working on department 10 or 20.
SELECT ename FROM emp WHERE deptno = 10 OR deptno = 20;

-- 3.  List the employees whose commission is greater than 600.
SELECT ename FROM emp WHERE comm > 600;

-- 4.  List the employees whose commission is NOT greater than 600.
SELECT ename FROM emp WHERE NOT(comm > 600);

-- 5.  List the employees whose commission is not known (that is NULL).
SELECT ename FROM emp WHERE comm IS NULL;

-- 6.  List the jobs of the employees (with/without duplication).
-- with duplication
SELECT job FROM emp;
-- without dupication
SELECT DISTINCT job FROM emp;

-- 7.  Give the name and double salary of employees working on department 10.
SELECT ename, sal*2 FROM emp WHERE deptno = 10;

-- 8.  List the employees whose hiredate is greater than 1982.01.01.
SELECT ename FROM emp WHERE hiredate > to_date('1982.01,01', 'YYYY.MM.DD');

-- 9.  List the employees who doesn't have a manager.
SELECT ename FROM emp WHERE mgr IS NULL;

-- 10. List the employees whose name contains a letter 'A'.
SELECT ename FROM emp WHERE ename LIKE '%A%';

-- 11. List the employees whose name contains two letters 'L'.
SELECT ename FROM emp WHERE ename LIKE '%L%L%';

-- 12. List the employees whose salary is between 2000 and 3000.
SELECT ename FROM emp WHERE sal BETWEEN 2000 AND 3000;

-- 13. List the name and salary of employees ordered by salary.
SELECT ename,sal FROM emp
ORDER BY sal;

-- 14. List the name and salary of employees ordered by salary in descending order and within that order, ordered by name in ascending order.
SELECT ename,sal FROM emp
ORDER BY sal DESC, ename ASC;

-- 15. List the employees whose manager is KING. (reading empno of KING from monitor)
SELECT ename FROM emp WHERE mgr = 7839;

----------- so far in db1_exercise1.txt
-- 16. List the employees whose manager is KING. (without reading from monitor)
SELECT ename FROM emp WHERE mgr = (SELECT empno FROM emp WHERE ename = 'KING');

-- 17. Give the names of employees who are managers of someone, but whose job is not 'MANAGER'.
SELECT ename FROM emp WHERE NOT(mgr IS NULL) AND job <> 'MANAGER';

-- 18. List the names of employees who has greater salary than his manager.
SELECT e1.ename FROM emp e1, emp e2
WHERE
e1.mgr = e2.empno AND e1.sal > e2.sal;

-- 19. List the employees whose manager's manager is KING.
SELECT e1.ename FROM emp e1, emp e2, emp e3
WHERE
e1.mgr = e2.empno AND e2.mgr = e3.empno AND e3.ename = 'KING';

-- 20. List the employees whose department's location is DALLAS or CHICAGO?
SELECT e1.ename FROM emp e1, dept d1 
WHERE
e1.deptno = d1.deptno AND d1.loc IN ('DALLAS', 'CHICAGO');

-- 21. List the employees whose department's location is not DALLAS and not CHICAGO?
SELECT e1.ename FROM emp e1, dept d1 
WHERE
e1.deptno = d1.deptno AND d1.loc NOT IN ('DALLAS', 'CHICAGO');

-- 22. List the employees whose salary is greater than 2000 or work on a department in CHICAGO.
SELECT e1.ename FROM emp e1, dept d1
WHERE
e1.sal > 2000 OR e1.deptno = d1.deptno AND d1.loc = 'CHICAGO';

-- 23. Which department has no employees?
SELECT * FROM dept;
SELECT * FROM emp;

SELECT deptno FROM dept
MINUS
SELECT deptno FROM emp;

-- 24. List the employees who has a subordinate whose salary is greater than 2000.
SELECT DISTINCT e1.ename FROM emp e1, emp e2
WHERE
e2.mgr = e1.empno AND e2.sal > 2000;

-- 25. List the employees who doesn't have a subordinate whose salary is greater than 2000.
SELECT DISTINCT e1.ename FROM emp e1, emp e2
WHERE e2.mgr = e1.empno
MINUS
SELECT DISTINCT e1.ename FROM emp e1, emp e2
WHERE e2.mgr = e1.empno AND e2.sal > 2000;

-- 26. List the department names and locations where there is an employee with job ANALYST.
SELECT DISTINCT d1.dname, d1.loc FROM emp e1, dept d1
WHERE
e1.deptno = d1.deptno AND e1.job = 'ANALYST';

-- 27. List the department names and locations where there is no employee with job ANALYST.
SELECT DISTINCT d1.dname, d1.loc FROM dept d1
MINUS
SELECT DISTINCT d1.dname, d1.loc FROM emp e1, dept d1
WHERE
e1.deptno = d1.deptno AND e1.job = 'ANALYST';

--28. Give the name(s) of employees who have the greatest salary. (rel. alg + SQL)
SELECT ename FROM emp
MINUS
SELECT e1. ename FROM emp e1, emp e2 WHERE e1.sal < e2.sal;







