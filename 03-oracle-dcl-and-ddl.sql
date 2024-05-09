-- connect와 resource의 역할은 어떤 권한으로 구성되어 있는가?
-- sysdba로 진행
-- cmd
-- sqlplus sys/oracle as sysdba
-- DESC role_sys_privs;
-- CONNECT롤에는 어떤 권한이 포함되어 있는가?
-- SELECT privilege FROM role sys_privs WHERE role='CONNECT';
-- RESOURCE롤에는 어떤 권한이 포함되어 있는가?
-- SELECT privilege FROM role sys_privs WHERE role='RESOURCE';

----------------------------
-- DDL
ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER himedia IDENTIFIED BY himedia;


GRANT CONNECT, RESOURCE TO himedia;  
ALTER USER himedia DEFAULT TABLESPACE USERS
    QUOTA unlimited on USERS;
    
    GRANT select ON employees To himedia;
    SELECT * FROM hr.employees;
    SELECT * FROM hr.departments;
    SELECT * FROM tabs; 
    
    
    CREATE TABLE book (
    book_id NUMBER(5),
    title VARCHAR2(50),
    author VARCHAR2(10),
    pub_date DATE DEFAULT SYSDATE
);


CREATE TABLE emp_it AS (
    SELECT * FROM hr.employees WHERE job_id LIKE 'IT_%'
);

-- 테이블 삭제 
drop table emp_it;

SELECT * FROM tabs;

desc book;

-- author 테이블 생성
create table author (
    author_id number(10),
    author_name varchar2(100) not null,
    author_desc varchar2(500),
    primary key (author_id)
    );
    
    desc author;
    
    -- book 테이블의 author 컬럼 삭제
    -- 나중에 author_id 컬럼 추가 -> author.author_id와 참조 연결할 예정
    alter table book drop column author;
    desc book;
    
    -- book 테이블에 author_id 컬럼 추가
    -- author.author_id 를 참조하는 컬럼 author.author_id 컬럼과 같은 형태여야 한다.
    alter table book add (author_id number(10));
    desc book;
    desc author;
    
    -- book 테이블의 book_id도 author 테이블의 pk와 같은 데이터타임(number(10)) 으로 변경
    alter table book modify (book_id number(10));
    desc book;
    
    -- book 테이블의 book_id 컬럼에 primary key 제약조건을 부여
    alter table book
    add constraint ok_book_id primary key (book_id);
    desc book;
    
    --book 테이블의 author_id 컬럼과 author 테이블의 author_id를 fk로 연결
    alter table book
        add constraint fk_author_id 
            foreign key (author_id)
                references author(author_id);
                
-- dictionary

-- user_ : 현재 로그인 된 사용자에게 허용된 뷰
-- all_ : 모든 사용자 뷰
-- dba_ : dba에게 허용된 뷰

-- 모든 딕셔너리 확인
select * from dictionary;

-- 사용자 스키마 객체 : user_objects
select * from user_objects;
-- 사용자 스키마의 이름과 타입 정보 출력
select object_name, object_type from user_objects;

-- 제약 조건의 확인
select * from user_constraints;
select constraint_name,
    constraint_type,
    search_condition,
    table_name
from user_constraints;

-- book 테이블에 적용된 제약조건의 확인
select consstraint_name,
    constraint_type,
    search_condition
from user_constraints
where table_name='book';

-- insert : 테이블에 새 레코트(튜플) 추가
-- 제공된 컬럼 목록의 순서와 타입, 값 목록의 순서와 타입이 일치해야함
-- 컬럼 목록을 제공하지 않으면 테이블 생성시 정의된 컬럼의 순서의 타입을 따른다

-- 컬럼 목록이 제시되지 않았을 때
insert into author
values(1,'박경리','토지 작가');

-- 컬럼 목록을 제시했을 때,
-- 제시한 컬럼의 순서와 타입대로 값 목록을 제공해야 함
insert into author (author_id, author_name)
values(2,'김영하');
select * from author;

-- 컬럼 목록을 제공했을 때,
-- 테이블 생성시 정의된 컬럼의 순서와 상관 없이 데이터를 제공 가능
insert into author (author_name, author_id, author_desc)
values('류츠신',3,'삼체 작가');

select * from author;

--desc author;

rollback;

select * from author;

insert into author
values(1,'박경리','토지 작가');
insert into author (author_id, author_name)
values(2,'김영하');
insert into author(author_name, author_id, author_desc)
values('류츠신',3,'삼체작가');

select * from author;

commit; -- 변경사항 반영

select * from author;

-- update
-- 특정 레코드의 컬럼 값을 변경한다.
-- 가급적 where 절로 변경하고자 하는 레코드를 지정하도록 함

update author
set suthor_desc = '알뜰신잡 출연'
where author_name = '김영하';

select * from author;

commit;
-- 연습
--hr.employees 테이블을 기반으로 department_id 10, 20, 30인 직원들만 새 테이블 em123으로 생성
drop table emp123;
create table emp123 as
(select* from hr.employees
where department_id in(10,20,30));
desc emp123;
select first_name,salary,department_id from emp123;

-- 부서가 30인 직원들의 급여를 10% 인상
update emp123
set salary = salary + salary * 0.1
where department_id = 30;

select * from emp123;

-- job_id mk_로 시작하는 직원들 삭제
delete from emp123
where job_id like 'mk_%';

select * from emp123;

delete from emp123;
select * from emp123;

rollback;

-------------------
-- transaction
--------------------

-- 트랜잭션 테스트 테이블
create table t_test(
log_text varchar2(100)
);

-- 첫 번째 dml이 수행된 시점에서 transaction
insert into t_test values('트랜잭션 시작');
select * from t_test;
insert into t_test values('데이터 insert');
select * from t_test;

savepoint sp1; -- savepoint

insert into t_test values('데이터 2 insert');
select * from t_test;

savepoint sp2; -- savepoint

update t_test set log_text = '업데이트';

select * from t_test;

rollback to sp1;   -- sp1 로 롤백

select * from t_test;

insert into t_test values('데이터 3 insert');

select * from t_test;

-- 반영 : commit or 취소 : rollback
-- 명시적으로 transaction 종료

commit;
select * from t_test;



