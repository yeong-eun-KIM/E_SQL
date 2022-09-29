drop table if exists TB_ACCOUNT;
create table TB_ACCOUNT
(
	ACCOUNT_NO INT
,	ACCOUNT_NM VARCHAR(100) not null
,	BALANCE_AMT numeric(15) not null
,	primary key(ACCOUNT_NO)
);

select * from tb_account;


insert into tb_account VALUES(1,'일반계좌',15000.45);

select * from tb_account
where account_no=1;

insert into tb_account VALUES(2,'비밀계좌',25000.45);

commit;

-- insert
drop table if exists TB_LINK;
create TABLE TB_LINK (
	LINK_NO INT primary key
,	URL VARCHAR(255) not NULL
,	LINK_NM VARCHAR(255) not null
,	DSCRPTN VARCHAR(255) not null
,	LAST_UPDATE_DE DATE
);

commit;

insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (1,'www.ezenac.co.kr','이젠아카데미컴퓨터학원','홈페이지',CURRENT_DATE);  

commit;
select * from tb_link;

insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (2,'www.google.com','구글','검색',CURRENT_DATE)
returning *;

commit;
select * from tb_link;

-- insert문 수행 후 insert 한 행에서 link_no 컬럼의 값을 출력하시오
insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (3,'www.daum.net',' 다음','홈페이지',CURRENT_DATE)
returning link_no;

commit;
select * from tb_link;

-- update
drop table if exists TB_LINK;
create TABLE TB_LINK (
	LINK_NO INT primary key
,	URL VARCHAR(255) not NULL
,	LINK_NM VARCHAR(255) not null
,	DSCRPTN VARCHAR(255) not null
,	LAST_UPDATE_DE DATE
);

insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (1,'www.ezenac.co.kr','이젠아카데미컴퓨터학원','홈페이지',CURRENT_DATE);
insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (2,'www.google.com','구글','검색',CURRENT_DATE);
insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (3,'www.daum.net',' 다음','홈페이지',CURRENT_DATE);

update tb_link
set link_nm='이젠에이씨오쩜케이알' 
where link_no=1;

commit;

select * from tb_link
where link_no=1
;
update tb_link
set link_nm = '구글닷컴'
where link_no=2
returning *
;

commit;

-- update하면서 update한 행에서 link_no,link_nm 컬럼을 출력하시오
update tb_link
set link_nm = '다음닷넷'
where link_no =3
returning link_no, link_nm
;

commit;
select * from tb_link
where link_no=3
;

---
drop table if exists tb_prdt_cl;
create table TB_PRDT_CL
(
	PRDT_CL_NO	INTEGER primary KEY
,	PRDT_CL_NM VARCHAR(50)
,	DISCOUNT_RATE NUMERIC(2,2)
);

drop table if exists TB_PRDT;
create table tb_prdt
(
	PRDT_NO INTEGER primary key
,	PRDT_NM VARCHAR(50)
,	PRC numeric(15)
,	SALE_PRC NUMERIC(15)
,	PRDT_CL_NO INTEGER
,	foreign key(PRDT_CL_NO) references TB_PRDT_CL(PRDT_CL_NO)	
);

select * from tb_prdt_cl;
select * from TB_PRDT;

commit;

insert into TB_PRDT_CL values (1,'Smart Phone',0.20);
insert into TB_PRDT_CL values (2,'Tablet',0.25);

insert into tb_prdt values (1,'갤럭시 S22 Ultra',1551000,null,1);
insert into tb_prdt values (2,'갤럭시 S21 Ultra',1501000,null,1);
insert into tb_prdt values (3,'갤럭시 탭 S8 Ultra',1378300,null,2);
insert into tb_prdt values (4,'갤럭시 탭 S7 FE',719400,null,2);

commit;

select * from tb_prdt_cl;
select * from TB_PRDT;

update TB_PRDT a
set sale_prc = a.prc - (a.prc*b.discount_rate)
from tb_prdt_cl b
where a.prdt_cl_no = b.prdt_cl_no
;

