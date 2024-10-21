–SQL Exercise 5[edit]
–1-11 Tennis query
–1. number of new players per year
SELECT DISTINCT p1.year_joined,
(SELECT COUNT (p2.year_joined) FROM players p2 WHERE p2.year_joined = p1.year_joined) AS players
FROM players p1
ORDER BY p1.year_joined;

–2. number and average amount of penalties per player
SELECT DISTINCT p.playerno,
(SELECT AVG(pen.amount) FROM penalties pen WHERE pen.playerno = p.playerno) AS AVERAGE_AMOUNT
FROM players p
ORDER BY p.playerno;

–3. number of penalties for the years before 1983
SELECT COUNT(*) FROM penalties WHERE pen_date < '01.01.83';

–4. in which cities live more than 4 players
SELECT town, COUNT(*) FROM players
GROUP BY town
HAVING COUNT(*) > 4;

–5. PLAYERNO of those players whose penalty total is over 150
SELECT playerno, SUM(amount) FROM penalties
GROUP BY playerno
HAVING SUM(amount) > 150;

–6. NAME and INITIALS of those players who received more than one penalty
SELECT pe.playerno, pl.initials FROM penalties pe
JOIN players pl ON pe.playerno = pl.playerno 
GROUP BY pe.playerno, pl.initials
HAVING COUNT(*) > 1;

–7. in which years there were exactly 2 penalties
SELECT EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY')) AS year
FROM penalties
GROUP BY EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY'))
HAVING COUNT(*) = 2;

–8. NAME and INITIALS of the players who received 2 or more penalties over $40
SELECT  pe.playerno, pl.initials FROM penalties pe
JOIN players pl ON pe.playerno = pl.playerno
WHERE pe.amount > 40
GROUP BY pe.playerno, pl.initials
HAVING COUNT(*) > 1;

–9. NAME and INITIALS of the player with the highest penalty amount
SELECT  pe.playerno, pl.initials FROM penalties pe
JOIN players pl ON pe.playerno = pl.playerno
WHERE pe.amount = (SELECT MAX(amount) FROM penalties);


–10. in which year there were the most penalties and how many were there
SELECT * FROM (
SELECT year, count
FROM(
    SELECT EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY')) AS year, COUNT(*) AS count
    FROM penalties
    GROUP BY EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY'))
) ORDER BY count DESC
)WHERE ROWNUM = 1;
SELECT EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY')) AS year,
       COUNT(*) AS count
FROM penalties
GROUP BY EXTRACT(YEAR FROM TO_DATE(pen_date, 'DD-MM-YYYY'))
ORDER BY COUNT(*) DESC
FETCH FIRST 1 ROW ONLY;

–11. For each occurrence of a player in teams, show the PLAYERNO, TEAMNO, "WON - LOST" (nicely formatted, for example "3 - 2") sorted by the sum of lost Matches of this player in this team.
SELECT playerno, teamno, won || ' - ' || lost AS "Won - Lost"
FROM matches
ORDER BY playerno, teamno, lost;

–12-19 EmpDept query
–12. output of all employees from department 30 sorted by their salary starting with the highest salary.
SELECT * FROM emp WHERE deptno = 30
ORDER BY sal DESC;

–13. output of all employees sorted by job and within the job by their salary
SELECT * FROM emp
ORDER BY job, sal;

–14. output of all employees sorted by their year of employment in descending order and within the year by their name
SELECT * FROM emp
ORDER BY EXTRACT(YEAR FROM TO_DATE(hiredate, 'DD-MM-YYYY')) DESC, ename;

–15. output of all salesmen in descending order regarding the ratio commission to salary
SELECT * FROM emp
ORDER BY (NVL(comm, 0)/sal) DESC;

–16. output the average salary to each department number
SELECT deptno, AVG(sal) FROM emp
GROUP BY deptno;

–17. calculate the average annual salaries of those jobs that are performed by more than 2 employees
SELECT job, AVG(sal) FROM emp
GROUP BY job
HAVING COUNT(*) > 2;

–18. output all department numbers with at least 2 office workers
SELECT deptno FROM emp
GROUP BY deptno
HAVING COUNT(*) > 1;

–19. find the average value for salary and commission of all employees from department 30
SELECT AVG(sal), AVG(NVL(comm, 0)) AS "AVG(COMM)" FROM emp
WHERE deptno = 30;
