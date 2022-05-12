/************************
select 문
    select 절
    from 절
**************************/

-- 모든컬럼 조회

select *
from employees;

select *
from departments;

-- 원하는 컬럼만 조회하기

select employee_id,  first_name,  last_name
from employees;


-- 예제)
-- 사원의 이름(first_name) 과 전화번호 입사일 연봉을 출력하세요
select *
from employees;

select first_name, phone_number, hire_date, salary
from employees;

--사원의 이름(first_name)과 성(last_name) 급여, 전화번호 ,이메일, 입사일을 출력하세요
select first_name
       ,last_name
       ,salary
       ,phone_number
       ,email
       ,hire_date
from employees;

select first_name "이름"
       ,phone_number "전화번호"
       ,hire_date "입사일"
       ,salary "급여"
from employees;

--사원의 사원번호 이름 성 급여 전화번호 이메일 입사일로 표기
select first_name as 이름
       ,last_name 성
       ,salary 급여
       ,phone_number 전화번호
       ,email 이메일
       ,hire_date 입사일
from employees;

--연결 연산자(커럼을 붙이기)
select first_name || last_name
from employees;

select first_name || ' ' ||last_name
from employees;

select first_name || ' hire date is ' || hire_date 입사일
from employees;

--산술 연산자
select first_name , 
       salary, 
       salary*12,
       (salary+300)*12
from employees;

select first_name || '-' || last_name 성명
       ,salary 급여
       ,salary*12 연봉
       ,salary*12+5000 연봉2
       ,phone_number 전화번호
from employees;

/* where절 */
select *
from employees
where department_id = 10;

--예제 1
select first_name
       ,salary
from employees
where salary >=15000;
--예제 2
select first_name
       ,hire_date
from employees
where hire_date > '07/01/01';
--예제3
select salary
from employees
where first_name = 'Lex';

-- 조건이 2개이상 일때 한꺼번에 조회하기
-- 연봉이 14000이상 17000이하인 사원의 이름과 연봉을 구하시오
select first_name
       ,salary
from employees
where salary >= 14000
and salary <= 17000;

-- 연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select first_name 이름 
       ,salary 연봉
from employees
where salary >= 14000
and salary <= 17000;

--BETWEEN 연산자로 특정구간 값 출력하기
--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name 이름
       ,hire_date 입사일
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31';

--IN 연산자로 여러 조건을 검사하기
select first_name
       ,last_name
       ,salary
from employees
where first_name in ('Neena', 'Lex', 'John');
-- 연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오
select first_name
       ,salary
from employees
where salary in (2100, 3100, 4100, 5100);
--다른방법
select first_name
       ,salary
from employees
where salary = 2100
or salary = 3100
or salary = 4100
or salary = 5100;

--Like 연산자로 비슷한것들 모두 찾기
select first_name
       ,last_name
       ,salary
from employees
where first_name like 'L___';
-- 상관없을땐 % 글자수 _ 하나씩 추가
select first_name
       ,last_name
       ,salary
from employees
where first_name like '%s%';

--예제
-- 이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요
select first_name
       ,salary
from employees
where first_name like '%am%';
--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요
select first_name
       ,salary
from employees
where first_name like '_a%';
--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '___a%';
--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name
from employees
where first_name like '_a__';

select first_name
       ,salary
       ,commission_pct
       ,salary*commission_pct
from employees
where salary between 13000 and 15000;
--•null을 포함한 산술식은 null
select first_name, salary, commission_pct, salary*commission_pct
from employees
where salary between 13000 and 15000
--is null
select 
    first_name,
    salary,
    commission_pct
from employees
where commission_pct is null; 
--is not null
select 
    first_name,
    salary,
    commission_pct
from employees
where commission_pct is not null; 
--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select 
    first_name,
    salary,
    commission_pct
from employees
where commission_pct is not null; 
--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요
select 
    first_name,
    salary,
    commission_pct
from employees
where manager_id is null and commission_pct is  null; 
--order by 절을 사용해 보기 좋게 정렬하기
--연습1
select 
    first_name
    , salary
from employees
order by salary desc;
--연습2
select 
    first_name,
    salary
from employees
where salary >= 9000
order by salary desc;
--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요
select 
    department_id,
    first_name,
    salary
from employees
order by department_id asc;
--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select 
    first_name,
    salary
