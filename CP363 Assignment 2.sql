
-- Query 1: Display the information of those employees who have salaries between 40000 and 50000 and are employee no. 10002.

SELECT e.emp_no, e.first_name, e.last_name, e.hire_date, s.salary 
FROM employees e 
INNER JOIN salaries s ON e.emp_no = s.emp_no 
WHERE s.salary BETWEEN 40000 AND 50000 AND e.emp_no = 10002;



-- Query 2: Write an SQL query to find those employees who joined in the 90s. Return complete information about the employees.

SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
 


-- Query 3: For each department, display the number of managers hired between 1981 and 1989.

SELECT d.dept_no, COUNT(*) AS manager_count
FROM dept_manager AS dm
JOIN departments AS d ON dm.dept_no = d.dept_no
WHERE dm.from_date BETWEEN '1981-01-01' AND '1989-12-31'
GROUP BY d.dept_no;

-- Query 4: Write an SQL query to find those employees whose names end with 'S' and are six characters long.

SELECT * 
FROM employees 
WHERE last_name LIKE '______S';



-- Query 5: Write an SQL query to find those employees whose salaries are in the range of minimum and maximum.

SELECT employees.emp_no, employees.first_name, employees.last_name, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no
WHERE salaries.salary BETWEEN (SELECT MIN(salary) FROM salaries) AND (SELECT MAX(salary) FROM salaries);
  

-- Query 6: Add a column to the employees' table to include the department ID. Also, ensure that it must contain a value and should begin with ‘d’. Update the values in the table as well.

ALTER TABLE employees ADD COLUMN department_id VARCHAR(10) NOT NULL DEFAULT 'd';

UPDATE employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
SET e.department_id= de.dept_no;
SELECT * FROM employees;


-- Query 7: Display the name of the employee and his/her department belonging to a department with less than 3 employees.

SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE de.dept_no IN (
    SELECT de.dept_no
    FROM dept_emp de
    GROUP BY de.dept_no
    HAVING COUNT(*) < 3
);


-- Query 8: Write an SQL query to display the first name, last name, no, and department name for all the employees.

SELECT e.first_name, e.last_name, e.emp_no, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no;


-- Query 9: Retrieve the details of all employees in Sales and Development (employee number, last name, first name, and department name).

SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
INNER JOIN dept_emp de ON e.emp_no = de.emp_no
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');


-- Query 10: Find the departments with more female employees than male.

SELECT d.dept_name 
FROM departments d 
INNER JOIN dept_emp de ON d.dept_no = de.dept_no 
INNER JOIN employees e ON de.emp_no = e.emp_no 
WHERE e.gender = 'F' 
GROUP BY d.dept_no, d.dept_name 
HAVING COUNT(*) > (
    SELECT COUNT(*) 
    FROM dept_emp de_inner 
    INNER JOIN employees e_inner ON de_inner.emp_no = e_inner.emp_no 
    WHERE e_inner.gender = 'M' 
    AND de_inner.dept_no = d.dept_no
);


-- Query 11: Print the age difference between the oldest and the youngest employee in the Production department.

SELECT 
    MAX(TIMESTAMPDIFF(YEAR, e.birth_date, CURDATE())) - MIN(TIMESTAMPDIFF(YEAR, e.birth_date, CURDATE())) AS age_difference
FROM 
    employees e
INNER JOIN 
    dept_emp de ON e.emp_no = de.emp_no
INNER JOIN 
    departments d ON de.dept_no = d.dept_no
WHERE 
    d.dept_name = 'Production';
