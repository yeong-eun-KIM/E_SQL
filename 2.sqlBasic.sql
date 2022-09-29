create table TB_CONTACT
(
	CONTACT_NO SERIAL primary key
,	FIRST_NM VARCHAR(50) NOT null
,	LAST_NM VARCHAR(50) NOT null
,	EMAIL_ADRES VARCHAR(200) not null UNIQUE
);

select * from tb_contact;

insert into tb_contact (first_nm,last_nm,email_adres)
VALUES('순신','이','sslee@gmail.com');
insert into tb_contact (first_nm,last_nm,email_adres)
VALUES('방원','이','bwlee@gmail.com');


-- 테이블 구조 및 데이터 복제 => 제약조건은 복제 반영 안됨
-- 테이블, 컬럼명, 컬럼 데이터타입, 컬럼값만 복제
create table tb_contact_bak
	as table tb_contact;
	
select *from tb_contact_bak tcb ;

alter table tb_contact_bak add primary key (CONTACT_NO);
alter table tb_contact_bak add unique (EMAIL_ADRES);
alter table tb_contact_bak alter column first_NM set not null;
alter table tb_contact_bak alter column last_NM set not null;
alter table tb_contact_bak alter column EMAIL_ADRES set not null;

insert into tb_contact_bak (CONTACT_NO,first_nm,last_nm,email_adres)
values(3,'방간','이','bglee@gmail.com');
insert into tb_contact_bak (CONTACT_NO,first_nm,last_nm,email_adres)
values(4,'성계','이','sglee@gmail.com');

--------------
drop table if exists tb_user_role;
drop table if exists tb_user;
create table tb_user
(
	USER_NO INT
,	USER_NM	VARCHAR(50) not null
,	BIRTH_DE DATE not null
,	ADDRS VARCHAR(200)
,	primary KEY(USER_NO)	-- 테이블 생성하면서 USER_NO을 기본키로 지정
);							-- USER_NO 컬럼으로 이루어진 인덱스도 자동으로 생성됨

drop table if exists TB_USER;
create table tb_user
(
	USER_NO INT
,	USER_NM	VARCHAR(50) not null
,	BIRTH_DE DATE not null
,	ADDRS VARCHAR(200)
,	constraint PK_TB_USER primary KEY(USER_NO) --기본 키 제약 조건의 제약조건명
);

drop table if exists TB_USER;
create table tb_user
(
	USER_NO INT
,	USER_NM	VARCHAR(50) not null
,	BIRTH_DE DATE not null
,	ADDRS VARCHAR(200)
);

alter table TB_USER add primary key (USER_NO); --기본키지정

create table TB_VENDOR
(
	VENDOR_NM VARCHAR(255)
);

insert into TB_VENDOR (vendor_nm) values ('Apple');
insert into TB_VENDOR (vendor_nm) values ('IBM');
insert into TB_VENDOR (vendor_nm) values ('Samsung');
insert into TB_VENDOR (vendor_nm) values ('LG');
insert into TB_VENDOR (vendor_nm) values ('Microsoft');
insert into TB_VENDOR (vendor_nm) values ('Sony');

select * from tb_vendor;



alter table tb_vendor add column vendor_id serial primary key;
alter table tb_vendor drop constraint tb_vendor_pkey;

------------------------------------------------------------
create table TB_CUST
(
	CUST_NO INT
,	CUST_NM VARCHAR(255) not null
,	primary key (CUST_NO)
);


drop table if exists TB_CONTACT;
create table tb_contact
(
	CONTACT_NO INT
,	CONTACT_TYP_CD CHAR(6) not null		-- 'CT001' : 전화번호, 'CT002' : 이메일
,	CONTACT_INFO VARCHAR(100)
,	CUST_NO INT
,	primary key (CONTACT_NO)
,	constraint FK_CUST_NO_TB_CUST foreign key(CUST_NO) references TB_CUST(CUST_NO)
	on delete no action -- 자식을 가지고 있는 부모테이블의 행을 삭제하려고 하면 삭제 못하게 하는것
);


