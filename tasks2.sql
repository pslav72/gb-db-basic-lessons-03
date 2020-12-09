-- Выбрать среднюю зарплату по отделам.
SELECT 
    departments.dept_name AS department,
    AVG(salaries.salary) AS salary
FROM
    salaries
        JOIN
    (dept_emp, departments) ON (salaries.emp_no = dept_emp.emp_no
        AND dept_emp.dept_no = departments.dept_no)
GROUP BY department
ORDER BY salary DESC
;

-- Выбрать максимальную зарплату у сотрудника.
SELECT
    CONCAT(employees.first_name, " ", employees.last_name) AS employee,
    employees.emp_no AS employee_no,
	MAX(salaries.salary) AS salary
FROM
    salaries
        JOIN
    (employees) ON (salaries.emp_no = employees.emp_no)
GROUP BY salaries.emp_no
ORDER BY salary DESC
;

-- Удалить одного сотрудника, у которого максимальная зарплата.
DELETE employees FROM employees
        JOIN
    (SELECT 
        salaries.emp_no, MAX(salaries.salary) AS salary
    FROM
        employees
    JOIN (salaries) ON (salaries.emp_no = employees.emp_no)
    GROUP BY employees.emp_no
    ORDER BY salary DESC
    LIMIT 1) salary ON employees.emp_no = salary.emp_no
;

-- Посчитать количество сотрудников во всех отделах.
SELECT 
    departments.dept_name AS dept_name,
    COUNT(employees.emp_no) AS count
FROM
    departments
        JOIN
    (employees, dept_emp) ON (employees.emp_no = dept_emp.emp_no
        AND dept_emp.dept_no = departments.dept_no)
GROUP BY dept_name
;

-- Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
SELECT 
    deptname,
    COUNT(emp) AS count_emp,
    SUM(salary) AS salary_dept
FROM
    (SELECT 
        dept_emp.emp_no AS emp,
        dept_emp.dept_no AS dept,
        departments.dept_name AS deptname,
        SUM(salaries.salary) AS salary
    FROM
        salaries
    JOIN (dept_emp, departments) ON (salaries.emp_no = dept_emp.emp_no
        AND dept_emp.dept_no = departments.dept_no)
    GROUP BY salaries.emp_no , dept_emp.dept_no) AS subq
GROUP BY dept
;