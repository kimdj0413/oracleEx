----------------------
-- 연산자
----------------------
-- 1. 산술연산
-- 2. || : 문자열 연결
SELECT *
 FROM EMPLOYEES e
WHERE rownum < 5
;
-- SELECT 절에서 별칭(Alias)
-- AS 별칭 , 공백 별칭
SELECT e.EMPLOYEE_ID
	 , e.EMP_NAME 							
	 , e.EMPLOYEE_ID || '-' || e.EMP_NAME AS emp_info  
 FROM EMPLOYEES e
WHERE rownum < 5
;
-- 요건 : 급여 <= 5000 : C등급, 5000 < 급여 <= 15000 : B등급, 급여 > 15000 : A등급
-- 사원번호, 급여, 급여등급 조회
SELECT e.EMPLOYEE_ID
	 , e.SALARY
	 , CASE WHEN e.SALARY <= 5000 THEN 'C등급'
	 	    WHEN e.salary > 5000 AND e.salary <= 15000 THEN 'B등급'
	 	    ELSE 'A등급'
	   END AS salary_grade -- alias
 FROM EMPLOYEES e
;
-- 급여 2000, 3000, 4000 직원 조회
SELECT e.EMPLOYEE_ID
	 , e.SALARY
 FROM EMPLOYEES e
WHERE e.SALARY < 2000
   OR e.SALARY < 3000
   OR e.SALARY < 4000
   OR e.SALARY < 5000
   OR e.SALARY < 6000
   OR e.SALARY < 7000
   OR e.SALARY < 8000
   OR e.SALARY < 9000
   OR e.SALARY < 10000
;
-- ANY : OR다
SELECT e.EMPLOYEE_ID
	 , e.SALARY
 FROM EMPLOYEES e
WHERE e.SALARY < ANY (2000,3000,4000,5000,6000,7000,8000,9000,10000)
;
-- ALL : AND
SELECT e.EMPLOYEE_ID
	 , e.SALARY
 FROM EMPLOYEES e
WHERE e.SALARY = ALL (2000,3000,4000)
-- WHERE e.SALARY = 2000
--   AND e.SALARY = 3000
--   AND e.SALARY = 4000
;
SELECT s.CUST_ID   	-- 고객번호
	 , c.CUST_NAME 	-- 고객명
    , s.PROD_ID 	-- 상품번호
    , p.PROD_NAME  -- 상품명	
 FROM CUSTOMERS c
    , SALES s
 	 , PRODUCTS p
WHERE c.CUST_ID = s.CUST_ID
  AND s.PROD_ID = p.PROD_ID
  AND s.PROD_ID = any(32,14,31)
;
SELECT e.EMPLOYEE_ID
	 , e.SALARY
 FROM EMPLOYEES e
-- WHERE e.SALARY >= 2500 -- 102명
-- WHERE NOT e.SALARY >= 2500 -- 5명
WHERE e.SALARY < 2500 -- 5명
;
-- 급여 2000보다 크고, 2500보다 작다
SELECT e.EMPLOYEE_ID , e.SALARY
 FROM EMPLOYEES e
WHERE e.SALARY >= 2000
  AND e.SALARY <=2500
;
SELECT e.EMPLOYEE_ID , e.SALARY 
 FROM EMPLOYEES e
WHERE e.SALARY BETWEEN 2000 AND 2500
;
-- DDL
CREATE TABLE ex3_5(
	name	varchar2(30)
);
--DML
INSERT INTO ex3_5
SELECT '홍길동' FROM dual UNION ALL
SELECT '홍길용' FROM dual UNION ALL
SELECT '홍길상' FROM dual UNION ALL
SELECT '홍길상동' FROM dual
;
SELECT * FROM ex3_5;
-- 상 포함하는 이름 조회
SELECT name
 FROM ex3_5
WHERE name LIKE '%상%'
;
-- dual 테이블
SELECT abs(-10) FROM dual;
SELECT abs(-10) FROM CONTACT c ;
SELECT * FROM CONTACT c ;
SELECT * FROM dual;
-- function 실행 결과 확인 => 결과 한번 출력 => row 가 한개인 테이블 필요 : dual table
SELECT abs(-10) FROM dual;
-- function : ceil(n) => 정수 반환, 큰 정수 반환
SELECT ceil(10.123), ceil(10.541), ceil(11.001)
 FROM dual;
-- floor(n) : 정수 반환, 작은 정수 반환
SELECT floor(10.123), floor(10.541), floor(11.001)
 FROM dual;
CREATE TABLE ex4_1(
	phone_num varchar2(30)
);
INSERT INTO ex4_1 values('111-1111');
INSERT INTO ex4_1 values('111-2222');
SELECT * FROM ex4_1;
-- LPAD : '(02)111-1111'
SELECT lpad(phone_num, 12, '(02)')
 FROM EX4_1
;
SELECT rpad(phone_num, 12, '(02)')
 FROM EX4_1
;
CREATE TABLE jumin(
	j_num	varchar2(14) -- 123456-1234567
);
INSERT INTO jumin values('123456-1234567');
INSERT INTO jumin values('123456-2234567');
SELECT * FROM jumin;
-- 123456-1******
SELECT rpad(substr(j_num,1,instr(j_num,'-')+1),14,'******')
 FROM JUMIN
;
SELECT instr(j_num,'-')+1
 FROM jumin;
SELECT substr(j_num,1,instr(j_num,'-')+1) FROM jumin;