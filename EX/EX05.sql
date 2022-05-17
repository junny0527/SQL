--'den' 보다 급여를 많은 사람의 이름과 급여는?

--11000 qhek rmqdufmf aksgdms tkfkadml dlfmarhk rmqdusms?

SELECT
    first_name,
    salary
FROM employees
where salary>=(SELECT salary
                FROM employees
                WHERE first_name = 'Den');
--부서번호가 110인 직원의 급여와 같은 모든 직원의
--사번, 이름, 급여를 출력하세요

select 
    first_name,
    salary
from employees
where salary IN(select salary
              from employees
              where department_id = 110);

--각 부서별로 최고급여를 받는 사원을 출력하세요
SELECT 
    employee_id,
    first_name,
    salary,
    department_id  
  FROM employees
 WHERE (department_id,salary) IN (SELECT department_id, MAX(salary)
                                  FROM employees
                                  GROUP BY department_id);
       
--다중행 SubQuery ANY
-->ANY 큰값부터 출력
select 
    first_name,
    salary
from employees
where salary > ANY(select salary
              from employees
              where department_id = 110);            
select 
    first_name,
    salary
from employees              
where salary > 12008
OR salary > 8300 ;

-- <ANY작은값부터 출력
select 
    first_name,
    salary
from employees
where salary < ANY(select salary
              from employees
              where department_id = 110);

--다중행 SubQuery  ALL
select 
    first_name,
    salary
from employees
where salary > ALl(select salary
                from employees
                where department_id = 110);
 
 -- 조건절에서 비교 vs 테이블에서 조인               
--조건절에서 비교
select 
    department_id, 
    employee_id, 
    first_name, 
    salary
from employees
where (department_id, salary) in (select department_id, max(salary)
                                        from employees
                                        group by department_id);

--테이블에서 조인
select 
    e.department_id, 
    e.employee_id, 
    e.first_name, 
    e.salary
from employees e, (select department_id, max(salary) salary
                    from employees
                    group by department_id) s 
where e.department_id = s.department_id
and e.salary = s.salary;

