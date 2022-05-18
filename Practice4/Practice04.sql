--문제1.
--평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요
SELECT
    count(salary) 총직원
FROM employees em
where salary < (SELECT
                avg(salary)
                FROM employees);
 
--문제2. 
--평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
--직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 
--최대급여를 급여의 오름차순으로 정렬하여 출력하세요

select  
        em.employee_id 직원번호,
        em.first_name 이름,
        em.salary 급여,
        ts.asl 평균급여,
        ms 최대급여
from employees em ,  (select avg(salary) asl
                            ,max(salary) ms
                     from employees) ts
where em.salary >= ts.asl
and em.salary <= ts.ms
order by salary asc;

--문제3.
--직원중 Steven(first_name) king(last_name)이 
--소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 
--도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요

SELECT 
    lo.location_id 도시아이디,
    lo.street_address 거리명,
    lo.postal_code 우편번호,
    lo.city 도시명,
    lo.state_province 주,
    lo.country_id 나라아이디
FROM  departments de,locations lo 
WHERE  de.department_id in ( SELECT
                                     de.department_id 
                                   FROM employees em,departments de
                                where em.first_name = 'Steven'
                                  and em.last_name = 'King'
                                  and em.department_id = de.department_id)
                                 and lo.location_id = de.location_id ;
--문제4.
--job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 
--`급여의 내림차순으로 출력하세요  -ANY연산자 사용
SELECT
        employee_id 사번,
        first_name 이름,
        salary 급여
FROM employees 
WHERE salary < ANY(SELECT
                        salary 
                    FROM employees
                    WHERE job_id = 'ST_MAN');
  
--문제5. 
--각 부서별로 최고의 급여를 받는 사원의 
--직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 
--조회하세요 
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--조건절비교, 테이블조인 2가지 방법으로 작성하세요


--조건절 비교
select 
    employee_id 직원번호, 
    first_name 이름,
    salary 급여,
    department_id 부서번호
from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)
                                    order by salary desc;
--테이블 조건
select 
    em.employee_id 직원번호, 
    em.first_name 이름, 
    em.salary 급여,
    em.department_id 부서번호 
from employees em, (select department_id, max(salary) salary
                    from employees
                    group by department_id) sa 
where em.department_id = sa.department_id
and em.salary = sa.salary
order by em.salary desc;

--문제6.
--각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 

SELECT
     jo.job_title 업무명,
     sum(em.salary) "연봉 총합"
FROM employees em ,jobs jo
where em.job_id = jo.job_id
GROUP BY jo.job_title;

--문제7.
--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 
--직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요
select    
    e.employee_id 사번,
    e.department_id 부서번호, 
    e.salary 월급
from      employees e, (select   department_id , round(avg(salary),0) sa 
                        from     employees 
                        group by department_id) em
where     em.department_id=e.department_id 
and e.salary > em.sa
order by  em.sa ;

--문제8.
--직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 
--입사일을 입사일 순서로 출력하세요


select rn, 
    employee_id 사번,
    first_name 이름, 
    salary 급여,
    hire_date 입사일
from(select 
                rownum rn,
                employee_id,
                first_name,
                salary,
                hire_date
            from(select 
                employee_id,
                first_name,
                salary,
                hire_date
     from employees
        order by hire_date asc ))
where rn >= 11
and rn <= 15;









              