from employees
where salary >=10000
order by salary asc;
--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요
select 
    department_id,
    first_name,
    salary
from employees
order by department_id asc,salary desc, first_name desc;
--문자함수 – INITCAP(컬럼명)
--부서번호가 100인 직원의 이메일주소와 부서번호
select
    email,
    initcap(email),
    department_id
from employees
where department_id = 100;

--문자함수 – LOWER(컬럼명) / UPPER(컬럼명)

select 
    first_name,
    lower(first_name),
    upper(first_name)
from employees
where department_id = 100;

--문자함수 – SUBSTR(컬럼명, 시작위치, 글자수)
select 
    first_name,
    substr(first_name,1,3),
    substr(first_name,-3,2)
from employees
where department_id = 100;
--문자함수 – LPAD(컬럼명, 자리수, ‘채울문자’) / RPAD(컬럼명, 자리수, ‘채울문자’)
--LPAD() :왼쪽 공백에 특별한 문자로 채우기
--RPAD() :오른쪽 공백에 특별한 문자로 채우기
select 
    first_name, 
lpad(first_name,10,'*'), 
rpad(first_name,10,'*')
from employees;
--문자함수 – REPLACE (컬럼명, 문자1, 문자2)
select 
    first_name, 
    replace(first_name, 'a', '*') 
from employees
where department_id =100;
--------------------------------
select 
    first_name, 
    replace(first_name, 'a', '*'), 
    replace(first_name, substr(first_name, 2, 3), '***')
from employees
where department_id =100;
-------------------------------숫자함수의 종류----------------------
--  -Function-     -설명-                        -Example-     -Result-
--| ABS(n)     | 절대값                       |ABS(-5)       | 5                             
--| CEIL(n)    | n 보다 크거나 같은 최소 정수   |CEIL(-2.4)    | -2                         
--| FLOOR(n)   | n 보다 작거나 같은 최대 정수   |FLOOR(-2.4)   | -3            
--| MOD(m,n)   | 나머지                       |MOD(13,2)     |1                                   
--| POWER(m,n) | m의 n승                     |POWER(2,3)     |8                              
--| ROUND(m,n) | 소수점아래 n자리까지 반올림    |ROUND(4.567,2) | 4.57       
--| TRUNC(m,n) | 소수점아래 n자리미만 버림      |TRUNC(4.567,2) | 4.56        
--| SIGN(n)    | 부호 (1, 0, -1)             |SIGN(-10)      |-1                               
-------------------------------------------------------------------
--숫자함수 – ROUND(숫자, 출력을 원하는 자리수)
select 
    round(123.346, 2) "r2",
    round(123.456, 0) "r0",
    round(123.456, -1) "r-1"
from dual;
--숫자함수 – TRUNC(숫자, 출력을 원하는 자리수)
select 
    trunc(123.346, 2) "r2",
    trunc(123.456, 0) "r0",
    trunc(123.456, -1) "r-1"
from dual;
-------------------------------날짜함수의 종류----------------------
--     -FUNCTION-                     -Purpose-
--| ADD_MONTHS(d,n)       |       d날짜에 n달 더함    
--| LAST_DAY(d)           |       d의 달의 마지막 날      
--| MONTHS_BETWEEN(d1,d2) |       d1, d2사이의 달 수           
--| NEW_TIME(d,z1,z2)     |       z1타임존의 d에서 z2타임존의 날짜 생성                                   
--| NEXT_DAY(d,day)       |       d날 후의 첫 day요일의 날짜                              
--| ROUND(d,fmt)          |       fmt에 따른 날짜반올림    
--| TRUNC(d,fmt)          |       fmt에 따른 날짜내림         
--| SYSDATE               |       현재 날짜 시간 반환                          
-------------------------------------------------------------------

-------------------------------날짜함수의 종류----------------------
--                   -FUNCTION-                     -RESULT-
--| MONTHS_BETWEEN ('01-SEP-95','11-JAN-94') |       19.677419    
--| ADD_MONTHS ('11-JAN-94',6)               |       '11-JUL-94‘     
--| NEXT_DAY ('01-SEP-95','FRIDAY')          |       '08-SEP-95‘          
--| LAST_DAY('01-FEB-95')                    |       '28-FEB-95‘
                       
-------------------------------------------------------------------

