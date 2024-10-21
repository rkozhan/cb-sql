–SQL Exercise 3
--1-8 Tennis queries
–1. output of PLAYERNO, NAME of players born after 1960.
SELECT playerno, name FROM players
WHERE year_of_birth > 1960;

–2. output of PLAYERNO, NAME and TOWN of all female players who do not reside in Strat- ford.
SELECT playerno, name, town FROM players
WHERE sex = 'F' AND town != 'Stratford';

–3. output of player numbers of players who joined the club between 1970 and 1980.
SELECT playerno, FROM players
WHERE year_joined BETWEEN 1970 AND 1980;

–4. output of PlayerId, Name, Year of Birth of players born in a leap year.
SELECT playerno, name, year_of_birth FROM players
WHERE MOD(year_of_birth, 4) = 0;

–5. output of the penalty numbers of the penalties between 50,- and 100,-.
SELECT playerno FROM penalties
WHERE amount BETWEEN 50 AND 100;

–6. output of PlayerId, name of players who do not live in Stratford or Douglas.
SELECT playerno, name, town FROM players
WHERE town != 'Stratford' AND town != 'Douglas';

–7. output of playerId and name of players whose name contains 'is'.
SELECT playerno, name FROM players
WHERE name LIKE '%is%';

–8. output of all hobby players.
SELECT playerno, name, leagueno FROM players
WHERE leagueno IS NULL;

–9 - 21 EmpDept queries.
–9. output of those employees who receive more commission than salary.
SELECT empno, comm, sal FROM emp
WHERE comm > sal;

–10. output of all employees from department 30 whose salary is greater than or equal to 1500.
SELECT empno, deptno, sal FROM emp
WHERE deptno = 30 AND sal >= 1500;


–11. output of all managers who do not belong to department 30.
SELECT * FROM emp
WHERE job = 'MANAGER' AND deptno != 30;

–12. output of all employees from department 10 who are neither managers nor clerical workers (CLERK).
SELECT * FROM emp
WHERE deptno = 10 AND job NOT IN ('MANAGER',  'CLERK');

–13. output of all employees who earn between 1200,- and 1300,-.
SELECT * FROM emp
WHERE sal BETWEEN 1200 AND 1300;

–14. output all employees whose name is 5 characters long and begins with ALL.
SELECT * from emp 
WHERE LENGTH(ENAME) = 5 AND ename LIKE 'ALL%';

–15. output the total salary (salary + commission) for each employee.
SELECT empno, ename, sal + NVL(comm, 0) AS total_salary from emp;

–16. output all employees, whose commission is over 25% of the salary.
SELECT * FROM emp WHERE comm/sal > 0.25;

–17. searched is the average salary of all office employees.
SELECT AVG(sal) FROM emp;

–18. searched is the number of employees who have received a commission.
SELECT COUNT(*) FROM emp
WHERE COMM IS NOT NULL;

–19. wanted is the number of different jobs in department 30.
SELECT COUNT(DISTINCT job)
FROM emp WHERE deptno = 30;

–20. wanted is the number of employees in department 30.
SELECT COUNT(*) FROM emp
WHERE deptno = 30;

–21. output of employees hired between 4/1/81 and 15/4/81.
SELECT * FROM emp
WHERE hiredate between '04.01.81' AND '15.04.81';
