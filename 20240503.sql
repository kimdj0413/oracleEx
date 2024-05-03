--------------------------
-- 그룹핑
--------------------------
-- 문제 : 부서별 급여합, 급여합로 내림차순 정렬
SELECT e.DEPARTMENT_ID
	 , sum(e.SALARY) AS sal_tot
 FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID -- 부서번호별, 그룹화 된 것이다.
; -- NULL 포함 결과
-- NULL 제외
SELECT e.DEPARTMENT_ID
	 , sum(e.SALARY) AS sal_tot
 FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID IS NOT NULL
GROUP BY e.DEPARTMENT_ID -- 부서번호별, 그룹화 된 것이다.
;
-- 부서로 정렬 포함
SELECT e.DEPARTMENT_ID
	 , sum(e.SALARY) AS sal_tot
 FROM EMPLOYEES e
WHERE e.DEPARTMENT_ID IS NOT NULL
GROUP BY e.DEPARTMENT_ID 		-- 부서번호별, 그룹화 된 것이다.
ORDER BY e.DEPARTMENT_ID ASC 	-- 부서 정렬
;
-- 급여합로 정렬 포함
SELECT e.DEPARTMENT_ID 					-- 부서번호
	 , d.DEPARTMENT_NAME
	 , count(e.EMPLOYEE_ID) AS emp_cnt	-- 부서별 사원수
	 , sum(e.SALARY) AS sal_tot			-- 부서별 급여합
	 , round(avg(e.SALARY),2) AS sal_avg			-- 부서별 평균급여
 FROM EMPLOYEES e , DEPARTMENTS d
WHERE e.DEPARTMENT_ID IS NOT NULL
  AND e.DEPARTMENT_ID = d.DEPARTMENT_ID
GROUP BY e.DEPARTMENT_ID 		-- 부서번호별, 그룹화 된 것이다.
		, d.DEPARTMENT_NAME
ORDER BY sal_avg DESC 			-- 급여합 정렬
;
SELECT DISTINCT e.DEPARTMENT_ID
 FROM EMPLOYEES e
ORDER BY e.DEPARTMENT_ID
;
--------------------------------
-- kor_loan_status table 탐색
--------------------------------
SELECT *
 FROM KOR_LOAN_STATUS kls
;
SELECT DISTINCT kls.PERIOD
 FROM KOR_LOAN_STATUS kls
ORDER BY kls.PERIOD
;
-- 기간 : 범주형 데이터
--201111
--201112
--201210
--201211
--201212
--201310
--201311
-- 지역 : 시/도(17개) 데이터 => 범주형
SELECT DISTINCT kls.REGION
 FROM KOR_LOAN_STATUS kls
;
-- 대출 구분 : 범주형 데이터
-- 기타대출
-- 주택담보대출
SELECT DISTINCT kls.GUBUN
 FROM KOR_LOAN_STATUS kls
;
-- 대출 잔액 : 숫자 연속형 데이터(단위 : 십억, 100(천억))
-- 요건 : 2013년 기간별(2개), 지역별(17개) 전체 대출 잔액 합 -> 구분(2개) X
SELECT count(*)
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'
GROUP BY kls.PERIOD , kls.REGION
ORDER BY kls.PERIOD DESC
;
SELECT kls.PERIOD
	 , kls.REGION
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '201310'
GROUP BY kls.PERIOD , kls.REGION
-- HAVING kls.PERIOD = '201310'
ORDER BY kls.PERIOD ASC, jan_tot DESC -- 2013년 월별 잔액 큰 시도 표시
;
SELECT count(*) -- 68 ROW
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'
;
SELECT count(*) -- 34 ROW
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '201310'
;
-- 인덱스 : 조회 사용, 일반적으로 where 의 컬럼에 부여
-- kls.PERIOD 인덱스 부여
SELECT count(*) -- 68 ROW
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'	-- 2013년도 데이터 추출
;
-- kls.PERIOD : 문자열 타입
SELECT count(*)
 FROM KOR_LOAN_STATUS kls
