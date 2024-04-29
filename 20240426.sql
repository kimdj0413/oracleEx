-- NOT NULL 제약조건(CONSTRAINT)
-- 테이블 생성(DDL)
CREATE TABLE ex2_6(
	  col_null		varchar2(10)
	, col_not_null	varchar2(10) NOT NULL 
);
-- NOT NULL은 제약조건
-- 제약조건 = 하나의 객체 =별도 존재

-- 데이터 추가
--INSERT INTO ex2_6(col_null, col_not_null) values('aa','');
--INSERT INTO ex2_6 VALUES('aa',''); -- error
INSERT INTO ex2_6 values('','bb');
-- 확인(조회)
--SELECT COL_NULL 
--	 , COL_NOT_NULL 
--  FROM EX2_6
--;
-- select 컬럼자리 from 테이블 자리
SELECT *
  FROM EX2_6
;
-- 제약조건 보기
SELECT uc.CONSTRAINT_NAME 
	 , uc.CONSTRAINT_TYPE 
	 , uc.TABLE_NAME 
	 , uc.SEARCH_CONDITION 
  FROM USER_CONSTRAINTS uc -- 별칭
 WHERE uc.TABLE_NAME = 'EX2_6' -- 조건에 부합하는 결과 추출 
;
-- NOT NULL은 하나의 객체이므로 이름을 지정하지 않으면 시스템이 지정해줌

-- uk(unique) 컬럼은 ROW를 식별(중복불가)
-- uk는 여러 컬럼에 줄 수 있다.(복합키)
-- UK 설정
CREATE TABLE ex2_7(
	  col_uk_null 	varchar2(10) UNIQUE 
	, col_uk_nn 	varchar2(10) UNIQUE NOT NULL 
	, col_uk		varchar2(10)
	, CONSTRAINTS ex2_7_uk	UNIQUE(col_uk)
);
-- 제약조건 조회
SELECT uc.CONSTRAINT_NAME -- 제약조건 이름
	 , uc.CONSTRAINT_TYPE -- 타입
  FROM user_constraints uc
 WHERE uc.TABLE_NAME = 'EX2_7'
;
 -- 새로운 방식 -> 우선 테이블 삭제(drop)
 DROP TABLE ex2_7;
 -- 다시 생성
 CREATE TABLE ex2_7(
	  col_uk_null 	varchar2(10)
	, col_uk_nn		varchar2(10) NOT NULL
	, col_uk		varchar2(10)
 );

-- ex2_7 테이블 존재하는 상황
-- 3개 컬럼에 제약조건 UK 부여(추가) -> 테이블 구조 변경해야 하는 것이다.(alter table)
ALTER TABLE ex2_7
ADD --추가
CONSTRAINT ex2_7_col_uk_null_uk
unique(col_uk_null)
;

ALTER TABLE ex2_7
ADD 
CONSTRAINT ex2_7_col_uk_nn_uk
UNIQUE (col_uk_nn)
;

ALTER TABLE ex2_7
ADD
CONSTRAINT ex2_7_col_uk_uk
UNIQUE (col_uk)
;

-- UK는 NULL을 포함 가능(식별하기 어려워서 잘안씀)
-- PK는 NOT NULL + UK(식별하기 용이)

-- PK
CREATE TABLE ex2_8(
	  col1	varchar2(10) NULL 
	, col2	varchar2(10) NULL 
);
-- col1에 PK 추가
ALTER TABLE ex2_8
ADD
CONSTRAINT ex2_8_pk
PRIMARY key(col1)
;

-- ex2_8 테이블에 걸려있는 제약조건 조회
SELECT uc.CONsTRAINT_NAME
	 , uc.CONSTRAINT_TYPE
  FROM user_constraints uc
 WHERE uc.TABLE_NAME = 'EX2_8'
 ;

INSERT INTO ex2_8 values('AA','AA');

SELECT * FROM ex2_8;

INSERT INTO ex2_8 VALUES('BB','BB');

-- FK는 두개 테이블
-- 참조 당하는 컬럼은 중복x(최소 UK하고 대부분은 PK)

-- CHECK
CREATE TABLE ex2_9(
	  num1		NUMBER
	, gender	varchar2(10)
);
-- 제약조건 : CHECK
ALTER TABLE ex2_9
ADD
CONSTRAINT ex2_9_num1_ck
CHECK (num1 BETWEEN 1 AND 9) -- 1부터 9까지 입력받겠다.
;

-- gender
ALTER TABLE ex2_9
ADD
CONSTRAINT ex2_9_gender_ck
CHECK (gender IN ('M','F'))
;

INSERT INTO ex2_9(num1, gender)
values(5,'F'); -- 정상 처리

-- 조회
SELECT * FROM ex2_9;

-- error
--INSERT INTO ex2_9
--VALUES(10,'M');

--default
CREATE TABLE board(
	  board_seq NUMBER					-- 글번호
	, title		varchar2(200)			-- 제목
	, contents	varchar2(2000)			-- 내용
	, writer	varchar2(100)			-- 작성자
	, reg_dt	DATE DEFAULT sysdate	-- 등록일
	, UPDATE_dt DATE DEFAULT sysdate	-- 수정일
);

INSERT INTO BOARD (board_seq, title, contents, writer)
values(1,'테스트','테스트','테스트');

SELECT * FROM board;