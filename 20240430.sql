-- 2000년 11월(SALES_MONTH) 판매(SALES)된 특정 상품(PRODUCTS) 조회
SELECT s.SALES_MONTH
	 , count(s.PROD_ID) AS "판매상품수" 		-- 상품번호
 FROM SALES s
-- WHERE s.SALES_MONTH = '200011'
GROUP BY s.SALES_MONTH
ORDER BY s.SALES_MONTH ASC 
;
----------------------------------
-- select
----------------------------------
-- 기본 구조
--SELECT 컬럼자리
--  FROM 테이블(뷰, 서브쿼리)자리
-- WHERE 조건
-- GROUP BY 컬럼자리, 식(값)자리
-- HAVING 조건 : 그룹화한 것들의 조건
-- ORDER BY 컬럼, 식 : 정렬
-- 문제 : 급여가 5000이 넘는 사원번호와 사원명 조회
-- 급여, 사원번호, 사원명이 어느 테이블에 있는지 확인 => employees table
-- 컬럼 확인 : 급여(salary), 사원번호(employee_id), 사원명(emp_name)
-- 데이터 타입 확인
-- 특정 테이블 정보 확인 쿼리문
SELECT *
 FROM USER_TAB_COLS utc
WHERE utc.TABLE_NAME ='EMPLOYEES'
;
-- 해결
SELECT e.EMPLOYEE_ID	-- 사원번호
	 , e.EMP_NAME 		-- 사원명
	 , e.SALARY 		-- 급여
 FROM EMPLOYEES e
WHERE e.SALARY > 5000	-- 급여 > 5000
ORDER BY e.SALARY ASC
;
SELECT count(*) FROM EMPLOYEES e ; -- 사원수 107명
-- 문제 : 급여가 5000이상이고 업무코드가 IT_PROG 사원번호, 사원명 조회
SELECT e.EMPLOYEE_ID
	 , e.EMP_NAME
	 , e.SALARY
 FROM EMPLOYEES e
WHERE e.SALARY > 5000
  AND e.JOB_ID = 'IT_PROG'	-- 값 비교는 대소문자를 따진다.
ORDER BY e.SALARY ASC, e.EMPLOYEE_ID ASC
;
-- 급여 > 5000, job_id='IT_PROG'
SELECT E.EMPLOYEE_ID
	 , e.EMP_NAME
	 , e.SALARY
	 , e.JOB_ID
 FROM EMPLOYEES e
WHERE e.SALARY > 5000
   OR e.JOB_ID = 'IT_PROG'
;
-- emp   emp  emp   dept
-- 사번, 사원명, 부번, 부서명 조회
SELECT count(*) -- 전체 로의 개수 반환
 FROM EMPLOYEES e 		-- 메모리 할당
 	 , DEPARTMENTS d 	-- 부서정보테이블, 메모리 할당
;
SELECT count(*)							-- 106명이 나온 이유 : 한사원이 부서없다(NULL).
 FROM EMPLOYEES e
 	 , DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID -- 부서가 있는 사원의 수 조회
;
-- 부서가 없는 사원의 수 : employees table에서 부번 없는 사원 수
SELECT count(*)
 FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID = NULL -- = 비교연산자 
;
SELECT count(*)
 FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID IS NULL
;
-- 부서가 있는 사원수
SELECT count(*)
 FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID IS NOT NULL
;
-- emp   emp  emp   dept
-- 사번, 사원명, 부번, 부서명 조회 => 106명 조회
CREATE OR REPLACE VIEW emp_dept_v01
AS
SELECT e.EMPLOYEE_ID 		-- 사번
	 , e.EMP_NAME 			-- 사원명
	 , e.DEPARTMENT_ID 		-- 부번
	 , d.DEPARTMENT_NAME 	-- 부서명
 FROM EMPLOYEES e
    , DEPARTMENTS d
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
;
SELECT *
 FROM EMP_DEPT_V01