insert into tb_cust(cust_no,cust_nm) values(1,'이순신');
insert into tb_cust(cust_no,cust_nm) values(2,'이방원');

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(1,'CTC001','010-1234-5678',1);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(2,'CTC002','sclee@gmail.com',1);

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(3,'CTC001','010-5678-1234',2);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(4,'CTC002','bwlee@gmail.com',2);

select*from tb_contact;

delete from tb_cust
where cust_no =1;	

--------------------------------------
drop table if exists TB_CUST; --부모삭제 (2)
drop table if exists TB_CONTACT; --자식삭제 (1)

create table TB_CUST
(
	CUST_NO INT
,	CUST_NM VARCHAR(255)not null
,	primary key (CUST_NO)
);

create table tb_contact
(
	CONTACT_NO INT
,	CONTACT_TYP_CD CHAR(6) not null		-- 'CT001' : 전화번호, 'CT002' : 이메일
,	CONTACT_INFO VARCHAR(100)
,	CUST_NO INT
,	primary key (CONTACT_NO)
,	constraint FK_CUST_NO_TB_CUST foreign key(CUST_NO) references TB_CUST(CUST_NO)
	on delete set null
);


insert into tb_cust(cust_no,cust_nm) values(1,'이순신');
insert into tb_cust(cust_no,cust_nm) values(2,'이방원');

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(1,'CTC001','010-1234-5678',1);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(2,'CTC002','sclee@gmail.com',1);

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(3,'CTC001','010-5678-1234',2);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(4,'CTC002','bwlee@gmail.com',2);

delete from tb_cust
where cust_no =1;

select * from tb_contact;

------------------------
drop table if exists TB_CUST; --부모삭제 (2)
drop table if exists TB_CONTACT; --자식삭제 (1)

create table TB_CUST
(
	CUST_NO INT
,	CUST_NM VARCHAR(255)not null
,	primary key (CUST_NO)
);

create table tb_contact
(
	CONTACT_NO INT
,	CONTACT_TYP_CD CHAR(6) not null		-- 'CT001' : 전화번호, 'CT002' : 이메일
,	CONTACT_INFO VARCHAR(100)
,	CUST_NO INT
,	primary key (CONTACT_NO)
,	constraint FK_CUST_NO_TB_CUST foreign key(CUST_NO) references TB_CUST(CUST_NO)
	on delete cascade	--cascade옵션은 자식을 가지고 있는 부모행을 삭제하려고 하면 자식행도 삭제함
);


insert into tb_cust(cust_no,cust_nm) values(1,'이순신');
insert into tb_cust(cust_no,cust_nm) values(2,'이방원');

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(1,'CTC001','010-1234-5678',1);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(2,'CTC002','sclee@gmail.com',1);

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(3,'CTC001','010-5678-1234',2);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(4,'CTC002','bwlee@gmail.com',2);

delete from tb_cust
where cust_no =1;
select * from tb_contact;

------------------------------
drop table if exists TB_CONTACT; --자식삭제 (1)
drop table if exists TB_CUST; --부모삭제 (2)

create table TB_CUST
(
	CUST_NO INT
,	CUST_NM VARCHAR(255)not null
,	primary key (CUST_NO)
);

insert into tb_cust(cust_no,cust_nm) values(1,'이순신');
insert into tb_cust(cust_no,cust_nm) values(2,'이방원');


create table tb_contact
(
	CONTACT_NO INT
,	CONTACT_TYP_CD CHAR(6) not null		-- 'CT001' : 전화번호, 'CT002' : 이메일
,	CONTACT_INFO VARCHAR(100)
,	CUST_NO INT
,	primary key (CONTACT_NO)
);

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(1,'CTC001','010-1234-5678',1);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(2,'CTC002','sclee@gmail.com',1);

insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(3,'CTC001','010-5678-1234',2);
insert into tb_contact (contact_no,contact_typ_cd,contact_info,cust_no)
values(4,'CTC002','bwlee@gmail.com',2);

-- ALTER TABLE --
alter table tb_contact
add constraint FK_TB_CONTACT_1 foreign key (CUST_NO) references TB_CUST(CUST_NO)
on delete no action;

alter table tb_contact
add constraint FK_TB_CONTACT_1 foreign key (CUST_NO) references TB_CUST(CUST_NO)
on delete set NULL;

