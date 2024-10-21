–SQL Exercise 8

–2. display the whole hierarchy of those parts that make up P3 and P9
SELECT * FROM parts
START WITH sub = 'P3' OR sub = 'P9'
CONNECT BY PRIOR sub = super;

–3. at which hierarchy level is P12 used in P1
SELECT level FROM parts
START WITH sub = 'P1'
CONNECT BY PRIOR super = sub
AND level > 1
AND sub = 'P12';

– 4.how many parts to P1 cost more than $20
SELECT COUNT(*)
FROM (
    SELECT * FROM parts3
    START WITH sub = 'P1'
    CONNECT BY PRIOR sub = super
)
WHERE price > 20;

– 5. output of all direct and indirect employees belonging to JONES (without JONES itself, with corresponding indentation per hierarchy)
SELECT LPAD(' ', 4 * (level -1)) || ename AS Tree
FROM emp
WHERE ename != 'JONES'
START WITH ename = 'JONES'
CONNECT BY PRIOR empno = mgr;


– 6. output of all direct and indirect superiors of SMITH (including SMITH itself)
SELECT LPAD(' ', 4 * (level -1)) || ename AS Tree
FROM emp
START WITH ename = 'SMITH'
CONNECT BY PRIOR mgr = empno;

– 7. output of the average salary for each hierarchy level
SELECT level, AVG(sal) FROM emp
START WITH mgr IS NULL
CONNECT BY mgr = PRIOR empno
GROUP BY level;
