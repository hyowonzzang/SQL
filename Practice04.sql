-- 문제1.
select count(salary)
from employees
where salary < (select avg(salary)from employees);

-- 문제2.
select employee_id "직원 번호",
first_name as "이름",
salary as "급여",
(select avg(salary) from employees) as "평균급여",
(select max(salary) from employees) as "최대급여"
from employees
where salary >= (select avg(salary) from employees) and salary <= (select max(salary) from employees)
order by salary asc;

-- 문제3.
select l.location_id "도시아이디",
street_address "거리명",
postal_code " 우편번호",
state_province "주",
country_id "나라아이디"
from employees e
join departments d on d.department_id = e.department_id
join locations l on d.location_id = l.location_id
where e.first_name ='Steven' and e.last_name = 'King';

-- 문제4.
select employee_id, first_name || ' ' || last_name, salary
from employees
where salary < any (select salary from employees where job_id = 'ST_MAN')
order by salary desc;

-- 문제5.
-- 조건절 비교
select employee_id "직원번호",
first_name "이름",
salary "급여",
department_id "부서번호"
from employees
where (department_id, salary) in  (select department_id, max(salary) from employees
group by department_id)
order by salary desc;

--테이블조인
select e.employee_id "직원번호",
e.first_name "이름",
e.salary "급여",
e.department_id "부서번호"
from employees e, (select department_id, max(salary) max_salary from employees e
group by department_id) s
where e.department_id = s.department_id and e.salary = s.max_salary
order by salary desc;

--문제6.
select job_title, sum(e.salary)
from employees e
join jobs j on e.job_id=j.job_id
group by job_title
order by sum(e.salary)desc;

--문제7. (나는 어디부서..?)


--문제8.
select e.employee_id, e.first_name, e.salary, e.hire_date
from employees e , (select* from employees order by hire_date desc)
where rownum >= 11 and rownum <= 15;

