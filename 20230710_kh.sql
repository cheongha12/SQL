select * from employee;
select * from department;
select * from job;
select * from location;
select * from national;
select * from sal_grade;

select * from employee where job_code = 'J1';

--SELECT emp_name, length(emp_name) len, lengthb(emp_name) by
-- from emp
-- ;
-- instr -1부터 시작
select email, instr(email,'@',-1,1)
from employee;

--email 은 @ 이후에 . 1개 이상있어야함.
select email, instr(email,'@'), instr(email, '.',instr(email, '@'))
from employee
where instr(email, '.', instr(email, '@'))<> 0
;

--
select INSTR('ORACLEWALCOME', 'O',2)
from dual;

select INSTR('ORACLEWALCOME', 'O',1,2)
from dual;

-- 날짜 처리함수가 아니지만 함수처럼사용 STSDATE 시스템에 저장되어 있는 현재 날짜 반환.
--SYSDATE은 함수는 아니나 명령어가 실행되는 시점에 결과값을 출력해주므로 함수호출과 같이 동작함.
SELECT SYSDATE
FROM DUAL;

SELECT hiredate from emp;

select add_months(hiredate, 50) from emp;


--급여를 3500000보다 많이 받고 6000000보다 적게 받는 직원 이름과 급여 조회
select emp_name,salary
    from employee
    where salary between 3500000 and 6000000;
--'전'씨 성을 가진 직원 이름과 급여 조회
select emp_name,salary
    from employee
    where emp_name like '전%'
;

-- 핸드폰의 앞 네자리 중 첫 번호가 7인 직원 이름과 전화번호 조회
select emp_name, phone
from employee
where phone like '___7%'
;

--email id 중 '_'의 앞이 3자리인 직원 이름, 이메일 조회
SELECT emp_name, email
from employee
where email like '___#_%'ESCAPE'#'
;

-- ‘이’씨 성이 아닌 직원 사번, 이름, 이메일 조회
select emp_id, emp_name, email
from employee
where emp_name not like '이%'
;

-- 관리자도 없고 부서 배치도 받지 않은 직원 조회
SELECT emp_name, manager_id, dept_code
from employee
where manager_id is null and dept_code is null
;

-- 부서 배치를 받지 않았지만 보너스를 지급받는 직원 조회
SELECT emp_name,bonus,dept_code
from employee
where dept_code is null and bonus is not null
;

-- D6 부서와 D8 부서원들의 이름, 부서코드, 급여 조회
SELECT emp_name,dept_code,salary
from employee
where dept_code in('d6','d8')
;
-- ‘J2’ 또는 ‘J7’ 직급 코드 중 급여를 2000000보다 많이 받는 직원의
--이름, 급여, 직급코드 조회
SELECT emp_name, salary, job_code
from employee
where job_code = 'j7' or job_code = 'j2'
and salary > 2000000
;

--사원들의 남,여 성별과 함께 이름과 주민번호
select emp_name, emp_no, 
    decode(substr(emp_no, 8,1), 2,'여','남')
    as "성별"
    
    from employee