-----------------------현재날짜를 '25-JUL-95’가정----------------------
--| ROUND(SYSDATE,'MONTH'))       |      01-AUG-95   
--| ROUND(SYSDATE ,'YEAR')        |      01-Jan-96     
--| TRUNC(SYSDATE ,'MONTH')       |      01-JUL-95          
--| TRUNC(SYSDATE ,'YEAR')        |      01-JAN-95
                       
-------------------------------------------------------------------

--  날짜함수 – SYSDATE()
--보기1
select 
sysdate
from dual;
--보기2
select sysdate
from employees;

-- 단일함수>날짜함수 – MONTH_BETWEEN(d1, d2)
select 
MONTHS_BETWEEN(SYSDATE,hire_date)
from employees
WHERE department_id =110;
--변환함수의 종류
--| 숫자--TO_CHAR(n,fmt)-->문자열 ---TO_DATE(s,fmt)---->Date |
--| Date---TO_CHAR(d,fmt)----> 문자--TO_NUMBER(s,fmt) -->숫자 |

-------------- TO_CHAR(숫자, ‘출력모양’) 숫자형문자형으로 변환하기--------------
-- -종류-                -의미-                        -사용예-                -결과-      
--|  9  |  9의 개수 자리수 만큼표시(5자리까지표시) | to_char(9876,‘99999’)    | 9876    |     
--|  0  |  빈자리를 0으로 채우기                 | to_char(9876, ‘099999’)  | 009876  |
--|  $  |  $ 표시를 붙여서 표시                  | to_char(9876, $9999’)    | $9876   |
--|  .  |  소수점 이하를 표시                    | to_char(9876, ‘9999.99’) | 9876.00 |
--|  ,  |  천 단위 구분기호를 표시               | to_char(9876, ’99,999’)   | 9,876  |    
----------------------------------------------------------------------------
--예시
select 
    first_name,
    to_char(salary*12, '$999,999.99') "SAL"
from employees
where department_id =110;
-- 단일함수>변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하

------- 단일함수>변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하-----------
--   -출력모양-               -의미-                                -결과-
--|  ‘YYYY’    |    연도를 4자리로 표현합니다.                   |    2022   |
--|   ‘YY’     |    연도를 2자리로 표현합니다.                   |    17     |
--|   ‘MM’     |    월을 숫자2자리로 표현합니다.                 |    07     |
--|   ‘MON’    | 유닉스에서는 월을 뚯하는 영어 3글자를 표현합니다.  |  JUL      |
--                               +                            |           |
--    ‘MON’            윈도우는 ‘MONTH’와 동일 합니다            |  7월      |
--|  ‘MONTH’   |    월을 뜻하는 이름 전체를 표현합니다.           |  7월       |              
--|   'DD’     |    일을 숫자 2자리로 표현합니다.                |  15        |
--|   ‘DAY’    | 유닉스에서는 요일을 영문으로 표현 합니다.         |  SUN      |
--                                +                           |           |
--    ‘DAY’          윈도우에서는 요일을 한글로 표현 합니다.       | 토요일     |
--|  'DDTH’    |      몇번째 날인지 표현합니다.                  | 15TH      |
--|  ‘HH24’,   |      하루를 24시간으로 표현합니다.              |  19        |
--|   'HH’     |      하루를 12시간으로 표현합니다.              |  07        |
--|   ‘MI’     |      분으로 표현합니다.                        |  56        |
--|   'SS’     |      초로 표현합니다.                          |  41       |
-------------------------------------------------------------------

--변환함수>TO_CHAR(날짜, ‘출력모양’) 날짜문자형으로 변환하기
select 
    sysdate, 
    to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS')
from dual;
--원하는 문자는 “년” 형태로
--쌍따옴표로 추가 가능

--일반함수>NVL(컬럼명, null일때값)/NVL2(컬럼명, null아닐때값, null일때 값)
--NVL(조사할 컬럼, NULL 일 경우 치환할 값)
--NVL2(조사할 컬럼, NULL이 아닐때 치환할 값, NULL일때 치환할 값)
select 
    commission_pct, nvl(commission_pct, 0)
from employees;
    select commission_pct, nvl2(commission_pct, 100, 0)
from employees;
--평균같이 계산에 참여해야할 경우
--null을 0으로 변경해준다.
