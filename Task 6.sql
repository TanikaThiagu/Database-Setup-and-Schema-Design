-- 1. Subquery in WHERE using IN
SELECT employee_name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'New York'
);

-- 2. Subquery in WHERE using EXISTS
SELECT employee_name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.employee_id = e.employee_id
);

-- 3. Scalar Subquery in SELECT
SELECT employee_name,
       salary,
       (SELECT AVG(salary) FROM employees) AS avg_salary
FROM employees;

-- 4. Correlated Subquery
SELECT employee_name, salary
FROM employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM employees e2
    WHERE e1.department_id = e2.department_id
);

-- 5. Subquery in FROM
SELECT dept_avg.department_id, dept_avg.avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS dept_avg;

-- 6. Nested Query using =
SELECT employee_name
FROM employees
WHERE salary = (
    SELECT MAX(salary)
    FROM employees
);