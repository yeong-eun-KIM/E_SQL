drop table if exists data_type_test;
create table date_type_test
(
	a_boolean boolean,
	b_char char(10),
	c_varchar varchar(10),
	d_text text,
	e_int int,
	f_smallint smallint,
	g_float float,
	h_numeric numeric(15,2)
);

insert into date_type_test values
(
	true,
	'ABCDE',
	'ABCDE',
	'text',
	1000,
	10,
	10.12345,
	10.25
);

select * from date_type_test;

--
drop table if exists account;
create table account
(
	user_id serial primary key,
	username varchar(50) unique not null,
	password varchar(50) not null,
	email varchar(255) unique not null,
	created_on timestamp not null,
	last_login timestamp
);

drop table if exists role;
create table if not exists role
(
	role_id serial primary key,
	role_name varchar(255) unique not null
);

create table if not exists account_role
(
	user_id integer not null,
	role_id integer not null,
	primary key (user_id,role_id),
	constraint account_role_role_id_fkey foreign key (role_id) references role(role_id) 
	on update no action on delete no action,
	constraint account_role_user_id_fkey foreign key (user_id) references account(user_id) 
	on update no action on delete no action,
	grand_date timestamp without time zone
);

insert into account values (1,'이순신','0111','shlee@gmail.com',current_timestamp,null);
select * from account;

insert into role values (1,'DBA');
select * from role;

insert into account_role VALUES(1,1,CURRENT_TIMESTAMP);
select * from ACCOUNT_ROLE;

-- 제약조건 위반
insert into account_role VALUES(2,1,CURRENT_TIMESTAMP);
insert into account_role VALUES(1,2,CURRENT_TIMESTAMP);
insert into account_role VALUES(1,1,CURRENT_TIMESTAMP);

update account set user_id = 2 where user_id = 1;
delete from account where user_id=1;

--
select
	A.film_id,
	A.title,
	A.release_year,
	A.length,
	A.rating
from 
	film A,
	film_category C
where A.film_id = C.film_id
and C.category_id = 1
;

create table if not exists ACTION_FILM
	as 
	select
	A.film_id,
	A.title,
	A.release_year,
	A.length,
	A.rating
from 
	film A,
	film_category C
where A.film_id = C.film_id
and C.category_id = 1
;

drop table links;
create table if not exists LINKS
(
	LINK_ID SERIAL primary key,
	TITLE VARCHAR(500) not null,
	URL VARCHAR(1024) not null UNIQUE
);

-- ACTIVE 컬럼 추가

alter TABLE LINKS add column ACTIVE BOOLEAN;

alter table LINKS drop column ACTIVE;

alter table LINKS add column TARGET VARCHAR(10);
alter table LINKS rename column TITLE to LINK_TITLE;
alter table LINKS alter column TARGET set default '_BLANK';

insert into LINKS (LINK_TITLE,URL) values ('POSTGRESSQL','http://www.tutorialpoint.com/postgresql/index.html');

select * from links;
---------------
create table vendors
(
	ID SERIAL primary key,
	NAME VARCHAR not NULL
);

select * from vendors;

alter table vendors rename to supplies;

select * from supplies;

create table if not exists supplier_groups
(
	id serial primary key,
	name varchar not null
);

alter table supplies add column group_id int not null;

alter table supplies add foreign key (group_id) references supplier_groups(id);

-- 뷰 생성
-- 뷰는 테이블처럼 실체하는 데이터가 아닌 보기전용으로 만들어진 객체임
create view supplier_data as
select
	s.id,
	s."name",
	sg."name" "group_name"
	from 
		supplies s, supplier_groups sg
	where 
		s.id = sg.id;
		
select * from supplier_data;
-- 참조하고 있는 테이블의 이름이 자동으로 변경 반영됨
alter table supplier_groups rename to groups;

