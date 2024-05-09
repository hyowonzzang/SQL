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
drop database webdb;

show databases;