;
--java, js 삼항연산자
-- string a = ( substr(emp_no, 8 ,1) == 2? "여" : "남";
--if(substr(emp_no, 8 ,1) ==2) {
--return "여";
--}else {
--return "남";
--}
select emp_name, emp_no,
decode(substr(emp_no,8,1),2,'여',4,'여',1,'남',3,'남','그외')
as "성 별"
from employee
;

select emp_name, emp_no,
    case
        when substr(emp_no, 8 ,1) = 2 then '여'
        when substr(emp_no, 8 ,1) = 1 then '남'
        when substr(emp_no, 8 ,1) = 4 then '여'
        when substr(emp_no, 8 ,1) = 3 then '남'
        else '그외'
     end
     as "성 별"
     from employee
;
     
     select emp_name, emp_no,
    case to_number (substr(emp_no, 8 ,1))
        when 2 then '여'
        when 1 then '남'
        when 4 then '여'
        when 3 then '남'
        else '그외'
     end
     as "성 별"
     from employee
;

select substr(emp_no, 8 ,1) from employee;

-- 직원들의 평균 급여는 얼마인지 조회
SELECT (avg (salary)) 평균급여 from employee;
SELECT floor(avg (salary)) 평균급여 from employee;
SELECT trunc(avg (salary),2) 평균급여 from employee;
SELECT round(avg (salary)) 평균급여 from employee;
SELECT ceil(avg (salary)) 평균급여 from employee;

SELECT COUNT(DISTINCT DEPT_CODE)FROM EMPLOYEE;
SELECT COUNT(DEPT_CODE)FROM EMPLOYEE; --21
SELECT COUNT(*)FROM EMPLOYEE; -23
SELECT COUNT(*)FROM EMPLOYEE where dept_code is null; 
select * from employee; --23
select * from employee where dept_code is  null;
--count 는 resultset의 row값이 null이면 count 되지 않음.
-- count(*) row 개수
SELECT count(dept_code), count(bonus), count(emp_id), count(manager_id), count(*)
from employee where dept_code is null;

SELECT DEPT_CODE from employee;
select distict FROM EMPLOYEE; 

-- 사원명 , 부서번호 부서명 부서위치를 조회

select tb1.emp_name, tb1.dept_code, tb2.dept_title, tb2.location_id, nationcal_code, tb4.national_name
from employee tb1
join department tb2 on tb1.dept_code = tb2.dept_id
join location tb3 on department.location_id = tb3.local_code
join national tb4 using(national_code)
; --오류남

select *
from employee e
left outer join department d on e.dept_code=d.dept_id
;

select *
from employee e
full outer join department d on e.dept_code=d.dept_id
;

select *
from employee e , department d
where e.dept_code(+)=d.dept_id;

--SUBQUERY  
SELECT emp_id,emp_name, job_code,salary
from employee
where salary >=(select avg(salary) from employee);

--전 직원의 급여 평균 보다 많은 급여를 받는 직원의 이름,직금,부서, 급여조회
--단일행 서브쿼리
SELECT EMP_NAME,JOB_CODE,DEPT_CODE,SALARY
FROM EMPLOYEE E
WHERE SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY 2;

--부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 다중행 서브쿼리
select emp_name, job_code, dept_code, salary
from employee
where salary in(select max(salary) from employee group by dept_code);

--퇴사한 여직원과 같은 부서 , 같은 직급에 해당하는 사원의 이름, 직급, 부서,입사일조회
--다중 열 서브 쿼리
select emp_name, job_code, dept_code, hire_date
from employee
where(dept_code, job_code)in(select dept_code, job_code from employee
where substr(emp_no,8,1)=2and ent_yn='Y');


--직급별 최소 급여를 받는 직원의 사번, 이름 , 직급,급여 조회
--다중행 다중 열 서브쿼리
select emp_id,emp_name, job_code,salary
from employee
where(job_code,salary)in(select job_code, min(salary)
from employee group by job_code)
order by 3;

--with
--서브쿼리에 이름을 붙여주고 인라인 뷰로 사용시 서브쿼리의 이름으로
--from절에 기술 가능
--같은 서브쿼리가 여러번 사용될 경우 중복 작성을 피할 수 있고 실행속도도 빨라진다는 장점이있음
with topn_sal as(select emp_name,salary from employee order by salary desc)
select rownum, emp_name, salary
from topn_sal;

--rank() over

select 순위,emp_name, salary
from(select emp_name, salary, rank() over(order by salary desc)as 순위
from employee
order by salary desc);



--20230712
-- 16.employee테이블에서 사원명, 주민번호 조회( 단, 주민번호는 생년월일만 보이게하고, '-'다음 값은 '*'로 바꾸기)
select emp_id, emp_no,  substr(emp_no,1,7), rpad(substr(emp_no,1,7),14,'*')
from employee
;

select emp_name, salary*12 as "연봉", 
(salary+(salary*nvl(bonus,0)))*12 as "총수령액", 
((salary+(salary*nvl(bonus,0)))-(salary*0.03))*12 as "실수령액" 
    from employee;