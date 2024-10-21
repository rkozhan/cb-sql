–SQL Exercise 6
–1-5 Tennis query
– 1. NAME, INITIALS and number of sets won for each player
SELECT p.name, p.initials, SUM(m.won) FROM matches m
JOIN players p ON m.playerno = p.playerno 
GROUP BY p.name, p.initials;

– 2. NAME, PEN_DATE and AMOUNT sorted in descending order by AMOUNT
SELECT p.name, pe.pen_date, pe.amount FROM penalties pe
JOIN players p ON pe.playerno = p.playerno 
ORDER BY pe.amount DESC;

– 3. TEAMNO, NAME (of the captain) per team
SELECT t.teamno, p.name FROM teams t
JOIN players p ON t.playerno = p.playerno;

– 4. NAME (player name), WON, LOST of all won matches
SELECT p.name, m.won, m.lost FROM matches m
JOIN players p ON m.playerno = p.playerno
WHERE m.won > m.lost;

– 5. PLAYERNO, NAME and penalty amount for each team player. If a player has not yet received a penalty, it should still be issued. Sorting should be done in ascending order of penalty amount
SELECT p.playerno, p.name, NVL(SUM(pe.amount), 0) AS total_amount
FROM players p
LEFT JOIN penalties pe ON p.playerno = pe.playerno
GROUP BY p.playerno, p.name
ORDER BY total_amount;

6-9 EmptDept query
– 6. in which city does the employee Allen work?
SELECT loc FROM dept
WHERE deptno = (
    SELECT deptno FROM emp WHERE ENAME = 'ALLEN'
);

– 7. search for all employees who earn more than their supervisor
SELECT e1.* FROM emp e1
WHERE e1.sal > (
    SELECT e2.sal FROM emp e2 WHERE e2.empno = e1.mgr 
);

– 8. output the number of hires per department in each year
SELECT deptno, EXTRACT(YEAR FROM TO_DATE(hiredate, 'DD-MM-YYYY')) AS year, COUNT(*) FROM emp
GROUP BY deptno, EXTRACT(YEAR FROM TO_DATE(hiredate, 'DD-MM-YYYY'))
ORDER BY deptno;

– 9. output all employees who have a job like an employee from CHICAGO.
SELECT * FROM emp
WHERE job IN (
    SELECT job FROM emp WHERE deptno = (
        SELECT deptno FROM dept WHERE loc = 'CHICAGO'
    )
);
