
CREATE TABLE "DEPARTMENTS" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_DEPARTMENTS" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "DEPT_EMP" (
    "emp_no" INT   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_DEPT_EMP" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "DEPT_MANAGER" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "EMPLOYEES" (
    "emp_no" int   NOT NULL,
    "birth_date" varchar   NOT NULL,
    "first_name" varchar   NOT NULL,
    "last_name" varchar   NOT NULL,
    "gender" char   NOT NULL,
    "hire_date" date   NOT NULL
);

CREATE TABLE "SALARIES" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "TITLES" (
    "emp_no" int   NOT NULL,
    "title" varchar   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE PUBLIC."DEPARTMENTS" ADD CONSTRAINT "fk_DEPARTMENTS_dept_no" FOREIGN KEY("dept_no")
REFERENCES pUBLIC."DEPT_EMP" ("dept_no");

ALTER TABLE "DEPT_EMP" ADD CONSTRAINT "fk_DEPT_EMP_emp_no" FOREIGN KEY("emp_no")
REFERENCES "EMPLOYEES" ("emp_no");

ALTER TABLE "DEPT_EMP" ADD CONSTRAINT "fk_DEPT_EMP_dept_no" FOREIGN KEY("dept_no")
REFERENCES "DEPT_MANAGER" ("dept_no");

ALTER TABLE "DEPT_MANAGER" ADD CONSTRAINT "fk_DEPT_MANAGER_emp_no" FOREIGN KEY("emp_no")
REFERENCES "SALARIES" ("emp_no");

ALTER TABLE "EMPLOYEES" ADD CONSTRAINT "fk_EMPLOYEES_emp_no" FOREIGN KEY("emp_no")
REFERENCES "DEPT_MANAGER" ("emp_no");

ALTER TABLE "SALARIES" ADD CONSTRAINT "fk_SALARIES_emp_no" FOREIGN KEY("emp_no")
REFERENCES "TITLES" ("emp_no");

--1.
SELECT employee.emp_no, empployee.first_name, employee.last_name, employee.gender, salaries.salary
FROM employees 
RIGHT JOIN salaries 
ON (Salaries.emp_no = Employees.emp_no);

--2.
SELECT employee.emp_no, employee.first_name, employee.last_name, employee.hire_date
FROM employees
WHERE EXTRACT (YEAR FROM hire_date) = 1986;

--3
SELECT Departments.dept_no, Departments.dept_name, Dept_manager.emp_no, 
employees.first_name, employees.last_name, Dept_manager.from_date, Dept_manager.to_date
FROM Departments
JOIN Dept_manager
ON (Departments.dept_no = Dept_manager.dept_no)
JOIN employees
ON (Dept_manager.emp_no = employees.emp_no);

--4
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
JOIN departments
ON (dept_emp.dept_no = departments.dept_no);

--5
SELECT employees.emp_no, employees.first_name, employees.last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--6.
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
JOIN departments
ON (dept_emp.dept_no = departments.dept_no)


--7
SELECT employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp
ON (employees.emp_no = dept_emp.emp_no)
JOIN departments
ON (dept_emp.dept_no = departments.dept_no)

--8

SELECT employees.last_name, COUNT(employees.emp_no)
FROM employees 
GROUP BY employees.last_name 
ORDER BY COUNT(employees.emp_no) DESC;
