--문제 1
select  
		first_name
        ,salary
        ,phone_number
        ,hire_date
from employees
order by hire_date asc;

--문제 2
select  
		job_title
        ,max_salary
from jobs
order by max_salary desc;

--문제 3
select  manager_id
        ,commission_pct
        ,salary
from employees
where commission_pct is NULL
and salary > 3000;

--문제 4
select  job_title
        ,max_salary
from jobs
where max_salary >= 10000
order by max_salary desc;

--문제 5
select  first_name
        ,nvl(commission_pct, 0)
        ,salary
from employees
where salary >= 10000
and salary < 14000
order by salary desc;

--문제 6
select  first_name
        ,salary
        ,to_char(hire_date, 'YYYY-MM')
        ,department_id
from employees
where department_id in (10, 90, 100);

--문제 7
select  first_name
        ,salary
from employees
where first_name like '%S%'
or first_name like '%s%';

--문제 8
select department_name
from departments
order by length(department_name) desc;

--문제 9
SELECT  country_id  
        ,Upper(country_name)
        ,region_id
from countries
order by country_name asc;

--문제 10
select  first_name
        ,salary
        ,replace(phone_number, '.', '-')
        ,hire_date
from employees
where hire_date < '03/12/31';