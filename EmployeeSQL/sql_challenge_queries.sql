--1. List the following details of each employee: employee number, last name, first name, gender, and salary.
select e.emp_no  "Employee Number",e.last_name "Last Name",e.first_name "First Name",e.gender,s.salary
from employees e
left join
salaries s
on e.emp_no = s.emp_no;


--2. List employees who were hired in 1986.
select e.emp_no, e.first_name,e.last_name,e.hire_date from employees e
where EXTRACT(YEAR FROM e.hire_date ) = '1986';

--3.List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

--3(a)The query below gives each department's manager information , and additionally shows the start_date and end_date for each record
select d.dept_no "Department Number",d.dept_name "Department Name",
dm.emp_no "Manager Employee Nbr",e.first_name "First Name",
e.last_name "Last Name" ,dm.from_date "Start Date",dm.to_date "End Date" 
from departments d 
left join
dept_manager dm
on d.dept_no = dm.dept_no
inner join
employees e
on dm.emp_no = e.emp_no
order by 1,2,3;

--3(b)The query below gives each department's most recent manager information.
select d.dept_no "Department Number",d.dept_name "Department Name",
dm.emp_no "Manager Employee Nbr",e.first_name "First Name",
e.last_name "Last Name" ,dm.from_date "Start Date",dm.to_date "End Date" 
from departments d 
left join
dept_manager dm
on d.dept_no = dm.dept_no
inner join
 (select dm.dept_no, max(to_date) as to_date from 
 dept_manager dm
 group by dm.dept_no) max_dt
on dm.dept_no = max_dt.dept_no
and dm.to_date = max_dt.to_date
inner join
employees e
on dm.emp_no = e.emp_no;

--4.List the department of each employee with the following information: employee number, last name, first name, and department name.

--4(a)The query below gives each employees' department information , whether or not that's their most current department
select e.emp_no  "Employee Number",e.last_name "Last Name",e.first_name "First Name",d.dept_name "Department Name",
de.from_date "Start Date",de.to_date "End Date"
from employees e
left join
dept_emp de
on e.emp_no = de.emp_no
inner join
departments d
on de.dept_no = d.dept_no ;

--4(b)The query below gives each employees' most recent department information.
--since Question 6 and 7 require to list employees who are in Sales /Development departments , we will need to 
--use the same query again in both places. Hence, creating a view will help.
CREATE OR REPLACE VIEW Emp_Dept_current as
select e.emp_no "Employee Number" ,e.last_name "Last Name",e.first_name "First Name",d.dept_name "Department Name"
from employees e
left join
dept_emp de
on e.emp_no = de.emp_no
inner join 
 (select de.emp_no, max(to_date) as to_date from 
 dept_emp de
 group by de.emp_no) max_dt
on de.emp_no = max_dt.emp_no
and de.to_date = max_dt.to_date
inner join
departments d
on de.dept_no = d.dept_no;

--The query below gives each employees' most recent department information.
select * from Emp_Dept_current;

--5.List all employees whose first name is "Hercules" and last names begin with "B"

select e.emp_no  "Employee Number",e.last_name "Last Name",e.first_name "First Name"
from employees e
where e.first_name = 'Hercules' and upper(e.last_name) like 'B%';

--6.List all employees in the Sales department, including their employee number, last name, first name, and department name.
--6(a) The below query lists all employees in the sales department irrespective of whether or not their most recent department is Sales 
select e.emp_no  "Employee Number",e.last_name "Last Name",e.first_name "First Name",d.dept_name "Department Name"
from employees e
inner join
dept_emp de
on e.emp_no = de.emp_no
inner join
departments d
on de.dept_no = d.dept_no 
where lower(dept_name) = 'sales';

--6(b) The below query lists all employees whose current department is sales 
select * from Emp_Dept_current
 where lower("Department Name") = 'sales';

--7.List all employees in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
--7(a) The below query lists all employees in the sales and Development department irrespective of whether or not their most recent department is Sales 
select e.emp_no  "Employee Number",e.last_name "Last Name",e.first_name "First Name",d.dept_name "Department Name"
from employees e
inner join
dept_emp de
on e.emp_no = de.emp_no
inner join
departments d
on de.dept_no = d.dept_no 
where ( lower(dept_name) = 'sales' or lower(dept_name) = 'development');

--7(b)The below query lists all employees whose current department is sales and development
select * from Emp_Dept_current
 where ( lower("Department Name") = 'sales' or lower("Department Name") = 'development');
 
 
--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
select last_name as "Last Name",count(*) as "Count of Employees" from employees
group by last_name
order by 2 desc;



