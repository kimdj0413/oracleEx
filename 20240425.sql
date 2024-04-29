-- 주석(단축키 : ctrl + /)
-- 연습 1 : 테이블 생성
CREATE TABLE ex2_1(
	  coll	char(10)
	, col2	varchar2(10)
	, col3	nvarchar2(10)
	, col4	number
);

-- 데이터타입 : 문자 테스트 테이블 생성
-- 3개 컬럼별 데이터 다른 방식으로 지정
CREATE TABLE ex2_2( -- 객체(테이블)의 이름은 대문자로 저장된다.
	  column1	varchar2(9) 		-- 디폴트 byte 단위 : 3 byte
	, column2	varchar2(9 byte)	-- 위와 동일
	, column3	varchar2(3 char)	-- char(2 byte)는 디비 설정에 따라 상이
);

-- 데이터 입력 : insert문 => 한 개의 ROW 생성
-- insert 문 기본 구조
-- insert into 테이블명[(컬럼들)] value(value,,,,);
-- 컬럼이 3개고 value가 3개 동일할 경우 컬럼명 생략가능.
INSERT INTO ex2_2 values('abc','bbb','ccc');

-- 컬럼은 3개, value 2개 : 컬럼명을 명시.
INSERT INTO ex2_2(COLUMN1,COLUMN2)
 values('aaa','bbb');

-- 데이터 길이 파악하고 데이터 타입 길이 확인
-- 조회 : select 문 사용
-- select 문 기본 문법
--SELECT 컬럼자리, 서브쿼리, 뷰
--	FROM 테이블 자리
--[	WHERE 조건문, 서브쿼리
--	GROUP BY 컬럼(단일값) 자리, 서브쿼리
--	HAVING 조건문(그룹핑한 경과에 대한 조건)
--	ORDER BY 컬럼(단일값) 자리
--] []는 옵션

SELECT COLUMN1 	-- 2번째 작동
	 , COLUMN2 
--	 , COLUMN3
	 , 1 + 3
	 , 4 * 5
  FROM ex2_2 e	-- 1번째 작동
;

-- 데이터 추출 -> 가공 => 데이터 길이 확인
SELECT COLUMN1
	 , LENGTH(COLUMN1)
	 , COLUMN2 
	 , LENGTH(COLUMN2)
	 , COLUMN3 
	 , LENGTH(COLUMN3)
	FROM EX2_2 e 
;

-- 한글 3자 추가
INSERT INTO EX2_2(COLUMN3) values('홍길동');

-- 테이블 구조 확인 쿼리문
-- 유저가 생성한 테이블의 정보를 갖고 있는 테이블 : uwer_tab_cols
-- select
SELECT COLUMN_NAME 
	 , DATA_TYPE
	 , DATA_LENGTH
	from USER_TAB_COLS
 WHERE TABLE_NAME = 'EX2_2' -- = 는 비교연산자
;

-- 날짜 데이터 타입
-- 테이블 생성 : 2개 컬럼
CREATE TABLE EX2_5(
	  col_date 		DATE		NULL -- NULL 허용
	, col_timestamp timestamp	NULL -- NULL 허용
);

-- 1개 Row 추가
INSERT INTO ex2_5 values(sysdate, systimestamp);

-- sysdate(X) : 파라미터가 없는 함수는 함수명으로 호출 가능
-- sysdate : 함수가 실행된 현재 날짜와 시간을 초단위까지 반환
-- systimestamp : 함수가 실행된 현재 날짜와 시간을 밀리초까지 반환(정밀한 시간)

-- 전체 데이터 조회(where절 없다)
SELECT * -- 자리 : 컬럼자리(*은 모든 컬럼)
	FROM EX2_5 