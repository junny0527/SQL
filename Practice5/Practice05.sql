--문제1.
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
--이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
select  first_name 이름,
        manager_id 매니저아이디,
        commission_pct "커미션 비율",
        salary 월급
from employees
where commission_pct is null
and salary > 3000
and manager_id is not null;


--문제2. 
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 
--이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 
--부서번호(department_id) 를 조회하세요 
--조건절비교 방법으로 작성하세요
--급여의 내림차순으로 정렬하세요
--입사일은 2001-01-13 토요일 형식으로 출력합니다.
--전화번호는 515-123-4567 형식으로 출력합니다.

select 
    employee_id 직원번호, 
    first_name 이름,
    salary 급여,
    to_char(hire_date,'YYYY-MM-DD day') 입사일,
    replace(phone_number,'.','-') 전화번호,
    department_id 부서번호
from employees
where (department_id, salary) in (select department_id, max(salary)
                                    from employees
                                    group by department_id)                                    
order by salary desc;

--문제3
--매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
--통계대상(직원)은 2005년 이후(2005년 1월 1일 ~ 현재)의 입사자 입니다.
--매니저별 평균급여가 5000이상만 출력합니다.
--매니저별 평균급여의 내림차순으로 출력합니다.
--매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
--출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 
--매니저별최대급여 입니다.
select  
        em.manager_id 매니저아이디,
        em.first_name 매니저이름,
        tas.avs 매니저평균급여,
        tas.mis 매니저최소급여,
        tas.mas 매니저최대급여
from employees em , (select  round(avg(salary),1) avs
                            ,min(salary) mis 
                            ,max(salary) mas
                            ,manager_id
                    from employees
                    where hire_date >= '05/01/01'
                    group by manager_id) tas
where em.employee_id = tas.manager_id
and tas.avs >= 5000
order by tas.avs desc;




--문제4.
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 
--부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
--부서가 없는 직원(Kimberely)도 표시합니다.
select  
        em.employee_id 사번,
        em.first_name 이름,
        de.department_name 부서명,
        ma.first_name 매니저이름
from employees em , departments de , employees ma
where em.employee_id = ma.manager_id
and em.department_id = de.department_id (+);

--문제5.
--2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
--사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
select
        rn 번호,
        employee_id 사번,
        first_name 이름,
        department_name 부서명,
        salary 급여,
        hire_date 입사일
from(select  rownum rn
             ,employee_id
             ,first_name
             ,department_name
             ,salary
             ,hire_date
     from (select  
                   em.employee_id,
                   em.first_name,
                   de.department_name,
                   em.salary,
                   em.hire_date
           from employees em , departments de
           where hire_date >= '05/01/01'
           and em.department_id = de.department_id
           order by hire_date asc))
where rn >= 11
and rn <= 20;

--문제6
--가장 늦게 입사한 직원의 이름(first_name last_name)과 
--연봉(salary)과 근무하는 부서 이름(department_name)은?
select  max(hire_date)
from employees
;

select  
        first_name||' '||last_name 이름,
        salary 연봉,
        department_name 부서이름,
        em.hire_date 입사일
from employees em , departments de
where hire_date in(select  max(hire_date)
                   from employees)
and em.department_id = de.department_id;

--문제7.
--평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 
--이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
select  
        em.employee_id 사번,
        em.first_name 이름,
        em.last_name 성,
        jo.job_title 업무,
        em.salary 연봉,
        tas.mas 평균연봉
from employees em , jobs jo ,(select max(salary) mas
                            from (select  avg(salary) salary
                                          ,department_id
                                  from employees
                                  group by department_id)) tas
where em.department_id in (select  
                                department_id
                          from employees
                          group by department_id
                          having avg(salary) in (select max(salary)
                                                 from (select  
                                                        avg(salary) salary,
                                                            department_id
                                                       from employees
                                                       group by department_id)))
and em.job_id = jo.job_id
order by em.salary asc , em.department_id;

--문제8.
--평균 급여(salary)가 가장 높은 부서는?
SELECT
  em.department_name,
  de.department_name
FROM departments de,employees em
group by department_name
HAVING avg(salary) = (SELECT 
                            max(avg(salary))
                        from departments
                        GROUP by department_name);

--문제9.
--평균 급여(salary)가 가장 높은 지역은?
select 
	re.region_name
from employees em, departments de, locations lo, countries co, regions re
where em.department_id = de.department_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
group by re.region_name
having avg(salary) = (select max(avg(salary))
                        from employees em, departments de, locations lo, countries co, regions re
                        where em.department_id = de.department_id
                        and de.location_id = lo.location_id
                        and lo.country_id = co.country_id
                        and co.region_id = re.region_id
                        group by re.region_name);


--문제10.
--평균 급여(salary)가 가장 높은 업무는?
select 
	jo.job_title
from employees em, jobs jo
where em.job_id = jo.job_id
group by jo.job_title
having avg(salary) = (select max(avg(salary))
                        from employees em, jobs jo
                        where em.job_id = jo.job_id
                        group by jo.job_title);


