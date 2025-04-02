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
