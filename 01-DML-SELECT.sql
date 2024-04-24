--SQL 문장의 주석
-- 마지막에 세미콜론(;)으로 끝난다
-- 키워드들 테이블병 컬럼 등은 대소문자 구분하지 않는다
-- 실제 데이터의 경우 대소문자를 구분

-- 테이블 구조 확인 (DESCRIBE)
DESCRIBE employees;
describe EMPLoyees;
describe Departments;
describe locations;

-- DML (Data Manipulation Language)
-- SELECT
-- * : 테이블 내의 모든 컬럼 Projection, 테이블 설계시에 정의한 순서대로
select * from employees;

--특정 컬럼만 Projection 하고자 하면 열 목록을 명시

-- employees 테이블의 first_name, phone_number, hire_date, salary 만 보고 싶다면
select first_name, phone_number, hire_date, salary from employees;

-- 사원의 이름, 성, 급여, 전화번호, 입사일 정보 출력
select first_name, last_name, salary, phone_number, hire_date
from employees;

-- 사원 정보로부터 사번,, 이름, 성 정보 출력
select employee_id, first_name, last_name from employees;

-- 산술 연산 : 기본적인 산술연산을 수행할 수 있다.
-- 특정 테이블의 값이 아닌 시스템으로부터 데이터를 받아오고자 할때 : dual (가상테이블)
select 3.141592 * 10 *10 from dual;

-- 특정 컬럼의 값을 산술 연산에 포함
select first_name, salary, salary * 12 from employees;

-- 다음 문장 실행 ㄱ
select job_id, job_id * 12 from employees;
-- 오류의 원인 : job_id 는 문자열 (varchar2)
desc employees;

