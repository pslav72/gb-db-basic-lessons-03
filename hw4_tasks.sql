-- 1. Создать VIEW на основе запросов, которые вы сделали в ДЗ к уроку 3.
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `employee_max_salary` AS
    SELECT 
        CONCAT(`employees`.`first_name`,
                ' ',
                `employees`.`last_name`) AS `employee`,
        `subq`.`salary` AS `max_salary`
    FROM
        (`employees`
        JOIN (SELECT 
            MAX(`salaries`.`salary`) AS `salary`,
                `salaries`.`emp_no` AS `emp_no`
        FROM
            `salaries`
        GROUP BY `salaries`.`emp_no`) `subq` ON ((`subq`.`emp_no` = `employees`.`emp_no`)))
    ORDER BY `subq`.`salary` DESC

-- 2. Создать функцию, которая найдет менеджера по имени и фамилии.
CREATE DEFINER=`root`@`%` FUNCTION `find_employee`(first_name text, last_name text) RETURNS text CHARSET utf8mb4
    DETERMINISTIC
BEGIN
declare emp_name text;
SELECT 
    CONCAT(`employees`.`first_name`,
            ' ',
            `employees`.`last_name`)
INTO emp_name FROM
    employees,
    dept_manager
WHERE
    employees.first_name = first_name
        AND employees.last_name = last_name
        AND employees.emp_no = dept_manager.emp_no;
RETURN emp_name;
END

-- 3.  Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.
CREATE DEFINER=`root`@`%` TRIGGER `new_employee_add_salary` AFTER INSERT ON `employees` FOR EACH ROW BEGIN
INSERT INTO salaries  (emp_no, salary, from_date, to_date) VALUES (NEW.emp_no,20000,'2020-12-12','2020-12-13');
END