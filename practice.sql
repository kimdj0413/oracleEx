-- 1-1-1
-- 테이블 생성
CREATE TABLE product(
	  Product_Code		varchar2(10)	NOT NULL
	, Pruduct_Name		varchar2(20)	NOT NULL
	, Standard			varchar2(20)
	, Unit				varchar2(10)
	, Unit_Price		Number(7)		NOT NULL
	, Left_Qty			Number(5)		NOT NULL
	, Company			varchar2(20)
	, ImageName			varchar2(20)
	, Info				varchar2(50)
	, Detail_Info		varchar2(255)
);
--pk추가
ALTER TABLE product
ADD
CONSTRAINT product_pk
PRIMARY key(Product_Code)
;

--DROP TABLE users;

-- 1-1-2
-- 테이블 생성
CREATE TABLE users(
	  UserID		varchar2(10)	NOT NULL
	, Passwd		varchar2(10)	NOT NULL
	, Name			varchar2(10)	NOT NULL
	, Regist_No		varchar2(14)	NOT NULL
	, Email			varchar2(20)
	, Telephone		varchar2(13)	NOT NULL
	, Address		varchar2(40)
	, Buycash		Number(9)		DEFAULT 	0
	, Timestamps	DATE			DEFAULT 	sysdate
);
-- pk 추가
ALTER TABLE users
ADD
CONSTRAINT users_pk
PRIMARY key(UserID)
;
-- uk 추가
ALTER TABLE users
ADD
CONSTRAINT users_uk
unique(Regist_No)
;

-- 1-1-3
-- 테이블 추가
CREATE TABLE shoppingbag(
	  Order_No		varchar2(10)	NOT NULL
	, Order_ID		varchar2(10)	NOT NULL
	, Product_Code	varchar2(10)	NOT NULL
	, Order_Qty		Number(2)		NOT NULL
	, Order_Date	DATE			DEFAULT		sysdate
);
-- pk 추가
ALTER TABLE shoppingbag
ADD
CONSTRAINT shoppingbag_pk
PRIMARY key(Order_No)
;
-- fk 추기
ALTER TABLE shoppingbag
ADD CONSTRAINT shoppingbag_users_fk
FOREIGN key(Order_ID)
REFERENCES users(UserID)
;
-- fk 추가
ALTER TABLE shoppingbag
ADD CONSTRAINT shoppingbag_product_fk
FOREIGN key(Product_Code)
REFERENCES product(Product_Code)
;

-- 1-1-4
-- 테이블 추가
CREATE TABLE orderdeal(
	  Order_No		varchar2(10)	NOT NULL
	, ORDER_ID		varchar2(10)	NOT NULL
	, Product_Code	varchar2(10)	NOT NULL
	, Order_Qty		Number(3)		NOT NULL
	, Csel			varchar2(10)
	, CMoney		Number(9)
	, Cdate			DATE
	, Mdate			DATE
	, Gubun			varchar2(10)
);
-- pk 추가
ALTER TABLE orderdeal
ADD CONSTRAINT orderdeal_pk
PRIMARY key(Order_No)
;

-- 1-2
-- 테이블명 모두 출력
SELECT *
  FROM USER_TABLES
;

-- 1-3
-- 테이블 구조 출력
SELECT COLUMN_NAME
	 , DATA_TYPE
	 , DATA_LENGTH
  FROM USER_TAB_COLS
 WHERE TABLE_NAME = 'SHOPPINGBAG'
;

-- 1-4
-- 컬럼 삭제
ALTER TABLE product
DROP COLUMN Detail_info
;

-- 1-5
-- 컬럼 데이터 타입 수정
ALTER TABLE product
MODIFY Info varchar2(40)
;

-- 1-6
-- 컬럼 데이터 타입 수정
ALTER TABLE ORDERDEAL
MODIFY Gubun varchar2(20)
;

-- 1-7
-- fk 추가
ALTER TABLE ORDERDEAL 
ADD CONSTRAINT orderdeal_FK
FOREIGN key(Product_Code)
REFERENCES product(Product_Code)
;

-- 1-8
-- 제약 조건 출력
SELECT uc.CONSTRAINT_NAME 
	 , uc.CONSTRAINT_TYPE 
  FROM user_constraints uc 
WHERE uc.TABLE_NAME = 'ORDERDEAL'
;

-- 1-9
SELECT uc.CONSTRAINT_NAME, uc.COLUMN_NAME, uc.POSITION
  FROM USER_CONS_COLUMNS uc
 WHERE TABLE_NAME = 'ORDERDEAL'

-- 2-1
-- 테이블 생성
CREATE TABLE Freeboard(
	  B_Id			Number(5)		NOT NULL
	, B_Name		varchar2(20)	NOT NULL
	, B_Pwd			varchar2(20)	NOT NULL
	, B_Email		varchar2(20)	NOT NULL
	, B_Title		varchar2(80)	NOT NULL
	, B_Content		varchar2(2000)	NOT NULL
	, B_Date		DATE			DEFAULT		sysdate
	, B_Hit			Number(5)		DEFAULT		0
	, B_Ip			varchar2(15)
);

-- 2-2
-- 칼럼 추가
ALTER TABLE Freeboard
ADD B_Red 	Number(5)		DEFAULT 0
ADD B_Step 	Number(5)		DEFAULT 0
ADD B_Order Number(5)		DEFAULT 0
;

-- 2-3
-- 칼럼 수정
ALTER TABLE Freeboard
MODIFY B_Title varchar2(100)
;

-- 2-4
-- 칼럼 수정
ALTER TABLE Freeboard
MODIFY B_Pwd NULL
;

-- 2-5
-- 칼럼 삭제
ALTER TABLE Freeboard
DROP COLUMN B_Ip
;

-- 2-6
-- 테이블 구조 확인
SELECT COLUMN_NAME
     , DATA_TYPE
     , DATA_LENGTH
  FROM USER_TAB_COLS
 WHERE TABLE_NAME = 'FREEBOARD'
;

-- 2-7
-- 체크 제약조건 추가(영소문자 입력)
ALTER TABLE users
ADD CONSTRAINTS UserID_ck
CHECK (REGEXP_LIKE(UserID, '^[a-z]+$'))
;

INSERT INTO users (UserID, Passwd, Name, Regist_No, Telephone) 
values('srlee','1234','이소라','821001-2******','010-1234-1234')
;

INSERT INTO users (UserID, Passwd, Name, Regist_No, Telephone)
VALUES ('20park','1234','박연수','810604-1******','010-2345-2345')
;

-- 2-8
-- 칼럼명 변경
ALTER TABLE Freeboard
RENAME COLUMN B_Step TO B_Level
;

-- 2-9
-- pk 삭제
ALTER TABLE orderdeal
DROP CONSTRAINT orderdeal_pk
;

-- 2-10
-- uk 추가
ALTER TABLE Freeboard
ADD CONSTRAINT B_Email_uk
UNIQUE (B_Email)
;

-- 2-11
-- 테이블 이름 변경
ALTER TABLE Freeboard
RENAME TO Free_Board
;

-- 2-12
-- 테이블 삭제
DROP TABLE SHOPPINGBAG 
;