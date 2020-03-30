--Dropping tables if they exist, to make the script rerunnable
DROP TABLE IF EXISTS employees,salaries,titles,departments,dept_emp,dept_manager;

--Creating Employees table where Emp_no is the primary key
CREATE TABLE employees (
    emp_no int   PRIMARY KEY,
    birth_date date,
    first_name varchar(30),
    last_name varchar(30),
    gender char(1),
    hire_date date 
);

--Creating Salaries table. This Table has From_date and to_date determining the salary of an employee in a time period
--Since one employee can have different salries in different time periods, there is a one to many relationship between employees and salaries
--combination of emp_no,from_date and to_date is unique
CREATE TABLE salaries (
    emp_no int,
    salary int NOT NULL,
    from_date date,
    to_date date,
    UNIQUE (emp_no,from_date,to_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

--Creating titles table. This Table has From_date and to_date determining the title of an employee in a time period
--The columns that uniquely identify data in this table is emp_no ,from_date and to_date 
--Since one employee can have different title in different time periods, there is a one to many relationship between employees and titles
CREATE TABLE titles (
    emp_no int,
    title varchar(30) NOT NULL,
    from_date date,
    to_date date,
	UNIQUE (emp_no,from_date,to_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

--Creating departments table where dept_no is the primary key
CREATE TABLE departments (
    dept_no varchar(10) PRIMARY KEY,
    dept_name varchar(30)
);

--Creating dept_emp table. This Table has From_date and to_date determining the employees's department at the given time period
--The columns that uniquely identify data in this table are emp_no,from_date and to_date
--One employee can be assigned to differnt departments at different time periods. hence there is a one to many relationship.
--Department number should be availbale in departments table, hence a foreign key is required
CREATE TABLE dept_emp (
    emp_no int  ,
    dept_no varchar(10) NOT NULL,
    from_date date,
    to_date date,
    UNIQUE (emp_no,from_date,to_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);

--Creating dept_manager table. This Table has From_date and to_date determining the department's manager at the given time period
-- The columns that uniquely identify data in this table is  dept_no ,from_date and to_date
--One department can have different managers at different time periods. hence there is a one to many relationship.
--Employee number should be availbale in Employees table, hence a foreign key is required
CREATE TABLE dept_manager (
    dept_no varchar(10),
    emp_no int,
    from_date date,
    to_date date,
    UNIQUE (dept_no,from_date,to_date),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no)
);
