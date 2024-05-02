-- 1. aggregation function

-- 전체 사원수 조회
SELECT count(e.MANAGER_ID)
     , count(e.EMPLOYEE_ID)
  FROM EMPLOYEES e 
;

-- 부서수
SELECT count(*)
  FROM DEPARTMENTS d
;

-- 사원 테이블에서 부서 수 조회(사원이 있는 부서)
-- distinct : 중복 제거
SELECT count(DISTINCT e.DEPARTMENT_ID)
  FROM EMPLOYEES e 
;

SELECT DISTINCT e.DEPARTMENT_ID 
  FROM EMPLOYEES e 
 ORDER BY e.DEPARTMENT_ID 	ASC
;

-- 전체 사원의 급여 합
SELECT sum(e.SALARY)
     , avg(e.SALARY)
     , max(e.SALARY)
     , min(e.SALARY)
     , COUNT(*) 
  FROM EMPLOYEES e 
;