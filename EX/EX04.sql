--left join
SELECT
    e.first_name,
    e.department_id,
    d.department_id,
    d.department_name
FROM employees e left OUTER JOIN departments d
ON e.department_id = d.department_id;

SELECT
    e.first_name,
    e.department_id,
    d.department_id,
    d.department_name
FROM employees e,departments d
where d.department_id = e.department_id(+);

--right join
select 
    e.department_id,
    e.first_name,
    d.department_name
from employees e right outer join departments d
on e.department_id = d.department_id ;

select 
    e.department_id, 
    e.first_name, 
    d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id ; 

--full outer join
select 
    e.department_id,
    e.first_name,
    d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id ; 

-- Self Join

select 
    emp.employee_id,
    emp.first_name, 
    emp.manager_id,
    man.first_name as manager 
from employees emp, employees man
where emp.manager_id = man.employee_id;

--SubQuery
select employee_id, first_name, salary
from employees
where salary > (select salary
                from employees
                where first_name='Den');
                
--단일행 SubQuery
--예제1
select 
    first_name, 
    salary, 
    employee_id
from employees
where salary = (select min(salary)
                from employees);

--예제2
select 
    first_name, 
    salary, 
    employee_id
from employees
where salary < all(select avg(salary)
                    from employees);