WHERE SUBSTR(kls.PERIOD,1,4) = '2013' -- 2013년도 데이터 추출, 속도 느리다
;
-- 요건 : 2013년 11월 총 잔액
SELECT sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD = '201311'
;
-- 요건 : 2013년 11월 지역별 총 잔액
-- 기간(7개) * 지역(17개) * 구분(2개)
-- 기간(1개 where) * 지역(17개 group) * 구분(1개 묶는다) = 17개 ROW
SELECT kls.PERIOD
	 , kls.REGION
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD = '201311'
GROUP BY kls.REGION -- 지역별
		, kls.PERIOD
ORDER BY kls.REGION -- 지역으로 정렬
;
SELECT count(*) -- 238 = 7(기간)*17(지역)*2(구분)
 FROM KOR_LOAN_STATUS kls
;
-- 2013년 11월 지역별 잔액합 조회
-- 단, 잔액합이 100조(100,000) 이상인 지역만 조회
SELECT kls.REGION
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD = '201311'
GROUP BY kls.REGION
HAVING sum(kls.LOAN_JAN_AMT) > 100000
ORDER BY kls.REGION ASC
;
-- 2013년(where) 월별(group), 구분별(group) 잔액합(sum)
SELECT kls.PERIOD -- 10월, 11월
	 , kls.GUBUN  -- 기타, 주택
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'  -- 2013년도인 ROW 선택, 10월, 11월 2개값
GROUP BY kls.PERIOD -- 월별(10월,11월) -- 월단위 소계, 전체 소계
	    , kls.GUBUN
;
-- 소계 추출
SELECT kls.PERIOD
	 , kls.GUBUN
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'
GROUP BY ROLLUP (kls.PERIOD, kls.GUBUN)
-- period 소계: 2013년 전체 잔액
-- gubun 소계 : 기타, 주택 소계
;
-- Rollup X =>
--201310	주택담보대출	411415.9
--201311	기타대출	681121.3
--201310	기타대출	676078
--201311	주택담보대출	414236.9
SELECT *
 FROM (
 		SELECT kls.PERIOD
			 , kls.GUBUN
			 , sum(kls.LOAN_JAN_AMT) AS jan_tot
		  FROM KOR_LOAN_STATUS kls
		 WHERE kls.PERIOD LIKE '2013%'
		 GROUP BY ROLLUP (kls.PERIOD, kls.GUBUN)
		-- period 소계: 2013년 전체 잔액
		-- gubun 소계 : 기타, 주택 소계
 )a
WHERE a.gubun IS NULL
;
-- 소계만 구하기
SELECT kls.PERIOD
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'
GROUP BY kls.PERIOD
;
-- 전체 합
SELECT sum(kls.LOAN_JAN_AMT)
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'
;
--
SELECT sum(a.jan_tot)
 FROM (
 		SELECT kls.PERIOD -- 10월, 11월 2개 ROW
			 , sum(kls.LOAN_JAN_AMT) AS jan_tot -- 1 ROW
		  FROM KOR_LOAN_STATUS kls
		 WHERE kls.PERIOD LIKE '2013%'
		 GROUP BY kls.PERIOD
 ) a
-- GROUP BY a.period
;
----------------------------
-- 집합 연산자
----------------------------
-- DROP TABLE exp_goods_asia;
CREATE TABLE exp_goods_asia(
	  country	varchar2(10) 	-- 국가명
	, seq		NUMBER			-- 상품순위
	, goods		varchar2(80)	-- 상품명
);
--------------------------------
-- 데이터 추가 : 한국 10개, 일본 10개
--------------------------------
INSERT INTO exp_goods_asia values('한국',1,'원유제외 석유류');
INSERT INTO exp_goods_asia values('한국',2,'자동차');
INSERT INTO exp_goods_asia values('한국',3,'전자직접회로');
INSERT INTO exp_goods_asia values('한국',4,'선박');
INSERT INTO exp_goods_asia values('한국',5,'LCD');
INSERT INTO exp_goods_asia values('한국',6,'자동차부품');
INSERT INTO exp_goods_asia values('한국',7,'휴대전화');
INSERT INTO exp_goods_asia values('한국',8,'환식탄화수소');
INSERT INTO exp_goods_asia values('한국',9,'무선송신기 디스플레이 부속품');
INSERT INTO exp_goods_asia values('한국',10,'철 또는 비합금강');
INSERT INTO exp_goods_asia values('일본',1,'자동차');
INSERT INTO exp_goods_asia values('일본',2,'자동차부품');
INSERT INTO exp_goods_asia values('일본',3,'전자직접회로');
INSERT INTO exp_goods_asia values('일본',4,'선박');
INSERT INTO exp_goods_asia values('일본',5,'반도체웨이퍼');
INSERT INTO exp_goods_asia values('일본',6,'화물차');
INSERT INTO exp_goods_asia values('일본',7,'원유제외 석유류');
INSERT INTO exp_goods_asia values('일본',8,'건설기계');
INSERT INTO exp_goods_asia values('일본',9,'다이오드, 트랜지스터');
INSERT INTO exp_goods_asia values('일본',10,'기계류');
COMMIT;
SELECT *
 FROM exp_goods_asia g