;
----------------------------
-- INSERT
----------------------------
-- 기본 문법
--INSERT INTO 테이블명[(컬럼들)] values(값들);
-- 테이블 생성 : ex3_1
CREATE TABLE ex3_1(
	  col1	varchar2(10) 	NULL
	, col2	NUMBER 			NULL
	, col3	DATE 			NULL
);
-- ROW insert =>
INSERT INTO ex3_1
VALUES('abc',10,sysdate);
SELECT * FROM ex3_1;
-- 컬럼의 순서 변경 가능
INSERT INTO ex3_1(col3, col1, col2)
values(sysdate, 'def', 20);
SELECT * FROM ex3_1;
-- 데이터타입 틀릴 경우 에러 발생 : col3 date error number값이 들어와서 에러다
INSERT INTO ex3_1(col1, col2,col3)
values('abc',10,30);
-- 컬럼명 기술 생략 가능
-- 1. 컬럼의 개수와 벨류의 개수가 동일할 경우
INSERT INTO ex3_1 -- (col1, col2, col3) : 컬럼명 생략
values('ghi',10,sysdate);
SELECT * FROM ex3_1;
--	  col1	varchar2(10) 	NULL
--	, col2	NUMBER 			NULL
--	, col3	DATE 			NULL
-- col1, col2 insert 할 때
INSERT INTO ex3_1(col1, col2)
values('GHI', 20);
SELECT * FROM ex3_1;
-- insert : 한번에 한개 로우만 추가할 수 있다.
-- insert ~ select : select 하면 로우가 나온다.=> insert
-- 명령
--INSERT INTO 테이블(컬럼명,,,,)
--SELECT 문 ;
-- 사례 : 판매테이블 => 판매 한 건당 저장 =>  주단위 결산 => 결산 테이블에 insert
-- employees table(사원 모든 정보) => 일부 추출 새로운 테이블 insert
-- 급여가 5000이상인 사원의 사번, 사원명, 급여
-- ex3_2 table create
CREATE TABLE emp3_2(
	  emp_id		number(6,0)
	, emp_name		varchar2(80)
	, salary		number(8,2)
);
INSERT INTO emp3_2(emp_id, emp_name, salary)
SELECT e.EMPLOYEE_ID
	 , e.EMP_NAME
	 , e.SALARY
 FROM EMPLOYEES e
WHERE e.SALARY > 5000
;
SELECT * FROM emp3_2;
-- CTAS
CREATE TABLE emp3_3
AS
SELECT e.employee_id
	 , e.emp_name
	 , e.salary
 FROM EMPLOYEES e
WHERE e.salary > 5000
;
SELECT * FROM emp3_3;
-- 자동 형변환
-- 숫자 <=> 문자 <=> 날짜 변환
INSERT INTO ex3_1(col1, col2, col3)
values(10, '10', '2024-04-30');
SELECT * FROM ex3_1;
--------------------------------
-- UPDATE
--------------------------------
-- 요건 : ex3_1 table col2의 값을 다 50으로 변경(수정)
UPDATE ex3_1
  SET col2=50
-- WHERE col1='abc'
;
ROLLBACK; -- 원상복구
SELECT * FROM ex3_1;
-- null 찾아서 sysdate 수정
UPDATE ex3_1
  SET col3=SYSDATE
WHERE col3 IS NULL
;
SELECT * FROM emp3_2; -- 58명
DELETE FROM emp3_2; -- WHERE 없다 => 전체 데이터 삭제
---------------------------------
-- 트랜젝션 : commit, rollback
---------------------------------
CREATE TABLE ex3_4(
	emp_id	number
);
-- insert
INSERT INTO ex3_4 values(200);
SELECT * FROM ex3_4;
COMMIT;
INSERT INTO ex3_4 values(300);
------------------------
--의사컬럼 : rownum : select할때 row마다 부여되는 값, 1부터 시작해서 1씩 증가
------------------------
SELECT rownum, name FROM contact;
SELECT * FROM sales; -- 91만건을 다 가져오게 하면 시간이 많이 걸린다.
-- 5건 추출
SELECT rownum, s.PROD_ID
 FROM sales s
WHERE rownum <= 6
;
-- 10 ~ 19 추출
SELECT rownum, e.emp_name
 FROM EMPLOYEES e
WHERE rownum >= 10 -- 크다는 안된다.
  AND rownum <=19
;
-- rowid : row의 저장 위치값
SELECT rowid, e.EMP_NAME
 FROM EMPLOYEES e
WHERE rownum < 5
;
-- 위에서 3개
SELECT e.EMP_NAME 			-- 3
	 , e.SALARY
 FROM EMPLOYEES e  		-- 1
WHERE rownum <=3			-- 2
ORDER BY e.SALARY DESC		-- 4
;
--Steven King	24000
--Lex De Haan	17000
--Neena Kochhar	17000
--William Smith	7400
--Elizabeth Bates	7300
--Sundita Kumar	6100
--William Smith	7400
--Elizabeth Bates	7300
--Sundita Kumar	6100
-- 급여가 제일 많은 사원
-- 3명 조회 : TOP N 조회
SELECT a.emp_name
	 , a.salary
 FROM (SELECT e.EMP_NAME 			-- FROM 절에 있는 SELECT : 인라인뷰(서브쿼리)
			 , e.SALARY
		  FROM EMPLOYEES e
		 ORDER BY e.SALARY DESC
 ) a
WHERE rownum <=3
;