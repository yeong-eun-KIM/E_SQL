select first_name
from customer
;

select
	first_name
,	last_name
,	email
from customer
;

select * from customer
;

select
	first_name||'	'||last_name as first_last_name
,	email
from customer
;

---------------
select *
from gmv_trend gt
;
select *
from gmv_trend gt
limit 10
;
--  특정 컬럼 추출하기
select category as 카테고리, yyyy 년도, mm 월
from gmv_trend gt
;

-- 중복값 없이 특정 컬럼 추출하기
select distinct category
from gmv_trend gt
;

select distinct category, yyyy
from gmv_trend gt
;

-- 앨리어스
select A.customer_id as CUST_ID
,	A.first_name ||" "||A.last_NAME	as "FULL NAME"
,	a.email as 이메일
from customer as A
;

-- 조건이 하나일때, 숫자열
-- 특정 연도의 매출 탐색하기
select *
from gmv_trend
where yyyy = 2021
;

-- 2019년 이후의 매출 탐색하기
select *
from gmv_trend gt
where yyyy >=2019
;

-- between ~ and
select *
from gmv_trend gt
where yyyy between 2018 and 2020
;

select *
from gmv_trend gt
where yyyy != 2021
;

-- 조건이 하나일때, 문자열
select *
from gmv_trend gt
where category = '컴퓨터 및 주변기기'
;

select *
from gmv_trend gt
where category != '컴퓨터 및 주변기기'
;

-- amount 컬럼의 값 11.00 보다 큰 행을 추출하시오.
-- id, amount, date
select a.payment_id
,	a.amount
,	a.payment_date
from payment A
where A.amount > 11.00
;

--amount 컬럼의 값 0.99 보다 작은 행을 추출하시오.
select a.payment_id
,	a.amount
,	a.payment_date
from payment A
where A.amount < 0.99
;

-- 조건이 여러개 일 때 and 조건
select *
from gmv_trend gt
where category='컴퓨터 및 주변기기'
and yyyy = 2021
;

-- or 조건
select *
from gmv_trend gt
where gmv > 1000000 or gmv < 10000
;

-- and, or 조건
select *
from gmv_trend gt
where (gmv > 1000000 or gmv < 10000) and yyyy=2021
;

-- first_name Tiffany이고 last_name 'Jordan'인 행을 추출하시오.
select *
from customer A
where a.first_name='Tiffany' 
and a.last_name ='Jordan'
;

-- first_name이 'Michael'이거나 last_name이 'lee'인 행을 추출하시오.
select A.first_name
,		A.last_name
from customer A
where A.first_name = 'Michael'
or A.last_name = 'Lee'
;

-- first_name이 'Tiffany'가 아니고 last_name이 'jordan'인 행을 추출하시오.
select A.first_name
,		A.last_name
from customer A
where A.first_name != 'Tiffany'
and A.last_name != 'Jordan'
;

-- amount가 10부터 11사이에 있는 행은 모두 리턴하시오.
select p.customer_id 
,	p.payment_id
,	p.amount
from payment p
where p.amount between 10 and 11
;

select p.customer_id 
,	p.payment_id
,	p.amount
from payment p
where p.amount not between 10 and 11
;

--2007-02-15 22:25:46.996
-- payment_date가 2007년 2월 14일의 모든 행을 리턴하시오.
select
	p.customer_id
,	p.payment_id
,	p.amount
,	p.payment_date
from payment p
where p.payment_date between '2007-02-14 00:00:00.000000'
and '2007-02-14 23:59:59.999999'
order by p.payment_date
;

-- 매출이 낮은 순으로 정렬 추출하시오
select *
from gmv_trend gt
order by GMV
;

-- FIRST_NAME 컬럼의 값을 기준으로 오름차순 정렬하시오.
select
	A.customer_id
,	A.first_name
,	A.last_name
from customer A
order by first_name
;


-- FIRST_NAME 내림, LAST_NAME 오름 정렬
select
	A.customer_id
,	A.first_name
,	A.last_name
from customer A
order by first_name desc, last_name asc
;

select
	A.customer_id
,	A.first_name
,	LENGTH(A.last_name) as LENGTH_LAST_NAME
,	A.last_name
from customer A
order by LENGTH_LAST_NAME desc
;

select
	A.customer_id
,	A.first_name
,	LENGTH(A.last_name) as LENGTH_LAST_NAME
,	A.last_name
from customer A
order by 3 desc
;

-----
drop table if exists TB_SORT_TEST;
create table TB_SOFT_TEST 
(
	NUM INT
);

insert into tb_soft_test (NUM) values (1);
insert into tb_soft_test (NUM) values (2);
insert into tb_soft_test (NUM) values (3);
insert into tb_soft_test (NUM) values (NULL);

select * from tb_soft_test tst;

-- NULL이 무조건 맨 위로 올라오게 됨
select *
from tb_soft_test
order by NUM nulls first
;

select *
from tb_soft_test
order by NUM nulls last
;

select *
from tb_soft_test
order by num desc nulls last
;