;
-- 문제 : 한국 상품 조회, 순위순으로
SELECT g.goods
 FROM exp_goods_asia g
WHERE g.country = '한국'
ORDER BY g.seq ASC
;
SELECT g.goods
 FROM exp_goods_asia g
WHERE g.country = '일본'
ORDER BY g.seq ASC
;
-- 문제 : 한국, 일본 상품(중복제거) 조회
SELECT g.goods -- 20개 조회, 중복값도 조회
 FROM EXP_GOODS_ASIa g
;
SELECT DISTINCT g.goods
 FROM EXP_GOODS_ASIA g
;
-- UNION : 합집합, 중복제거
-- UNION ALL : 합집합, 중복제거 안된다.
SELECT g.goods
 FROM EXP_GOODS_ASIA g
WHERE g.country = '한국' -- 한국상품 10개
UNION ALL
SELECT g.goods
 FROM EXP_GOODS_ASIA g
WHERE g.country = '일본' -- 일본상품 10개
;
-- 한국, 일본이 동시 강점을 가지고 있는 상품 조회
SELECT g.goods
 FROM exp_goods_asia g
WHERE g.country='한국'
INTERSECT
SELECT g.goods
 FROM exp_goods_asia g
WHERE g.country='일본'
;
-- 한국이 일본보다 강점이 있는 제품 조회
SELECT g.goods
 FROM exp_goods_asia g
WHERE g.country='한국'
MINUS 
SELECT g.goods
 FROM exp_goods_asia g
WHERE g.country='일본'
;
-- 제한사항 : 개수, 데이터타입 동일
SELECT g.seq, g.country
 FROM EXP_GOODS_ASIA g
WHERE g.country='한국'
-- ORDER BY g.seq DESC
UNION
SELECT g.seq, g.goods
 FROM EXP_GOODS_ASIA g
WHERE g.country='일본'
;
--- grouping sets
SELECT sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%' -- 2013년 10월, 11월 데이터 추출
;
SELECT kls.PERIOD
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%' -- 2013년 10월, 11월 데이터 추출
GROUP BY kls.PERIOD -- 10월, 11월 그룹핑
;
SELECT kls.PERIOD
	 , kls.GUBUN
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%' -- 2013년 10월, 11월 데이터 추출
GROUP BY kls.PERIOD, kls.GUBUN -- 10월, 11월 그룹핑
;
SELECT kls.PERIOD
	 , kls.GUBUN
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%' -- 2013년 10월, 11월 데이터 추출
GROUP BY GROUPING sets(kls.PERIOD, kls.GUBUN)
;
-- 2013년 10월 11월 잔액합 union all  서울, 경기(지역) 대출 구분별 잔액합
SELECT kls.PERIOD
	 , kls.GUBUN
	 , kls.REGION
	 , sum(kls.LOAN_JAN_AMT) AS jan_tot
 FROM KOR_LOAN_STATUS kls
WHERE kls.PERIOD LIKE '2013%'
  AND kls.REGION in('서울','경기')
--   AND kls.REGION = '서울'
--    OR kls.REGION = '경기'
GROUP BY GROUPING  SETS (kls.PERIOD, (kls.REGION, kls.GUBUN))
;



