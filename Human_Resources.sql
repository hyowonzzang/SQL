
select first_name ||''|| last_name as 이름, hire_date 입사일, phone_number 전화번호
, salary 급여, salary *12 연봉 from employees;

-- 특정 조건을 기준으로 레코르를 선택 (SELECTION)

-- 비교연산 : =, <>, >, >=, < , <=

-- 사원들 중, 급여가 15000 이상인 직원의 이름과 급여

select 
    first_name, salary 
from 
    employees
where 
    salary >= 15000;
    
-- 입사일이 07/01/01 이후인 직원들의 이름과 입사일

select
    first_name , hire_date
from
    employees
where 
    hire_date >= '17/01/01';
    
-- 급여가 14000 이하이거나, 17000 이상인 사원의 이름과 급여

select
    first_name , salary
from
    employees
where
    salary <=14000 
    or  salary >17000;
    
-- 급여가 14000 이상이고, 17000 미만인 사원의 이름과 급여

select
    first_name ,  salary
from 
    employees
where
    salary between 14000and 17000;
    
-- commissioin 을 받지 않는 사람들
select first_name, commission_ptc
from employees
where commission_pct is null;

-- commmission 을 받는 사람들
select first_name, commission_pct
from employees
where commission_pct is not null;

-- in 연산자 : 특정 집합의 요소와 비교
-- 사원들 중 10, 20 ,40번 부서에서 근무하는 직원들의 이름과 부서 아이디

select first_name , department_id
from employees
where department_id = 10 or department_id = 20 or department_id = 40;
-- 위 랑 같음.
select first_name , department_id
from employees
where department_id in (10,20,40);


------------------------ LIKE 연산 ------------------------------------------
-- 와일드카드를 이용한 부분 문자열 매핑
-- % : 0개 이상의 정해지지 않은 문자열
-- _ : 1개의 정해지지 않은 문자
-- 이름에 am을 포함하고 있는 사원의 이름과 급여 출력

-- 이름에 am을 포함하고 있는 사원의 이름과 급여 출력
select first_name, salary
from employees
where lower(first_name) like '%am%';

-- 이름의 두 번째 글자가 a인 사원의 이름과 급여
select first_name, salary
from employees
where lower(first_name) like '_am%';

-- 이름의 네 번째 글자가 a 인 사원의 이름과 급여
select first_name, salary
from employees
where lower(first_name) like '___am%';

-- 이름이 네글자인 사월들 중에서 두 번째 글자가 a 인 사원의 이름과 급여

select first_name, salary
from employees
where first_name like '_a__';

-- 부서 ID가 90인 사원 중, 급여가 20000 이상인 사원이름 , 급여
select first_name,salary
from employees
where department_id = 90 and salary >=20000;

select first_name,salary
from employees
where department_id in (90) and salary >=20000;

-- 입사일이 11/01/01~ 17/12/31 구간에 있는 사원의 목록
select first_name,hire_date
from employees
where hire_date >='11/01/01' and hire_date <= '17/12/31';

select first_name,hire_date
from employees
where hire_date between '11/01/01' and '17/12/31';

-- mannager_id가 100, 120, 147인 사원의 명단, manager_id
-- 1. 비교 연산자+논리 연산자의 조합
select first_name, manager_id
from employees
where manager_id = 100 or manager_id = 120 or manager_id = 147;
-- 2. in 연산자 이용
select first_name, manager_id
from employees
where manager_id in (100,120,147);
-- 두 쿼리를 비교
-----------------ORDER BY-------------------------


-- 특정 컬럼명, 연산식, 별칭, 컬럼 순서를 기준으로 레코드 정렬
--asc (오름차순 : default) , desc(내림차순)
-- 내림차순에 적용할 수 있고 , 로 구분

--부서 번호의오름차순으로 정렬, 부서번호 , 급여, 이름 출력
select department_id, salary ,first_name
from employees
order by department_id asc;

--급여가 10000 이상인 직원 대상, 급여의 내림차순으로 출력. 이름,급여
select first_name,salary
from employees
where salary >=10000
order by salary desc;

--부서 번호, 급여, 이름순으로 출력. 정렬기준 부서번호 오름차순, 급여 내림차순
select department_id, salary, first_name
from employees
order by department_id asc , salary desc;

--정렬 기준을 어떻게 세우느냐에 따라 출력 결과가 달라진다.

---------------------- 단일행 함수--------------------------


-- 단일 레코드를 기준으로 특정 컬럼에 값에 적용되는 함수

-- 문자열 단일행 함수
select first_name, last_name,
    concat(first_name, cancat(' ',last_name)), --문자열 연결함수
    first_name || ' ' || last_name, --문자열 연결 연산
    inicap(first_name || ' ' || last_name) --각 단어의 첫글자를 대문자로
from employees;

select first_name, last_name,
    lower(first_name),  -- 모두 소문자
    upper(first_name),  --모두 대문자
    lpad(first_name,20, '*'),   -- 왼쪽 빈 자리 채움
    rpad(first_name,20, '*')    -- 오른쪽 빈 자리 채움
    from employees;
    
