--SQL Exercise 10
--to the tennis club tables

SET AUTOCOMMIT OFF;

– 1. insert a new record in the PLAYERS table (use your own data)

INSERT INTO PLAYERS (playerno, name, initials, year_of_birth, sex, year_joined, street, houseno, postcode, town, phoneno, leagueno)
VALUES (101, 'Doe', 'JD', 1980, 'M', 1990, 'Main Street', '111', '1113RT', 'Anytown', '070-777777', 7777);

– 2. change the value 'F' in the column SEX to 'W
UPDATE PLAYERS 
SET sex = 'W' 
WHERE sex = 'F';


– 3. increase all penalties above the average by 20%.
UPDATE penalties
SET amount = amount * 1.2;

– 4. the player with the number 95 gets the address of the player with the number 6
UPDATE PLAYERS
SET (STREET, HOUSENO, POSTCODE, TOWN) =
    (SELECT STREET, HOUSENO, POSTCODE, TOWN FROM PLAYERS WHERE PLAYERNO = 6)
WHERE PLAYERNO = 95;

– 5.  deleting all penalties of player 44 from 1980
DELETE FROM PENALTIES
WHERE PLAYERNO = 44
AND EXTRACT(YEAR FROM PEN_DATE) = 1980;

– 6. persist changes from 1.-5.
COMMIT

– 7. deleting all penalties of players who have played at least once in a team of the second division
DELETE FROM PENALTIES
WHERE PLAYERNO IN (
    SELECT PLAYERNO FROM MATCHES WHERE TEAMNO = 2);

– 8. deleting from 7. undoing
ROLLBACK;

--to EMP-DEPT
– 9 delete all salaries that are lower than 80% of the average salary of the department, set to 80% of the average salary of the department
UPDATE emp
SET sal = 0.8 * (SELECT AVG(sal) FROM emp e WHERE e.deptno = emp.deptno)
WHERE sal < 0.8 * (SELECT AVG(sal) FROM emp e WHERE e.deptno = emp.deptno);

– 2 delete all employees who have been with the company for more than 35 years
DELETE FROM emp
WHERE hiredate < TRUNC(SYSDATE) - INTERVAL '35' YEAR;

– 3 create a number sequence with the values 50, 60, 70, 80, …
CREATE SEQUENCE num_seq
    START WITH 50
    INCREMENT BY 10;

– 4 insert a new record in the DEPT table with DEPTNO corresponding to the number sequence from 3., DNAME 'HTL' and LOC 'LEONDING'.
INSERT INTO DEPT (DEPTNO, DNAME, LOC)
VALUES (num_seq.NEXTVAL, 'HTL', 'LEONDING');
