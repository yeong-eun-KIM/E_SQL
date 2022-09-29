select 1 + 1 as 일더하기일;

create table TB_EMP
(
	EMP_NO CHAR(10)	--고정 길이 10자리 문자열
,	EMP_NM VARCHAR(50)	-- 최대 50자리의 가변 길이 문자열
,	SELF_INTRO text	-- 길이 제한이 없는 가변 길이 문자열
);

drop table TB_EMP;

create table TB_EMP
(
	EMP_NO SERIAL primary key
,	AGE smallint
,	GRADE_POINT NUMERIC(3,2)
, SAL NUMERIC(9)
, TOT_ASEET INT
);

insert into tb_emp (AGE,grade_point,sal,tot_aseet)
values (35, 4.25, 5870000, 125000000);
insert into tb_emp (AGE,grade_point,sal,tot_aseet)
values (36, 4.5, 500000, 125005000);

select  * from tb_emp;
drop table tb_emp ;

create table TB_EMP  
(
	BIRTH_DE DATE
,	JOIN_DT TIMESTAMPTZ
,	JOIN_DT_WITHOUT_TIMEZONE TIMESTAMP
,	TASK_BEGIN_TM TIME
);

insert into tb_emp 
values ('2022-09-21','2022-09-21 125630.123456',
'2022-09-22 125630.123456 'at time zone 'America/Santiago','18:00:00');

select * from tb_emp ;

show TIMEZONE;

drop table tb_emp ;

/*
 *	:: 타입변환
 *	value::type 
 */
select current_date as "current_date"		--현재날짜 가져오기
,	current_time as "current_time"			--현재날짜(마이크로세컨드 단위까지) 가져오기
,	current_timestamp  as "current_timestamp"		--현지일시
,	now() as "now()"								--현지일시(마이크로세컨드 단위까지) 가져오기
,	now()::date as "now()::date"	--현재날짜 가져오기
,	now()::time as "now()::time"	--현지시간 가져오기
;

------------<테이블 참조>-------------------------------
create TABLE TB_USER
(
	user_id char(10) primary key
,	user_name varchar(50) not null
,	password varchar(50) not null
,	email_address varchar(255) unique not null
,	create_on timestamp not null
,	last_login timestamp
);

create table tb_role
(
	role_id char(10) primary key
,	role_nm varchar(255) not null
);

create table tb_user_role
(
	user_id char(10) not null
,	role_id char(10) not null
,	primary key (user_id,role_id)
,	foreign key (user_id) references tb_user(user_id)
,	foreign key (role_id) references tb_role(role_id)
);


------------<테이블 수정>-------------------------------
drop table if EXISTS TB_LINK;
create  table TB_LINK
(
	LINK_ID SERIAL PRIMARY key
,	TITLE VARCHAR(512) not null
,	URL VARCHAR(1024) not NULL
);

alter table tb_link add column ACTIVE_YN CHAR(1);
select * from tb_link;

alter table TB_LINK drop column ACTIVE_YN;

alter table TB_LINK rename column TITLE to LINK_TITLE;

alter table TB_LINK add column TARGET VARCHAR(10);

--TARGET 컬럼의 디폴트 값을 '_BLANK'로 지정

alter table TB_LINK alter column TARGET set default '_BLANK';

insert into TB_LINK (link_title,url) values ('애플','http://www.apple.com/');
select * from tb_link;

-- Target 컬럼에 저장되는 값은 '_blank','_parent','_self','_top'으로만 함
alter  table tb_link add check (TARGET in('_blank','_parent','_self','_top'));

insert into tb_link (link_title,url,target)
values('피그마','http://www.figma.com/','체크 제약조건에 없는거');

insert into tb_link (link_title,url,target)
values('피그마','http://www.figma.com/','_self');

-- url 컬럼에 unique 제약 조건 추가
alter table tb_link  add constraint UNIQUE_URL UNIQUE (URL);

insert into TB_LINK(LINK_TITLE,URL,TARGET)
values ('사과','http://www.apple.com/','_self');

---------------------------------------------------------------
create table TB_ASSET
(
	ASSET_NO SERIAL primary key
,	ASSET_NM text not null
,	ASSET_ID VARCHAR not NULL
,	DESCIPTION text
,	LOC text
,	ACQUIRED_DE DATE not NULL
);

insert into tb_asset (asset_nm,asset_id,LOC,acquired_de)
VALUES('SERVER','10001','SERVER ROOM','2022-09-21');
insert into tb_asset (asset_nm,asset_id,LOC,acquired_de)
VALUES('UPS','10002','SERVER ROOM','2022-09-22');

select * from tb_asset;

alter table tb_asset alter column ASSET_NM type varchar;
alter table tb_asset 
	alter column DESCIPTION type varchar
, 	alter column LOC type varchar
;

-- 문자형을 숫자형으로 변경 => using절 이하 추가 ::사용
alter table tb_asset alter column ASSET_ID type int using ASSET_ID::INTEGER;

alter table tb_asset RENAME column ASSET_ID TO ASSET_ID2;

create table TB_INVOICE
(
	INVOICE_NO SERIAL primary key
,	ISSUE_DE TIMESTAMP
,	PRDT_NM	VARCHAR(150)
);

insert into tb_invoice (issue_de,prdt_nm) values (CURRENT_TIMESTAMP,'아메리카노');
insert into tb_invoice (issue_de,prdt_nm) values (CURRENT_TIMESTAMP,'카페라뗴');
insert into tb_invoice (issue_de,prdt_nm) values (CURRENT_TIMESTAMP,'모카라떼');

select * from tb_invoice;
-- 테이블 내용 전체 비우기 --
truncate table tb_invoice ;

-- 테이블 내용을 비우면서 serial 값 초기화 --
truncate table tb_invoice restart identity;

-- 테이블 제거 --
drop table tb_invoice;