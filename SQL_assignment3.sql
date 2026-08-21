--1. WAQTD emp name and dname for all the employees who are working as salesman dept in 30.
SELECT E.ENAME, D.DNAME FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
WHERE E.JOB = 'SALESMAN' AND E.DEPTNO = 30;

-- 2. WAQTD emp name, job, deptno, and location of all the emp in sales.
SELECT E.ENAME, E.JOB, E.DEPTNO, D.LOC FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
WHERE D.DNAME = 'SALES';

--3. WAQTD ename, dname, sal for all the employees who’s salary is more than miller and less then king.
SELECT E.ENAME, D.DNAME, E.SAL FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO 
WHERE E.SAL > (SELECT SAL FROM EMPLOYEE WHERE ENAME = 'MILLER') AND 
E.SAL < (SELECT SAL FROM EMPLOYEE WHERE ENAME = 'KINGS');

--4. WAQTD no. of employees working in new york.
SELECT COUNT(E.EMPNO) FROM EMPLOYEE E
JOIN DEPARTMENT D USING(DEPTNO)
WHERE D.LOC = 'NEW YORK';

--5. List all employees with their department names.
SELECT E.ENAME, D.DNAME FROM EMPLOYEE E
JOIN DEPARTMENT D USING(DEPTNO);

--6. List the highest-paid employee in each department.
WITH RankedEmployees AS (
    SELECT 
        D.DNAME, 
        E.ENAME, 
        E.SAL, 
        DENSE_RANK() OVER (PARTITION BY E.DEPTNO ORDER BY E.SAL DESC) AS rnk 
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
)
SELECT DNAME, ENAME, SAL
FROM RankedEmployees
WHERE rnk = 1;

--7. List employees along with their department name, sorted by salary descending.
SELECT E.ENAME, D.DNAME FROM EMPLOYEE E
JOIN DEPARTMENT D USING(DEPTNO) ORDER BY E.SAL DESC;

/*8. List employees and their department names where employees have the same job title as 
someone in a different department.*/
SELECT 
    E.ENAME, 
    D.DNAME, 
    E.JOB
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DEPTNO = D.DEPTNO
WHERE E.JOB IN (
    SELECT JOB
    FROM EMPLOYEE
    GROUP BY JOB
    HAVING COUNT(DISTINCT DEPTNO) > 1
);

--9.List all departments name along with who hired first
SELECT D.DNAME,
       E.ENAME,
       E.HIREDATE
FROM EMPLOYEE E
JOIN DEPARTMENT D
    ON E.DEPTNO = D.DEPTNO
WHERE E.HIREDATE = (
    SELECT MIN(E2.HIREDATE)
    FROM EMPLOYEE E2
    WHERE E2.DEPTNO = E.DEPTNO
);

--10.display employee student details
--I'm not sure of this, will ignore for now