select * from groups;
--
--dvd 렌탈 시스템의 관리자는 고객별 매출 순위를 알고 싶습니다.
-- 신규 테이블로 고객의 매출 순위를 관리하고 싶습니다.
-- 테이블 이름 customer_rank이고
-- 테이블 구성은 customer, payment를 활용해서 구성합니다.
-- ctas 기법을 이용하여 신규테이블을 생성하고 데이터를 입력하시오.

-- 반납일자가 2005년 5월 29일 렌탈 내역의 film_id를 조회하시오.
-- 방법1) JOIN 이용
select i.film_id
from inventory i
join rental r
on i.inventory_id = r.inventory_id
where r.return_date >= '2005-05-29 00:00:00.000' and r.return_date <= '2005-05-29 23:59:59.999'
;

-- 방법2) 서브쿼리 이용 (film_id, film_title 출력)
select f.film_id, f.title
from film f
where f.film_id in
	(
	select i.film_id
	from inventory i
	join rental r
	on i.inventory_id = r.inventory_id
	where r.return_date 
	between '2005-05-29 00:00:00.000' and '2005-05-29 23:59:59.999'
	)
;

-- amount가 9.00을 초과하고 payment_date가 2007-02-15 ~ 2007-02-19 사이에 결제 내역이 있는 고객의 이름을 출력하시오.
-- 출력 컬럼 : customer_id, fisrt_nm, last_nm

select c.customer_id, c.first_name, c.last_name
from customer c
where c.customer_id in
	(
		select p.customer_id
		from payment p
		where c.customer_id = p.customer_id
		and (p.amount > 9.00)
		and (p.payment_date between '2007-02-15 00:00:00.000' and '2007-02-19 23:59:59.999')
	)
order by c.first_name
;

select c.customer_id, c.first_name, c.last_name
from customer c
where exists
	(
		select 1
		from payment p
		where c.customer_id = p.customer_id
		and (p.amount > 9.00)
		and (p.payment_date between '2007-02-15 00:00:00.000' and '2007-02-19 23:59:59.999')
	)
order by c.first_name
;

-- amount가 9.00을 초과하고 payment_date가 2007-02-15 ~ 2007-02-19 사이에 결제 내역이 없는 고객의 이름을 출력하시오.
-- 출력 컬럼 : customer_id, fisrt_nm, last_nm
select c.customer_id, c.first_name, c.last_name
from customer c
where not exists
	(
		select 1
		from payment p
		where c.customer_id = p.customer_id
		and (p.amount > 9.00)
		and (p.payment_date between '2007-02-15 00:00:00.000' and '2007-02-19 23:59:59.999')
	)
order by c.first_name
;


-- 인라인뷰 활용
-- amount가 9.00을 초과하고 payment_date가 2007-02-15 ~ 2007-02-19 사이에 결제 내역이 있는 고객의 이름을 출력하시오.
-- 출력 컬럼 : customer_id, fisrt_nm, last_nm, amount, payment_date
select c.customer_id,c.first_name,c.last_name,p2.amount,p2.payment_date
from customer c, 
	(	
		select p.customer_id,p.amount,p.payment_date
		from payment p
		where (p.amount > 9.00)
		and (p.payment_date between '2007-02-15 00:00:00.000' and '2007-02-19 23:59:59.999')
	) p2
where c.customer_id = p2.customer_id
order by customer_id
;

-- 스칼라 서브쿼리 활용
select c.customer_id, c.first_name, c.last_name,
		pay.amount, pay.payment_date, 
		(
			select s.first_name||' '||s.last_name
			from staff s
			where s.staff_id = pay.staff_id
		) as staff_nm,
		(
			select r.rental_date||'~'||r.return_date
			from rental r
			where r.rental_id = pay.rental_id
		) as rental_duration
from customer c, 
	(	
		select p.customer_id,p.amount,p.payment_date, p.staff_id, p.rental_id
		from payment p
		where (p.amount > 9.00)
		and (p.payment_date between '2007-02-15 00:00:00.000' and '2007-02-19 23:59:59.999')
	) pay
where c.customer_id = pay.customer_id
order by c.customer_id
;
