/* ********************************************************************************
조인(JOIN) 이란
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블(메인정보)
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블(추가정보)
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join , non-equi join
- 조인의 종류
    - Inner Join 
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. 
    - Outer Join
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join,  Right Outer Join, Full Outer Join
    - Cross Join
        - 두 테이블의 곱집합을 반환한다. ex) 5개, 5개 크로스 조인하게되면 5*5인 25개의 행이 나온다.
******************************************************************************** */        

/* ****************************************
-- INNER JOIN
FROM  테이블a INNER JOIN 테이블b ON 조인조건 

- inner는 생략 할 수 있다.
**************************************** */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
select * from emp inner join dept on emp.dept_id = dept.dept_id;
select e.emp_id, e.emp_name, e.hire_date, d.dept_name 
from emp e inner join dept d on e.dept_id = d.dept_id; # table 명에 as 부여가능.

-- 커미션을(emp.comm_pct) 받는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name),
-- 급여(emp.salary), 커미션비율(emp.comm_pct), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 내림차순으로 정렬.
select e.emp_id, e.emp_name, e.salary, e.comm_pct, d.dept_name, d.loc
from emp e join dept d on e.dept_id = d.dept_id where comm_pct != 0 order by 1 desc;

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e join dept d on e.dept_id = d.dept_id where e.emp_id = 100;

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name 
from emp e join job j on e.job_id = j.job_id 
join dept d on e.dept_id = d.dept_id;

--  직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name 
from emp e join job j on e.job_id = j.job_id 
join dept d on e.dept_id = d.dept_id
where e.emp_id = 200;

-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
select d.dept_id, d.dept_name, d.loc, e.emp_name
from dept d join emp e on d.dept_id = e.dept_id 
where d.dept_id = 30;

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(empgrade.salary), 급여등급(salary_grade.grade) 를 조회. 
select e.emp_id, e.emp_name, e.salary, s.grade 
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;

-- 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
-- 그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from dept d join emp e on d.dept_id = e.dept_id
where d.loc = 'New York';

-- 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬. 
select d.dept_id, d.dept_name, avg(e.salary) 
from dept d join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 1;


-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회.
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e join job j on e.job_id = j.job_id 
join dept d on e.dept_id = d.dept_id 
join salary_grade s on e.salary between s.low_sal and s.high_sal;

/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.
**************************************************** */

-- 직원 ID가 101인 직원의 직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회
select e.emp_id, e.emp_name, m.emp_name mgr_name
from emp e join emp m on e.mgr_id = m.emp_id;
# inner join의 경우 위 구문에서 mgr_id가 없는 행은 조인테이블에서 행이 삭제되어서 출력되지않는다.

/* ****************************************************************************
외부 조인 (Outer Join)
- 불충분 조인
    - 조인 연산 조건을 만족하지 않는 행도 포함해서 합친다
종류
 left  outer join: 구문상 소스 테이블이 왼쪽
 right outer join: 구문상 소스 테이블이 오른쪽
 full outer join:  둘다 소스 테이블 (Mysql은 지원하지 않는다. - union 연산을 이용해서 구현)

- 구문
from 테이블a [LEFT | RIGHT] OUTER JOIN 테이블b ON 조인조건
- OUTER는 생략 가능.

**************************************************************************** */

-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회. dept_name의 내림차순으로 정렬한다.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id
order by 4 desc;

-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)
select e.emp_id, e.emp_name, e.dept_id, d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id and e.dept_id = 80
order by 1;
# 아래 쿼리 구문은 left join 하더라도 dept_id 가 80이 아니면 출력되지않음.
select e.emp_id, e.emp_name, e.dept_id, d.dept_name, d.loc
from emp e left join dept d on e.dept_id = d.dept_id 
where e.dept_id = 80
order by 1;

        
-- 직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 직원의 ID(emp.emp_id),이름(emp.emp_name), 
-- 업무명(job.job_title) 을 조회. 업무명이 없을 경우 '미배정' 으로 조회
select e.emp_id, e.emp_name, ifnull(j.job_title,'미배정')
from emp e left join job j on e.job_id = j.job_id 
where e.emp_id in (100,110,120,130,140);


-- 부서 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.
select d.dept_id, d.dept_name, count(e.emp_id)
from dept d left join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 3 desc;
/* count(*) -> 행수를 카운트 하는 것이기 떄문에 직원이 없는 부서도 1로 출력된다.
직원수를 세는 것이기 때문에 emp_id를 기준으로 count해야 옳바른 값이 출력된다.*/

-- EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 모든 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy/mm/dd 형식으로 출력
select e.emp_id, e.emp_name, m.emp_name mgr_name ,date_format( e.hire_date, '%Y/%m/%d') hire_date
from emp e left join emp m on e.mgr_id = m.emp_id
where e.dept_id = 90;

-- 2003년~2005년 사이에 입사한 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
-- 상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
select e.emp_id, e.emp_name, j.job_title, e.salary, e.hire_date, m.emp_name mgr_name, m.hire_date mgr_hiredate, d.dept_name, d.loc
from emp e left join job j on e.job_id = j.job_id 
left join emp m on e.mgr_id = m.emp_id
left join dept d on e.dept_id = d.dept_id
where year(e.hire_date) between 2003 and 2005

# 조인조건이 충족하는 테이블만 보고싶으면 inner 조인조건을 충족하지않더라도 모두 보고싶으면 outer 
# 일단 잘 모르겠으면 outer 해보고 결과값 보고 판단해서 재출력