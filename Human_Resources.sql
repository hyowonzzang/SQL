
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
where lower(first_name) like '_am%';