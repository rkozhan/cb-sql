--SQL Exercise 9
– 1) The management would like a list of the different salaries per job. The output should contain the job_id as well as the sum of the salaries per job_id. In addition, the output should be sorted in descending order according to the sum of the salaries.
SELECT job_id, SUM(salary)
FROM employees
GROUP BY job_id
ORDER BY SUM(salary) DESC;

– 2) The personnel department wants to have information about the average salary of the employees at the current time.
SELECT AVG(salary) FROM employees
    WHERE employee_id NOT IN (
        SELECT employee_id FROM job_history
     );

– 3) The personnel department would like a list of all employees (first name, last name), on which the department name (department_name) is also displayed.

SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

– 4) For the new stationery, the secretary's office needs a list of all departments (department_name) as well as their address consisting of the postal code, the city, the province, and the street_address
SELECT d.department_name, l.postal_code, l.city, l.state_province, l.street_address
FROM departments d
JOIN locations l ON d.location_id = l.location_id;

– 5) The secretariat thanks for the list, but would like to have the name of the country in addition.
SELECT d.department_name, l.postal_code, l.city, l.state_province, l.street_address, c.country_name
FROM departments d
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id;

– 6) The secretariat thanks for the updated list. Embarrassed, the first and last name as "Manager" of the respective manager of the department is now requested in addition.
SELECT d.department_name,
       l.postal_code,
       l.city,
       l.state_province,
       l.street_address,
       c.country_name,
       e.first_name AS mgr_first_name,
       e.last_name AS mgr_last_name
FROM departments d
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
LEFT JOIN employees e ON d.manager_id = e.employee_id;

– 7) The personnel department needs a list of the employees with the following contents:
7.1.) First and last name as "Name"
7.2.) job_title as "job"
7.3.) The salary
7.4.) The department name
SELECT
    e.first_name || ' ' || e.last_name AS Name,
    j.job_title AS Job,
    e.salary,
    d.department_name
FROM employees e
JOIN jobs j ON e.job_id = j.job_id
JOIN departments d ON e.department_id = d.department_id;


– 8) The new General Manager asks you to find out which subordinates each employee has. You could now collect the data manually, but something stirs inside you when you feel the challenge of generating the result via Oracle. Accept it!
SELECT e1.first_name || ' ' || e1.last_name AS mgr,
       e2.first_name || ' ' || e2.last_name AS subord
FROM employees e1
JOIN employees e2 ON e1.employee_id = e2.manager_id
START WITH e1.manager_id IS NULL
CONNECT BY PRIOR e2.employee_id = e2.manager_id
ORDER BY mgr;
