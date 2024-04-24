
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
