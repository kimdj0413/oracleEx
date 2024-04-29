-- 테에블 기본 구조 확인 : desc => 오라클 명령, 디비버 지원 안한다.
SELECT * FROM ex2_9;
-- ALTER TABLE
-- create table ex2_10
CREATE TABLE ex2_10(
	  col1		varchar2(10) NOT NULL
	, col2		varchar2(10) NULL 
	, reg_dt	DATE DEFAULT sysdate
);

SELECT * FROM ex2_10;
-- 1 기존 테이블 컬럼명 변경 : col1 => col11
ALTER TABLE ex2_10
RENAME COLUMN col1 TO col11;

-- 2 기존 테이블(구조 수정) 특정 컬럼의 데이터 타입 변경 : col2 varchar2(30)
ALTER TABLE ex2_10
MODIFY col2 varchar2(30);

-- 3 컬럼 추가 : col3 number
ALTER TABLE EX2_10 
ADD col3 NUMBER;

-- 4 컬럼 삭제 : col3
ALTER TABLE EX2_10
DROP COLUMN col3;

-- 5 제약 조건 추가 : col1 PK, add constraint
ALTER TABLE EX2_10 
ADD CONSTRAINT ex2_10_PK -- 제약조건 이름
PRIMARY key(col11);

-- 6 제약 조건 삭제 : ex2_10_pk 삭제
ALTER TABLE EX2_10
DROP CONSTRAINT ex2_10_pk;

SELECT * 
  FROM USER_TABLES ut; -- 현재 CONNECTION한 유저가 생성한 테이블 확인
SELECT *
  FROM user_tab_cols utc; --테이블별 컬럼들 정보 확인 
  
-- 테이블 복사
SELECT * FROM ex2_9;

CREATE TABLE ex2_9_1
AS
SELECT num1
  FROM ex2_9
;

SELECT * FROM ex2_9_1;

----------------------
------- view ---------
----------------------

CREATE TABLE gubun(
	  gubun_cd		varchar2( 2)	-- 구분번호, PK = NOT NULL + UK
	, gubun_nm		varchar2(20)	-- 구분명
);
CREATE TABLE contact (
	  name		varchar2( 30) 	NOT NULL
	, phone_num	varchar2( 11) 	NULL -- PK
	, address	varchar2(100)	NULL
	, gubun_cd	varchar2(  2)	NULL -- PK x, FK -> gubun.gubun_cd
);

-- PK 선언
-- gubun.gubun_cd, contact.phone_num
ALTER TABLE GUBUN 
ADD CONSTRAINT gubun_pk
PRIMARY key(gubun_cd);
ALTER TABLE contact
ADD CONSTRAINT contact_pk
PRIMARY key(phone_num);

-- FK 선언 : contact.gubun_cd -> gubun.gubun_de referense
ALTER TABLE contact
ADD CONSTRAINT contact_gubun_cd_fk
FOREIGN key(gubun_cd)
REFERENCES gubun(gubun_cd);

-- 데이터 추가
INSERT INTO gubun values('00','가족');
INSERT INTO gubun values('01','친구')

INSERT INTO contact
values('홍길동', '1234', '울릉도', '00');
INSERT INTO CONTACT 
values('고길동','2345','서울','01');

SELECT * FROM gubun;
SELECT * FROM contact;

CREATE VIEW contact_view
AS 
SELECT name, phone_num, address, gubun_nm
  FROM contact, gubun -- 카티시안 곱 출력
 WHERE contact.gubun_cd = gubun.gubun_cd
;

-- 위 뷰를 수정
--ALTER VIEW contact_view			--view는 알터가 안된다.에러
--CREATE VIEW contact_view			--개첵의 이름이 존재해서.에러
CREATE OR REPLACE VIEW contact_view	--VIEW 수정
AS
SELECT c.name
	,  c.phone_num
	,  c.address
	,  c.gubun_cd AS c_gubun_cd
	,  g.gubun_cd AS g_gubun_cd
	,  g.gubun_nm
  FROM contact c, gubun g
 WHERE c.gubun_cd = g.gubun_cd
;

SELECT *
  FROM contact_view
;

SELECT *
  FROM (SELECT name, phone_num, address, gubun_nm
  		  FROM contact, gubun						-- FROM 절에 있는 SELECT : 서브쿼리
 		 WHERE contact.gubun_cd = gubun.gubun_cd)	-- 서브쿼리 => 인라인뷰
;


-- 서브쿼리
-- 1. select 절에 있는 select문 : 스칼라 서브쿼리
-- 2. from 절에 있는 select문 : 인라인뷰
-- 3. where에 있는 select문 : 서브쿼리

--------------------------
---------인덱스-------------
--------------------------
-- ex2_10.col11 컬럼을 인덱스 생성 : 단일 인덱스
CREATE UNIQUE INDEX ex2_10_idx
ON ex2_10(col11);

-- 생성된 인덱스 확인
SELECT ui.INDEX_NAME
	 , ui.INDEX_TYPE
	 , ui.TABLE_NAME 
	 , ui.UNIQUENESS 
  FROM user_indexes ui
 WHERE ui.TABLE_NAME = 'EX2_10'
;

SELECT  * FROM ex2_10;

-- 결합 인덱스
-- ex2_10 테이블의 col11, col2 로 인덱스 생성
CREATE UNIQUE INDEX ex2_10_idx01
ON ex2_10(col11, col2);

---------------------
--------시퀀스---------
---------------------

CREATE SEQUENCE my_seq1
INCREMENT BY 1
START WITH 1
MINVALUE 1
MAXVALUE 3
CYCLE 
--nocycle
nocache;

-- seq drop
DROP SEQUENCE my_seq1;

SELECT * FROM ex2_9;

-- 데이터 삭제
DELETE FROM ex2_9;

-- seq 사용해서 값 추가 col1
INSERT INTO EX2_9(num1) VALUES(my_seq1.nextval) --nextval은 증가 연산

SELECT * FROM ex2_9;