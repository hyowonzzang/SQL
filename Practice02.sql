--문제1.
select count(manager_id) as "haveMngCnt"
from employees
where manager_id is not null;

--문제2.
select max(salary) "최고임금" , min(salary) "최저임금", max(salary) - min(salary) "최고임금 - 최저임금"
from employees;

--문제3.
select to_char(max(hire_date), 'YYYY') || '년' ||
to_char(max(hire_date), 'MM') || '월' ||
to_char(max(hire_date), 'DD') || '일' as "마지막으로 신입사원이 들어온 날"
from employees;

--문제4.
select department_id, avg(salary), max(salary), min(salary)
from employees
group by department_id
order by department_id desc;

--문제5.
select job_id, round(avg(salary)), max(salary), min(salary)
from employees
group by job_id
order by min(salary) desc, avg(salary) asc;

--문제6.
select to_char(min(hire_date), 'YYYY-MM-DD day')
from employees;

--문제7.
select department_id,
avg(salary), min(salary), avg(salary) - min(salary)
from employees
group by department_id
having avg(salary)-min(salary) <2000
order by avg(salary) - min(salary) desc;

--문제8.
select job_id, max(salary)-min(salary) diff
from employees
group by job_id
order by diff desc;

--문제9.
select manager_id, round(avg(salary),0), min(salary), max(salary)
from employees
where hire_date>= '15/01/01'
group by manager_id
having avg(salary) >=5000
order by avg(salary) desc;

--문제10.
select employee_id, salary, 
case when hire_date <= '12/12/31' then '창립멤버'
    when hire_date >= '13/01/01' and hire_date<='13/12/31' then ' 13년입사'
    when hire_date >= '14/01/01' and hire_date<='14/12/31' then ' 14년입사'
    else '상장이후입사'
    end optDate,
    hire_date
    from employees;