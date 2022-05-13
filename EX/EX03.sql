-- 그룹 함수의 특징 
-- •여러행으로부터 하나의 결과값을 반환 
-- • 집계함수, 그룹함수, 복수행 함

--   • 종류
-- – avg() : 평균값을 반환합니다. 
-- – count() : 총 건 수를 반환합니다. 
-- – count() :  count(*)  NULL 값을 포함한 전체 행의 개수
-- – count() : count(컬럼명)  NULL 값을 제외한 전체 행의 개수
-- – max() : 최대값을 반환합니다.
-- – min() : 최소값을 반환합니다. 
-- – sum() : 합계를 반환합니다
-- STDDEV() : 지정한 컬럼의 표준편차를 구하는 함수로 분산 값의 제곱근이다.

-- ROLLUP 함수(): 추가적인 집계 정보를 보여주는 함수이다.
-- (ROLLUP 절에 명시할 수 있는 표현식에는 그룹핑 대상, SELECT 리스트에서 집계함수를 
--제외한 컬럼의 표현식이 올 수 있다. 명시한 표현식 수와 순서에 따라 
--레벨 별로 집계한 결과가 변환된다.)
-- ROLLUP 함수를 쓰지 않고 데이터를 나열할 경우 일일이 전부 조건들에 맞춰 나열해야 한다

-- CUBE 함수
-- ROLLUP과 비슷하지만 개념이 다르다.
-- ROLLUP은 레벨 별로 순차적 집계를 했다면 CUBE는 명시한 표현식 
--개수에 따라 가능한 모든 조합별로 집계한 결과를 반환한다.

--그룹 함수의 예시
--avg
select avg(salary)
from employees;

--count
select count(*), count(commission_pct)
from employees;

select count(*)
from employees
where salary > 16000;

--sum
select count(*),
        sum(salary)
from employees;

--avg다중
select 
    count(*),
    sum(salary),
    avg(salary)
from employees;

select 
    count(*),
    sum(salary),
    avg(nvl(salary,0))
from employees;

SELECT
     count(*),
    sum(salary),
    avg(nvl(salary,0))
    round(avg(salary),0)
FROM employees;
    

--그룹함수 - max() / min()
--여러건의 데이터를 순서대로 정렬 후 값을 구하기때문에 데이터가 많을 때는 느리다
--(주의해서 사용)
select
    count(*),
    max(salary),
    min(salary)
from employees;

 --GROUP BY 절
SELECT
    first_name
FROM employees
where salary >16000
order by salary desc;

SELECT
    department_id ,
    avg(salary)
FROM employees
group by department_id
order by department_id asc;

SELECT
    department_id ,
    job_id,
    avg(salary),
    sum(salary),
    count(salary)
FROM employees
group by department_id, job_id
order by department_id asc;

--having 절
--정상
SELECT
    department_id,
    count(*),
    sum(salary)
FROM employees
group by department_id
having sum(salary)>= 20000 and sum(salary) <=100000
and department_id = 90;
--오류
SELECT
    department_id,
    count(*),
    sum(salary)
FROM employees
group by department_id
having sum(salary)>= 20000 and sum(salary) <=100000
and department_id = 90
and hire_data >= '04/01/01';

--CASE ~ END 문 / DECODE() 함수
--CASE ~ END 문
SELECT
    employee_id,
    salary,
    first_name,
    job_id,
    case   WHEN job_id = 'AC_ACCOUNT' THEN salary + salary * 0.1
            WHEN job_id = 'SA_REP' THEN salary + salary * 0.2
            WHEN job_id = 'ST_CLERK' THEN salary + salary * 0.3
            ELSE salary
    END realSalary
FROM employees;

--• == 일때만 가능
SELECT  
    employee_id,
    salary,
    first_name,
    job_id,
DECODE( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
'SA_REP', salary + salary * 0.2,
'ST_CLERK', salary + salary * 0.3,
salary ) realSalary
FROM employees;

-- DECODE 문
SELECT  
    employee_id,
    salary,
    first_name,
    job_id,
    DECODE( job_id, 'AC_ACCOUNT', salary + salary * 0.1,
                    'SA_REP', salary + salary * 0.2,
                    'ST_CLERK', salary + salary * 0.3,
                    salary ) realSalary
FROM employees;

--직원의 이름, 부서, 팀을 출력하세요
--팀은 코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
--60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요
SELECT 
    first_name,
    department_id,
    case when department_id>=10 and department_id<=50  then'A팀'
            when department_id>=60 and department_id<=100  then'B팀'
            when department_id>=110 and department_id<=150  then'C팀'
            else '팀없음'
    end team
FROM employees;

--JOIN
--JOIN 5줄 요약
--조인은 두 개의 테이블을 서로 묶어서 하나의 결과를 만들어 내는 것을 말한다.
--INNER JOIN(내부 조인 =교집합)은 두 테이블을 조인할 때, 두 테이블에 모두 지정한 열의 데이터가 있어야 한다.
--OUTER JOIN(외부 조인 = 합집합)은 두 테이블을 조인할 때, 1개의 테이블에만 데이터가 있어도 결과가 나온다.
--CROSS JOIN(상호 조인)은 한쪽 테이블의 모든 행과 다른 쪽 테이블의 모든 행을 조인하는 기능이다.
--SELF JOIN(자체 조인)은 자신이 자신과 조인한다는 의미로, 1개의 테이블을 사용한다.

--OUTER Join
-- • Join 조건을 만족하지 않는 컬럼이 없는 경우 Null을 포함하여 결과를 생성
-- • 모든 행이 결과 테이블에 참여
-- • NULL이 올 수 있는 쪽 조건에 (+)를 붙인다.

--종류
-- • Left Outer Join: 왼쪽의 모든 튜플은 결과 테이블에 나타남
-- • Right Outer Join: 오른쪽의 모든 튜플은 결과 테이블에 나타남
-- • Full Outer Join: 양쪽 모두 결과 테이블에 참여

SELECT
    employee_id as 사원_아이디,
    first_name 이름,
    salary 월급,
    department_id 부서_아이디
FROM employees;

select first_name, em.department_id, 
department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id;

select 
       em.first_name 직원이름, 
       de.department_name 부서명, 
       jo.job_title 업무명
from employees em,departments de,jobs jo
where em.department_id =de.department_id
and em.job_id = jo.job_id;