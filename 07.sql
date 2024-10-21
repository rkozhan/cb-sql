–SQL Exercise 7
–1-4 Tennis query
– 1. output of players' names who played for both team 1 and team 2.
SELECT DISTINCT name FROM players
JOIN matches ON players.playerno = matches.playerno
WHERE matches.playerno IN (
    SELECT playerno FROM matches
    GROUP BY playerno
    HAVING COUNT(DISTINCT  teamno) > 1
)

– 2. output the NAME and INITIALS of the players who did not receive a penalty in 1980
SELECT DISTINCT name, initials FROM players
JOIN penalties ON players.playerno = penalties.playerno
WHERE penalties.playerno NOT IN (
    SELECT playerno FROM penalties WHERE EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY')) = 80
);

– 3. output of players who received at least one penalty over $80
SELECT name , playerno FROM players
WHERE playerno IN (
    SELECT DISTINCT playerno FROM penalties WHERE amount > 80
);

4. output of players who had all penalties over $80.
SELECT name , playerno FROM players
WHERE playerno IN (
    SELECT DISTINCT playerno FROM penalties WHERE amount > 80
)
AND playerno NOT IN (
    SELECT DISTINCT playerno FROM penalties WHERE amount <= 80
);

–5-8 EmpDept query
– 5. find all employees whose salary is higher than the average salary of their department
SELECT e1.empno, e1.sal, e1.deptno, ROUND(e2.avg_sal, 2) FROM emp e1
JOIN (
    SELECT deptno, AVG(sal) AS avg_sal FROM emp
    GROUP BY deptno
) e2 ON e1.deptno = e2.deptno
WHERE e1.sal > e2.avg_sal;

– 6. identify all departments that have at least one employee
SELECT deptno, dname FROM dept
WHERE deptno IN (
    SELECT deptno FROM emp
);

– 7. output of all departments that have at least one employee earning over $1000
SELECT deptno, dname FROM dept
WHERE deptno IN (
    SELECT deptno FROM emp WHERE sal > 1000
);

– 8. output of all departments in which each employee earns at least 1000,-.
SELECT deptno, dname FROM dept
WHERE deptno IN (
    SELECT deptno FROM emp WHERE sal >= 1000
) AND deptno NOT IN (
    SELECT deptno FROM emp WHERE sal < 1000
);