alter table tb_contact
add constraint FK_TB_CONTACT_1 foreign key (CUST_NO) references TB_CUST(CUST_NO)
on delete CASCADE;

--------------------

drop table if exists TB_EMP;
create table TB_EMP
(
	EMP_NO SERIAL primary key
,	FIRST_NM VARCHAR(50)
,	LAST_NM VARCHAR(50)
,	BIRTH_DE DATE check (BIRTH_DE>'1900-01-01')
,	JOIN_DE DATE check (JOIN_DE > BIRTH_DE)
,	SAL_AMT numeric check (SAL_AMT > 0 )
);

insert into TB_EMP (FIRST_NM,LAST_NM,BIRTH_DE,JOIN_DE,SAL_AMT)
values ('순신','이','1994-07-12','1883-01-02',-100000);

insert into TB_EMP (FIRST_NM,LAST_NM,BIRTH_DE,JOIN_DE,SAL_AMT)
values ('순신','이','1994-07-12','2009-01-02',5000000);

select*from TB_EMP;

-------------------- 테이블 생성 (체크 제약조건 없음)
drop table if exists TB_EMP;
create table TB_EMP
(
	EMP_NO SERIAL primary key
,	FIRST_NM VARCHAR(50)
,	LAST_NM VARCHAR(50)
,	BIRTH_DE DATE
,	JOIN_DE DATE
,	SAL_AMT numeric
);


insert into TB_EMP (FIRST_NM,LAST_NM,BIRTH_DE,JOIN_DE,SAL_AMT)
values ('순신','이','1994-07-12','1883-01-02',-100000);

alter table TB_EMP
add constraint TB_EMP_SAL_AMT_CHECK CHECK(SAL_AMT > 0);

truncate table TB_EMP;
-----------
drop table if exists TB_PERSON;

create table TB_PERSON
(
	PERSON_NO SERIAL primary key
,	FIRST_NM VARCHAR(50)
,	LAST_NM VARCHAR(50)
,	EMAIL_ADRES	VARCHAR(50) UNIQUE
);

insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
VALUES('순신','이','sclee@gmail.com');

----- unique 위반
insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
VALUES('순신','이','sclee@gmail.com');

-----
drop table if exists tb_person;

create table TB_PERSON
(
	PERSON_NO SERIAL primary key
,	FIRST_NM VARCHAR(50)
,	LAST_NM VARCHAR(50)
,	EMAIL_ADRES	VARCHAR(50)
,	unique(FIRST_NM,LAST_NM,EMAIL_ADRES)	-- 값의 조합은 각각의 행이 모두 유일한 값이어야 함.
);

insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
VALUES('순신','이','sclee@gmail.com');

insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
VALUES('방원','이','sclee@gmail.com');

-----
drop table if exists tb_person;

create table TB_PERSON
(
	PERSON_NO SERIAL primary key
,	FIRST_NM VARCHAR(50)
,	LAST_NM VARCHAR(50)
,	EMAIL_ADRES	VARCHAR(50)
);

-- 유니크 인덱스 생성
create unique index IDX_TB_PERSON_01 on TB_PERSON(FIRST_NM,LAST_NM,EMAIL_ADRES);

-- 유니크 제약조건을 걸어줌
alter table tb_person
add constraint CONSTRAINT_TB_PERSON_01
unique using index IDX_TB_PERSON_01;

--
drop table if exists TB_PERSON;

create table TB_PERSON
(
	PERSON_NO SERIAL primary key
,	FIRST_NM VARCHAR(50) null
,	LAST_NM VARCHAR(50) null
, 	EMAIL_ADRES VARCHAR(50) NOT NULL
);

insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
values ('순신','이',NULL);

insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
values ('순신','이','sclee@gmail.com');
select*from tb_person;

alter table tb_person alter column first_nm set not null;
alter table tb_person alter column last_nm set not null;

insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
values (null,null,'null@gmail.com');
insert into TB_PERSON (FIRST_NM,LAST_NM,EMAIL_ADRES)
values ('방원','이','bwlee@gmail.com');
select*from tb_person where first_nm = '방원';