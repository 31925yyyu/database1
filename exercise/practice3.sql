SELECT * FROM nikovits.emp;
SELECT * FROM emp;
SELECT * FROM nikovits.Sal_cat;

CREATE TABLE practice3 AS
SELECT e1.ename boss, e2.ename FROM emp e1, emp e2
WHERE
e1.empno = e2.mgr AND LENGTH(e1.ename) = LENGTH(e2.ename);

SELECT object_name "TABLE", created FROM user_objects 
WHERE object_type='TABLE' AND object_name LIKE 'PRACTICE3%'
ORDER BY object_name;

SELECT * FROM practice3;

-- DROP TABLE practice3;

CREATE TABLE Sal_cat AS SELECT * FROM nikovits.Sal_cat;
SELECT * FROM Sal_cat;
-- DROP TABLE Sal_cat;

-- 1.  List the employees whose salary is divisible by 15. (use mod function)
SELECT ename, sal FROM emp WHERE MOD(sal, 15) = 0;

-- 2.  List the employees, whose hiredate is greater than 1982.01.01. (use to_date function)
SELECT ename, hiredate FROM emp WHERE hiredate > to_date('1982.01.01', 'YYYY.MM.DD');

-- 3.  List the employees where the second character of his name is 'A'. (use substr function)
-- SUBSTR(string, start_position [, length])
SELECT ename FROM emp WHERE SUBSTR(ename, 2, 1) = 'A';

-- 4.  List the employees whose name contains two 'L'-s. (use instr function)
-- INSTR(string, substring [, start_position [, nth_appearance]])
SELECT ename FROM emp WHERE INSTR(ename, 'L', 1, 2) > 0;

-- 5.  List the last 3 characters of the employees' names. (use substr function)
SELECT SUBSTR(ename, LENGTH(ename)-3, 3) subname FROM emp ;

-- 6.  List the emloyees whose name has a 'T' in the last but one position (position before the last). (use substr function)
SELECT ename FROM emp WHERE SUBSTR(ename, LENGTH(ename)-1, 1) = 'T';

-- 7.  List the square root of the salaries rounded to 2 decimals and the integer part of it. (sqrt, round, trunc function)
SELECT ename, sal, TRUNC(ROUND(SQRT(sal), 2)) Calsal FROM emp;

-- 8.  In which month was the hiredate of ADAMS? (give the name of the month) (date functions)
SELECT hiredate, TO_CHAR(hiredate, 'Month') month FROM emp WHERE ename = 'ADAMS';

-- 9.  Give the number of days since ADAMS's hiredate. (date arithmetic)
SELECT TRUNC(SYSDATE - hiredate) days FROM emp WHERE ename = 'ADAMS';

-- 10. List the employees whose hiredate was Tuesday. (Take care of the length of name_day string!) (to_char function)
SELECT ename, hiredate, TO_CHAR(hiredate, 'Day') day FROM emp WHERE TO_CHAR(hiredate, 'Day') LIKE 'Tuesday%';

-- 11. Give the manager-employee name pairs where the length of the two names are equal. (length function)
SELECT e1.ename, e2.ename FROM emp e1, emp e2
WHERE
e1.empno = e2.mgr AND LENGTH(e1.ename) = LENGTH(e2.ename);

SELECT * FROM Sal_cat;
-- 12. List the employees whose salary is in category 1. (see Sal_cat table)
SELECT e.ename, e.sal FROM emp e, Sal_cat s
WHERE
s.category = 1 AND e.sal BETWEEN s.lowest_sal AND s.highest_sal;

-- 13. List the employees whose salary category is an even number. (mod function)
-- MOD(dividend, divisor)
SELECT e.ename, e.sal, s.category FROM emp e, Sal_cat s
WHERE
MOD(s.category, 2) = 0 AND e.sal BETWEEN s.lowest_sal AND s.highest_sal;

-- 14. Give the number of days between the hiredate of KING and the hiredate of JONES.
SELECT (k.hiredate - j.hiredate) days FROM emp k, emp j
WHERE
k.ename = 'KING' AND j.ename = 'JONES';

-- 15. Give the name of the day (e.g. Monday) which was the last day of the month in which KING's hiredate was. (last_day function)
--  the LAST_DAY function is used to return the last day of the month for a given date. 
-- LAST_DAY(date_expression)

SELECT TO_CHAR(LAST_DAY(hiredate), 'Day') day FROM emp WHERE ename = 'KING';

-- 16. Give the name of the day (e.g. Monday) which was the first day of the month in which KING's hiredate was. (trunc function)
-- TRUNC(hiredate, 'mm') = 81-NOV-01
SELECT TO_CHAR(TRUNC(hiredate, 'mm'), 'Day') day FROM emp WHERE ename = 'KING';

-- 17. Give the names of employees whose department name contains a letter 'C' and whose salary category is >= 4.
SELECT * FROM dept;
SELECT * FROM Sal_Cat;
SELECT * FROM emp;

SELECT e.ename, d.dname, sc.category FROM emp e, dept d, Sal_Cat sc
WHERE
e.deptno = d.deptno AND e.sal BETWEEN sc.lowest_sal AND sc.highest_sal AND
sc.category >= 4 AND INSTR(d.dname, 'C') > 0;
-- dname LIKE '%C%'

-- 18. List the name and salary of the employees, and a charater string where one '#' denotes 1000 (rounded). (rpad function)
-- (So if the salary is 1800 then print -> '##', because 1800 rounded to thousands is 2.) 
SELECT ename, sal, rpad('#', round(sal, -3)/1000, '#') str FROM emp;
