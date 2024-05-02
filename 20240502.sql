-- next_day()
SELECT sysdate, NEXT_DAY(sysdate, '목요일') FROM dual;

SELECT to_char(sysdate, 'DDD')	FROM dual;

SELECT to_char(SYSDATE , 'HH24') FROM dual;

SELECT to_char(sysdate, 'WW') FROM dual;

SELECT to_char(1234, '999,9')
	 , to_char(1234, '99999999999999999')
FROM dual;

SELECT to_char(-123, '999PR')
	 , to_char(-123, '999')
	 , -123
FROM dual;

SELECT to_char(-123, 'S999')
	 , to_char(123, 'S999')
	FROM dual;
	
SELECT to_date('20240502121330','YYYY-MM-DD HHMISS')
	 , to_date('20240502','YYYYMMDD')
	 , to_date('20240502','YYYY/MM/DD')
  FROM dual;
  
-- 대표의 사원번호 조회
 SELECT e.EMPLOYEE_ID 
   FROM EMPLOYEES e 
  WHERE e.MANAGER_ID IS NULL 
;

SELECT count(*)
  FROM EMPLOYEES e 
 WHERE e.MANAGER_ID IS NULL 
;

SELECT e.EMPLOYEE_ID 
	 , e.EMP_NAME 
	 , e.MANAGER_ID 
  FROM EMPLOYEES e 
 WHERE e.MANAGER_ID IS NULL 
;

SELECT nvl(e.MANAGER_ID, e.EMPLOYEE_ID)
     , e.EMPLOYEE_ID , e.emp_name, e.MANAGER_ID 
  FROM EMPLOYEES e 
 WHERE e.MANAGER_ID IS NULL 
;

-- 사원 급여 지급
-- 급여 계산 : 급여 + (급여 * 커미션)
-- 커미션 받는 직원 : commission_pct is null
-- 커미션 없는 직원 : commission_pct null

SELECT e.EMPLOYEE_ID		-- 사원번호
	 , e.EMP_NAME			-- 사원명
	 , e.SALARY 
	 , e.COMMISSION_PCT 	-- 커미션, NULL 인경우 급여가 NULL 값으로 들어감 -> nvl 사용 
	 , e.SALARY + (e.salary * nvl(e.COMMISSION_PCT,0)) AS sal -- 급여계산
  FROM EMPLOYEES e 
; 

SELECT e.EMPLOYEE_ID 
     , e.SALARY 
     , e.COMMISSION_PCT 
     , COALESCE (e.SALARY + (e.salary * e.COMMISSION_PCT), e.salary) AS sal2
  FROM EMPLOYEES e 
;

-- nullif
SELECT *
  FROM JOB_HISTORY jh 
;

SELECT e.EMPLOYEE_ID 
     , e.JOB_ID 
     , e.DEPARTMENT_ID 
  FROM EMPLOYEES e 
 WHERE e.EMPLOYEE_ID  = 102
;

-- 문제 : 업부 변경후 1년 미만으로 근무한 사원 조회
-- start_date(시작일), end_date(종료일) => 연도가 동일 사원 추출
SELECT jh.EMPLOYEE_ID 
     , to_char(jh.START_DATE, 'YYYY') 
     , to_char(jh.END_DATE, 'YYYY')
     , nullif(to_char(jh.END_DATE,'YYYY'),to_char(jh.start_date,'YYYY')) AS end_dt
  FROM JOB_HISTORY jh 
;

SELECT *
  FROM contact c
;
-- join문
SELECT c.NAME 
     , c.ADDRESS 
     , c.PHONE_NUM 
     , g.GUBUN_NM
     
  FROM CONTACT c, gubun g
 WHERE c.GUBUN_CD = g.GUBUN_CD 
;
-- 디코드 문
SELECT c.NAME 
     , c.ADDRESS 
     , c.PHONE_NUM 
     , c.GUBUN_CD 
     , decode(c.GUBUN_CD, '00', '가족'
     					, '01', '친구'
     					, '02', '회사'
     					, '03', '기타'
     ) AS gubun_nm
  FROM CONTACT c
;
-- 서브쿼리 문
SELECT c.name
	 , c.PHONE_NUM 
	 , c.ADDRESS 
	 , c.GUBUN_CD 
	 , (
	 	SELECT g.gubun_nm
	 	  FROM gubun g
	 	 WHERE g.gubun_cd = c.GUBUN_CD 
	 ) AS gubun_nm
  FROM CONTACT c 
;