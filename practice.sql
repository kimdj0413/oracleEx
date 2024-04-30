-- 1-1-1
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

ALTER TABLE product
ADD
CONSTRAINT product_pk
PRIMARY key(Product_Code)
;

--DROP TABLE users;

-- 1-1-2
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

ALTER TABLE users
ADD
CONSTRAINT users_pk
PRIMARY key(UserID)
;

ALTER TABLE users
ADD
CONSTRAINT users_uk
unique(Regist_No)
;

-- 1-1-3
CREATE TABLE shoppingbag(
	  Order_No		varchar2(10)	NOT NULL
	, Order_ID		varchar2(10)	NOT NULL
	, Product_Code	varchar2(10)	NOT NULL
	, Order_Qty		Number(2)		NOT NULL
	, Order_Date	DATE			DEFAULT		sysdate
);

ALTER TABLE shoppingbag
ADD
CONSTRAINT shoppingbag_pk
PRIMARY key(Order_No)
;

ALTER TABLE shoppingbag
ADD CONSTRAINT shoppingbag_users_fk
FOREIGN key(Order_ID)
REFERENCES users(UserID)
;

ALTER TABLE shoppingbag
ADD CONSTRAINT shoppingbag_product_fk
FOREIGN key(Product_Code)
REFERENCES product(Product_Code)
;

-- 1-1-4
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

ALTER TABLE orderdeal
ADD CONSTRAINT orderdeal_pk
PRIMARY key(Order_No)
;

-- 1-2
SELECT *
  FROM USER_TABLES
;

-- 1-3
SELECT COLUMN_NAME
	 , DATA_TYPE
	 , DATA_LENGTH
  FROM USER_TAB_COLS
 WHERE TABLE_NAME = 'SHOPPINGBAG'
;

-- 1-4
ALTER TABLE product
DROP COLUMN Detail_info
;

-- 1-5
ALTER TABLE product
MODIFY Info varchar2(40)
;

-- 1-6
ALTER TABLE ORDERDEAL
MODIFY Gubun varchar2(20)
;

-- 1-7
ALTER TABLE ORDERDEAL 
ADD CONSTRAINT orderdeal_FK
FOREIGN key(Product_Code)
REFERENCES product(Product_Code)
;

-- 1-8
SELECT uc.CONSTRAINT_NAME 
	 , uc.CONSTRAINT_TYPE 
  FROM user_constraints uc 
WHERE uc.TABLE_NAME = 'ORDERDEAL'
;

-- 1-9

-- 2-1
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
ALTER TABLE Freeboard
ADD B_Red 	Number(5)		DEFAULT 0
ADD B_Step 	Number(5)		DEFAULT 0
ADD B_Order Number(5)		DEFAULT 0
;

-- 2-3
ALTER TABLE Freeboard
MODIFY B_Title varchar2(100)
;

-- 2-4
ALTER TABLE Freeboard
MODIFY B_Pwd NULL
;

-- 2-5
ALTER TABLE Freeboard
DROP COLUMN B_Ip
;

-- 2-6
SELECT COLUMN_NAME
     , DATA_TYPE
     , DATA_LENGTH
  FROM USER_TAB_COLS
 WHERE TABLE_NAME = 'FREEBOARD'
;

-- 2-7
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
ALTER TABLE Freeboard
RENAME COLUMN B_Step TO B_Level
;

-- 2-9
ALTER TABLE orderdeal
DROP CONSTRAINT orderdeal_pk
;

-- 2-10
ALTER TABLE Freeboard
ADD CONSTRAINT B_Email_uk
UNIQUE (B_Email)
;

-- 2-11
ALTER TABLE Freeboard
RENAME TO Free_Board
;

-- 2-12
DROP TABLE SHOPPINGBAG 
;