----------------------------------------delete
drop table if exists TB_LINK;
create TABLE TB_LINK (
	LINK_NO INT primary key
,	URL VARCHAR(255) not NULL
,	LINK_NM VARCHAR(255) not null
,	DSCRPTN VARCHAR(255) not null
,	LAST_UPDATE_DE DATE
);

insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (1,'www.ezenac.co.kr','이젠아카데미컴퓨터학원','홈페이지',CURRENT_DATE);
insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (2,'www.google.com','구글','검색',CURRENT_DATE);
insert into TB_LINK (LINK_NO,URL,LINK_NM,DSCRPTN,LAST_UPDATE_DE) 
values (3,'www.daum.net',' 다음','홈페이지',CURRENT_DATE);

select * from tb_link;

commit;

delete
from tb_link a
where a.link_nm = '이젠아카데미컴퓨터학원'
;

rollback;


delete
from tb_link A
where A.link_nm='구글'
returning *
;

select * from TB_LINK;

-- delete한 다음 delete 된 행의 내용 중 LINK_NO,LINK_NM 컬럼을 출력
delete
from tb_link a
where a.link_nm='다음'
returning a.link_no,a.link_nm
;

commit;
select * from tb_link;

--------UPSERT
drop table if exists TB_CUST;
create table tb_cust
(
	CUST_NO int
,	CUST_NM varchar(50) unique
,	EMAIL_ADRES VARCHAR(200) not NULL
,	VALID_YN CHAR(1) not null
,	constraint PK_TB_CUST primary KEY(CUST_NO)
);

commit;

insert into TB_CUST values (1,'이순신','shlee@gmail.com','Y');
insert into TB_CUST values (2,'이방원','BWlee@gmail.com','Y');

commit;

select * from TB_CUST;

-- 중복되는 cust_nm값을 insert 하려고 한다면 아무것도 하지 말라고 하는 것임
insert into TB_CUST (CUST_NO,cust_nm,email_adres,valid_yn)
values (3,'이순신','shlee@gmail.com','Y')
on conflict (cust_nm) do nothing
;

commit;

-- cust_no에 1은 이미 존재하는 행임
-- 중복되는 행이 입력되려고 할 때 update set을 함
insert into TB_CUST (CUST_NO,cust_nm,email_adres,valid_yn)
values (1,'이순신','shlee7@gmail.co.kr','N')
on conflict (cust_no) 
do update set email_adres= excluded.email_adres
			  ,valid_yn = excluded.valid_yn
;

commit;
select * from tb_cust;

----------------group by
-- customer_id 컬럼의 값 기준으로 group by 함
-- 해당 컬럼값 기준으로 중복이 제거된 행이 출력됨
select p.customer_id
from payment p
group by p.customer_id
order by p.customer_id
;

-- customer_id 컬럼별 amount의 합계가 큰 순으로 10건을 출력하시오
select 
	p.customer_id
,	sum(amount) amt
from payment p
group by p.customer_id
order by amt desc
limit 10
;

-- first_nm, last_nm도 같이 출력하시오
-- customer_id는 fisrt_nm,last_nm을 결정 지을 수 있는 관계이기 때문에 max() 사용가능함
select
	p.customer_id
,	max(c.first_name) "first_name"
,	max(c.last_name) "last_name"
,	sum(amount) sum
from payment p
join customer c
on p.customer_id = c.customer_id
group by 1
order by 4 desc
limit 10
;

-- HAVING
-- sum>200인 결과집합을 추출하시오
select
	p.customer_id
,	max(c.first_name) "first_name"
,	max(c.last_name) "last_name"
,	sum(p.amount) sum
from payment p
join customer c
on p.customer_id = c.customer_id
group by 1
having sum(p.amount)>=200
order by 4 desc
limit 10
;

-- customer_id, first_nm, last_nm, payment_id의 수가 40 이상인 결과집합 출력
select
	p.customer_id,
	max(c.first_name) "first_name", 
	max(c.last_name)  "last_name", 
	count(p.payment_id) count
from payment p
join customer c
on p.customer_id = c.customer_id
group by 1
having count(p.payment_id) >= 40
order by 4 desc
;