select '   Oracle   ',
    '*****database*****',
    ltrim('   Oracle   '),    -- 왼쪽의 빈 공간 삭제
    rtrim('   Oracle   '),     -- 오른쪽의 빈 공간 삭제
    trim('*' from'*****database*****'),  -- 앞뒤의 잡음 문자 제거
    substr('Oracle Database',8,4),
    substr('Oracle Database'-8,4),
    length('Oracle Database')   -- 문자열 길이
from dual;

-- 수치형 단일행 함수

select 3.14159,
    abs(-3.14), -- 절대값
    ceil (3.14), -- 올림
    floor(3.14), -- 버림
    round(3.5), -- 반올림
    round(3.14159, 3) -- 소숫점 셋째 자리까지 반올림
    trunc(3.5), -- 버림
    trunc(3.14159, 3), -- 소숫점 넷째 자리에서 버림
    sign(-3.14159), -- 부호 (-1:음수, 0:0, 1:양수)
    mod(7, 3), -- 7을 3으로 나눈 나머지
    power(2, 4) -- 2의 4제곱
from dual;


-----------------------
-- 현재 세션 정보 확인
select * from nls_session_parameters;
-- 현재 날짜 포맷이 어떻게 되는가
-- 딕셔너리를 확인
select value from nls_session_parameters
where parameter='NLS_DATE_FORMAT';

select sysdate from employees;

select
    sysdate
    add_months(sysdate,2),
    last_day(sysdate),
    months_between('12/09/24', sysdate),
    next_day(sysdate, 7),
    next_day(sysdate, '일'),
    round(sysdate, 'month'),
    trunc(sysdate, 'month')
from dual;

select first_name, hire_date,
    round(months_between(sysdate, hire_date)) as 근속월수
    from employees;

------------------------------
-- 변환 함수
------------------------------

-- to_number(sm fmt) : 문자열 -> 숫자
-- to date(s,fmt) : 문자열 -> 날짜
-- to char(o, fmt) : 숫자, 날짜 - > 문자열

-- to_char

select first_name,
    to_char(hire_date,'YYYY-MM-DD HH24:MI:SS')
from employees;

-- 현재 시간을 년-월-일 시:분:초로 표기
select sysdate,
    to_char(sysdate, 'YYYY-MM-DD HH:MI:SS')
from dual;

select
    to_char(3000000, ' L999,999,999.99')
from dual;

-- 모든 직원의 이름과 연봉 정보를 표시
select
    first_name, to_char((salary + salary * nvl(commission_pct,0))*12, '$999,999.99') 연봉
from employees;

-- 문자 -> 숫자 : to_number
select
    to_number('$57,600','$999,999') / 12 월급
from dual;

-- 문자열 -> 날짜
select '2012-09-24 13:48:00'
    to_date('2012-09-24 13:48:00','YYYY-MM-DD HH24:MI:SS')
from dual;

-- 날짜 연산
-- Date +/- Number : 특정 날수를 더하거나 뺄 수 있다.
-- Date - Date : 두 날짜 사이의 경과 일 수
-- Date + Number / 24 : 특정 시간이 지난 후의 날짜
select
    sysdate,
    sysdate +1, sysdate -1
    sysdate - to_date('20120924'),
    sysdate + 48 / 24   -- 48시간이 지난 후의 날짜
from dual;


-- nvl function
select first_name, salary, nvl(salary * commission_pct,0) commission
from employees;

-- nvl2 function
select first_name,
salary,
nvl2(commission_pct, salary*commission_pct,0) commission --nvl2(조건문, null이 아닐때의값, null일떄의 값)
from employees;

-- CASE function
-- 보너스를 지급
-- AD관련 직종에게는 20%, SA관련 직원에게는 10%, IT관련직원에게는 8%, 나머지에게는 5%
select first_name, job_id, salary,
    substr(job_id,1,2),
    case substr(job_id,1,2) when 'AD' then salary*0.2
                            when 'SA' then salary*0.1
                            when 'IT' then salary*0.08
                            else salary*0.05
end bonus
from employees;

-- DECODE 함수
select first_name, job_id, salary,
    substr(job_id,1,2),
    decode(substr(1,2),   -- 비교할 값
                'AD', salary*0.2,
                'SA', salary*0.1,
                'IT', salary*0.08,
                salary*0.05)bonus
from employees;

-- 연습문제
-- 직원의 이름, 부서 팀 출력
--팀은 부서ID로 결정
-- 10~30: A-GROUP
-- 40~50: B-GROUP
-- 60~100: C-GROUP
-- 나머지 부서 : REMAINDER
select first_name, department_id,
    case when department_id <= 30 then'A-GROUP'
        when department_id <=50 then'B-GROUP'
        when department_id <=100 then'C-GROUP'
        else 'REMAINDER'
        end team
from employees
order by team asc, department_id asc;

