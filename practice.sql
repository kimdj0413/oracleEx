-- 1-1
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

-- 1-2
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

-- 1-3
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

-- 1-4
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

-- 2
SELECT *
  FROM USER_TABLES
;

-- 3
SELECT *
  FROM shoppingbag
;

-- 4
ALTER TABLE product
DROP COLUMN Detail_info
;

-- 5
ALTER TABLE product
MODIFY Info varchar2(40)
;

























