-- MySQL은 사용자와 Database를 구분하는 DBMS
show databases;

-- 데이터베이스 사용 선언
use sakila;

-- 데이터베이스 내에 어떤 테이블이 있는가?
show tables;

-- 테이블 구조 확인
describe actor;

-- 간단한 쿼리 실행
select version(), current_date;
select version(), current_date from dual;

-- 특정 테이블 데이터 조회 alter
select * from actor;

-- 데이터베이스 생성
-- webdb 데이터베이스 생성
create database webdb;
-- 시스템 설정에 좌우되는 경우 많음
-- 문자셋, 정렬 방식을 명시적으로 지정하는 것이 좋다 
create database webdb charset utf8mb4
	collate utf8mb4_unicode_ci;

show databases;

-- 사용자 만들기 
create user 'dev'@'localhost' identified by 'dev';
-- 사용자 비밀번호 변경 
-- alter user 'dev'@'localhost' identified by 'new_password';
-- 사용자 삭제
-- drop user 'dev'@'localhost';

-- 권한부여
-- GRANT 권한 목록 ON 객체, TO '계정'@'접속호스트';
-- 권한 회수
-- revoke 권한 목록 on 객체 from '계정'@'접속호스트';

-- 'dev'@'localhost'에게 webdb 데이터베이스의 모든 객체에 대한 모든 권한 허용
grant all privileges on webdb.* to 'dev'@'localhost';
-- revoke all privileges on webdb.* from 'dev'@'localhost';

-- ---------------------------------
show tables;
desc author;

-- 테이블 생성 정보altershow create table author;

-- book 테이블 생성
create table book	(
book_id int primary key,
title varchar(100) not null,
pubs varchar(100),
pub_date datetime default now(),
author_id int,
constraint fk_book foreign key (author_id)
references author(author_id)
);

show tables;
desc book;

-- insert : 새로운 레코드 삽입
-- 묵시적 방법 : 컬럼 목록 제공하지 않음 -> 선언된 컬럼의 순서대로
insert into author values (1, '박경리', '토지작가');
-- 명시적 방법 : 컬럼 목록 제공, 컬럼 목록의 숫자, 순서, 타입이
-- 값목록의 숫자, 순서, 타입과 일치해야 한다. 
insert into author (author_id, author_name)
values (2, '김영하');

select * from author;

-- MySQL은 기본적으로 자동 커밋이 활성화 돼있다.
-- autocommit을 비활성화 autocommit 옵션을 0 으로 설정
set autocommit = 0;

-- MySQL은 명시적 트랜잭션을 수행
start transaction;
select * from author;

update author
set author_desc = '알쓸신잡 출연'	-- where 절이 없으면 전체 레코드 변경 
where author_id = 2;

select * from author;

commit; -- 변경사항 영구 반영
-- rollback; -- 변경사항 반영 취소

select * from author;

-- auto_increment 속성
-- 연속된 순차정보, 주로 PK 속성에 사용

-- author 테이블의 PK에 auto_increment 속성 부여
alter table author modify 
	author_id int auto_increment primary key;
    
-- 1. 외래 키 정보 확인 
select *
from information_schema.KEY_COLUMN_USAGE;

select constraint_name
from information_schema.KEY_COLUMN_USAGE
where table_name = 'book';

-- 2. 외래 키 삭제 : book 테이블의 FK ( fk_book)
alter table book drop foreign key fk_book;

-- 3. author 의 PK에 AUTO_INCREMENT 속성 붙인
-- 기존 PK 삭제
alter table author drop primary key;
-- auto_increment 속성이 부여된 새로운 primary key생성
alter table author modify author_id int auto_increment primary key;
-- 4. book의 author_id에 foreign key 다시 연결
alter table book add constraint fk_book
foreign key (author_id) references author(author_id);

-- autocommit 다시 킴
set autocommit = 1;
-- ----------------------------------------
-- 테이블 생성시 auto_increment 속성을 부여하는 방법
drop table book cascade;

create table book(
book_id int auto_increment primary key,
title varchar(100) not null,
pubs varchar(100),
pub_date datetime default now(),
author_id int,
constraint book_fk foreign key(author_id)
references author(author_id));

insert into book (title, pub_date, author_id) value ('토지','1994-03-04',1);
insert into book (title, author_id) value ('살인자의 기억법',2);
insert into book (title, author_id) values ('쇼생크 탈출', 3);
insert into book (title, author_id) values ('삼체',4 );

select* from book;

-- join
select title 제목,
	pub_date 출판일,
    author_name 저자명,
    author_desc '저자상세'
    from book b join author a on b.author_id = b.author_id;
    