-- IN 연산자
select *
from gmv_trend
where category in ('컴퓨터 및 주변기기', '생활용품')
;

select *
from gmv_trend
where category not in ('컴퓨터 및 주변기기', '생활용품')
;

-- customer_id가 1혹은 2인 행을 모두 리턴하시오.
select r.customer_id
,	r.rental_id
,	r.return_date
from rental r
where r.customer_id in (1,2)
order by r.return_date
;

-- in 연산자와 or연삽은 결과 집합이 동일함
select r.customer_id
,	r.rental_id
,	r.return_date
from rental r
where r.customer_id=1
or r.customer_id=2
order by r.return_date
;

-- customer_id가 1 혹은 2가 아닌 모든 행을 모두 리턴하시오.
select r.customer_id
,	r.rental_id
,	r.return_date
from rental r
where r.customer_id not in (1,2)
order by r.return_date desc
;

select r.customer_id
,	r.rental_id
,	r.return_date
from rental r
where r.customer_id <> 1
and r.customer_id <> 2
and r.return_date is not null
order by r.return_date desc
;

-- limit	film_id 기준으로 
select 
	A.film_id
,	A.title
,	A.release_year
from film A
order by A.film_id
limit 5
;


-- 출력하는 시작행은 4번째 행부터 2건만 출력함
-- offset3 : 0,1,2,3 즉 4번째 행임을 의미함 (0부터 시작함)
select 
	A.film_id
,	A.title
,	A.release_year
from film A
order by A.film_id
limit 2 offset 3
;

-- rental_date 컬럼을 기준으로 내림차순 정렬 한 후 정렬 된 집합 중에서 10건만 출력
-- 가장 최근에 렌트한 10건을 조회
select *
from rental r
order by r.rental_date desc
limit 10
;

select
	F.film_id
,	F.title
,	F.release_year
from film F
order by F.film_id
fetch first 5 row
only
;

--출력하는 시작행은 4번째 행부터 2건만 출력하시오.
select
	F.film_id
,	F.title
,	F.release_year
from film F
order by F.film_id
fetch first 2 row only offset 3
;

--
select * 
from gmv_trend gt
where category like '%패션%'
;

select * 
from gmv_trend gt
where category not like '%패션%'
;

-- first_name이 "Jen"으로 시작하는 모든 행을 리턴하시오
-- cu_id,first_n,last_n

select
	c.customer_id
,	c.first_name
,	c.last_name
from customer c
where first_name like 'Jen%'
;

-- Jen + 3자리 즉 총 6자리만 있으면 리턴함
select
	c.customer_id
,	c.first_name
,	c.last_name
from customer c
where first_name like 'Jen___'
;

-- 총 여섯자리 이상인 모든 행 리턴
select
	c.customer_id
,	c.first_name
,	c.last_name
from customer c
where first_name like 'Jen___%'
;

-- NULL 비교
drop table if exists TB_CONTACT;
create table tb_contact
(
	CONTACT_NO SERIAL primary key
,	FIRST_NM VARCHAR(50) not null
,	LAST_NM VARCHAR(50) not null
,	EMAIL_ADRES VARCHAR(255) not null
, 	PHONE_NO VARCHAR(15)
);

insert into tb_contact (FIRST_NM,LAST_NM,EMAIL_ADRES,PHONE_NO)
values ('순신','이','sclee@gmail.com','010-1234-5678');
insert into tb_contact (FIRST_NM,LAST_NM,EMAIL_ADRES,PHONE_NO)
values ('방원','이','bwlee@gmail.com',null);
select * from tb_contact;

-- phone_number 컬럼의 값이 null인 행을 리턴하시오.
select 
	tc.first_nm
,	tc.last_nm
,	tc.email_adres
,	tc.phone_no
from tb_contact tc
where tc.phone_no is null
;

select 
	tc.first_nm
,	tc.last_nm
,	tc.email_adres
,	tc.phone_no
from tb_contact tc
where tc.phone_no is not null
;

-- CASE문
-- 길이(LENGTH) 50분 이하면 SHORT로 함
-- 길이가 50분을 초과하고 120분보다 작거나 같으면 MEDIUM으로 함
-- 길이가 120분을 초과하면 LONG으로 함

select
	A.title
,	A.length
,	case when length>0 and length <=50 then 'SHORT'
	when LENGTH>50	and LENGTH <=120 then 'MEDIUM'
	when LENGTH>120 then 'LONG'
	end duration
from film A
order by A.title
;

-- 길이가 50분이하면 1로 함
-- 길이가 50분을 초과하고 120분보다 작거나 같으면 2로 함
-- 길이가 120분을 초과하면 3으로 함
-- desc로 정렬함

select
	A.title
,	A.length
,	case when length>0 and length <=50 then 'SHORT'
		when LENGTH>50	and LENGTH <=120 then 'MEDIUM'
		when LENGTH>120 then 'LONG'
	end duration
from film A
order by case when length>0 and length <=50 then 1
			  when LENGTH>50	and LENGTH <=120 then 2
			  when LENGTH>120 then 3
		 end desc, A.length desc
;