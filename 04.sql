–SQL Exercise 4
–1-6 Tennis query
–1. output TEAMNO of the teams in which the player with the number 27 is not captain
SELECT t.TEAMNO FROM teams t
JOIN players p ON t.playerno = p.playerno
WHERE p.playerno = 27 AND p.initials != 'C';

–2. output of PLAYERNO, NAME and INITIALS of the players who have won at least one match
SELECT p.playerno, p.name, p.initials FROM players p
JOIN matches m ON p.playerno = m.playerno
WHERE m.WON = 1;

–3. output of playerNo and name of the players who have received at least one penalty
SELECT DISTINCT p.playerno, p.name
FROM players p
JOIN penalties pn ON p.playerno = pn.playerno;

–4. output of playerNo and name of the players, who have received at least one penalty over 50.
SELECT DISTINCT p.playerno, p.name
FROM players p
JOIN penalties pn ON p.playerno = pn.playerno AND pn.amount > 50;

–5. output of PlayerNo and name of players born in the same year as R. Parmenter
SELECT playerno, name
FROM players
WHERE year_of_birth = (SELECT year_of_birth FROM players WHERE name = 'Parmenter' AND initials = 'R');

–6. output of playerNo and name of the oldest player from Stratford
SELECT playerno, name
FROM players WHERE year_of_birth = (SELECT MIN(year_of_birth) FROM players WHERE town = 'Stratford');

–7-12 EmpDept query
–7. search all departments, which have no employees
SELECT dname FROM dept
LEFT JOIN emp ON dept.deptno = emp.deptno
WHERE emp.deptno IS NULL;

–8. search all employees who have the same job as JONES
SELECT * FROM emp WHERE job = (SELECT job FROM emp WHERE ename = 'JONES');

–9. show all employees who make more than the average employee from department 30.
SELECT * FROM emp WHERE sal > (SELECT AVG(sal) FROM emp WHERE deptno = 30);

–10. show all employees who earn more than any employee from department 30
SELECT * FROM emp WHERE sal > (SELECT MAX(sal) FROM emp WHERE deptno = 30);

–11. display all employees from department 10 whose job is not held by any employee from department 30
SELECT * FROM emp WHERE deptno = 10
AND job NOT IN (SELECT job FROM emp WHERE deptno = 30);

–12. search for the employee data (EMPNO, ENAME, JOB, SAL) of the employee with the highest salary.
SELECT empno, ename, job, sal FROM emp WHERE sal = (SELECT MAX(sal) FROM emp);

