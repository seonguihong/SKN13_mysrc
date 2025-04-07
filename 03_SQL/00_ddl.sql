create user playdata@localhost identified by '1111';
create user playdata@'%' identified by '1111';

-- 생성된 계정을 확인하고싶을때.
select user, host from mysql.user;

-- 실행 단축키 : control + enter
-- sql문 작성 -> 명령문 끝나면 ; 써주기

-- 계정에 권한을 부여.
-- grant 부여할 권한 on 대상 테이블 to 권한을 부여 할 계정*.
grant all privileges on *.* to playdata@localhost;
grant all privileges on *.* to playdata@'%';
-- *이 의미하는 것 : * -> DB. *-> table 

#DB 생성
create database test_db;
create database hr;

show databases;
/*
grant all privileges on test_db.* to playdata@'%';
-> playdata@'%'는 test_db 데이터베이스에 대한 권한만 이용가능
grant all privileges on *.costomer to playdata@'%';
-> playdata@'%'는 모든데이터베이스에 있는 costomer 테이블에 대한 권한만 이용가능
*/

drop database hr; 

use test_db; #test_db에 있는 내용들을 이용 할 때 사용.

# 테이블 생성
create table member(
	id varchar(10) primary key, # 최대 10글자.
    password varchar(10) not null, # not null 필수입력일떄 사용.
    point int default 1000, # 값을 넣지 않으면 1000을 기본값으로 사용. default 쓸떄 등호 넣으면 오류남
    name varchar(50) not null, # ==primary key
    email varchar(100) not null unique,
    age int check(age > 20),
    join_date timestamp not null default current_timestamp
    # current_timestamp -> 값이 insert되는 시점을 저장.
);


# 테이블들 조회
show tables;
# 테이블의 칼럼정보 조회
desc member;
# 테이블 삭제
drop table if exists aaaaaa;
drop table if exists member;

# insert
insert into member values('id-100','1111',5000,'이순신','lee@abc.com','123','2023-12-10 11:22:33');
# point,join_date : default값, age : null
insert into member (id,password,name,email) 
values('id-200', '1111', '유관순','ryu@def.com');
 
select * from member; # select (cullum) from (table) *-> 전부

insert into member (id,password,point,name,email)
values ('id-300','1111',null,'강감찬','kang@aaa.com');
/*
insert into member (id,password,name,email,age) 
values('id-400', '1111', '유관순','ryu2@def.com',5);
-> age가 check제약조건을 위반해서 실행이 불가능함
*/

 
