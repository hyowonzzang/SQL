-- 문제1.
select first_name || ' ' || last_name as "이름",
    manager_id as "매니저 아이디",
    commission_pct as "커미션 비율",
    salary as "월급"
    from employees
    where salary > 3000 and commission_pct is null and manager_id is not null;
    
-- 문제2.
select employee_id as "직원번호",
first_name as "이름",
salary as "급여",
to_char(hire_date,'YYYY-MM-DD day') as "입사일",
substr(replace(phone_number,'.','-'),3) as "전화번호",department_id as "부서번호"
from employees
where (department_id,salary) in (select department_id, max(salary)
from employees group by department_id)
order by salary desc;

-- 문제3. 너무 많이 출력됨 *검토하기*
select manager_id, first_name,avg(salary), min(salary), max(salary)
from employees
where hire_date >= '2015/01/01'
group by manager_id, first_name
having avg(salary)>= 5000
order by avg(salary) desc;

-- 문제4.
select e.employee_id, e.first_name, d.department_name, e.first_name
from employees e
join departments d on (e.department_id = d.department_id);

-- 문제5.
select e.employee_id, e.first_name || ' ' || e.last_name, d.department_name, e.salary, e.hire_date
from employees e
join departments d on(e.department_id = d.department_id)
where hire_date >='2015/01/01'
order by hire_date asc;
