create table if not exists PRODUCT_GROUP(
	GROUP_ID INT primary key,
	GROUP_NAME VARCHAR(255) not NULL
);

create table if not exists PRODUCT(
	PRODUCT_ID SERIAL primary key,
	PRODUCT_NAME VARCHAR(255) not null,
	PRICE DECIMAL(11,2),
	GROUP_ID INT not null,
	foreign key (GROUP_ID) references PRODUCT_GROUP(GROUP_ID)
);

insert into PRODUCT_GROUP values (1, 'SMARTPhone'),(2,'Laptop'),(3,'Tablet');

select * from product_group;

insert into product (product_name, group_id, price)
					values ('Xiaomi 125 Ultra',1,200), ('Pixel 6 pro',1,400),
							('갤럭시 S22 Ultra',1,500 ), ('iPhone 14 pro',1,900),
							('YOGA Slim7 pro',2,1200), ('삼성 2022갤럭시북2 프로',2 ,700),
							('LG 울트라PC 15u560',2,700), ('Apple 2022 맥북 에어',2,800),
							('레노버 TAB M10 H',3,150), ('삼성 갤럭시탭 S8 ',3,200),
							('Apple 아이패드 10.2',3,700);
						
select * from product;

-- 집계함수는 집계의 결과만을 출력함
select count(*) from product;

-- 분석함수는 집계의 결과 및 집합(테이블의 내용)을 함께 출력함
select count(*) over() as cnt, p.*
from product p
order by p.product_id;

select p.group_id, count(*) as cnt
from product p
group by p.group_id
order by p.group_id
;

select p.*, count(*) over(partition by p.group_id) as cnt
from product p
order by p.product_id
;

-- avg()
select avg(price)
from product p;

-- group by + avg()
-- group_name 컬럼을 기준으로 PRICE 컬럼의 평균값을 구하시오
select
	pg.group_name,
	avg(p.price)
from product p
join product_group pg
on p.group_id = pg.group_id
group by 1
;

-- 분석함수 사용
-- 결과 집합 그대로 출력 + group_name 컬럼을 기준으로 평균 출력
select
	p.product_name,
	p.price,
	pg.group_name,
	avg(price) over (partition by pg.group_name) as group_name_avg
from product p
join product_group pg
on p.group_id = pg.group_id
;

select
	p.product_name,
	p.price,
	pg.group_name,
	avg(price) over (partition by pg.group_name order by pg.group_name) as group_name_avg
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- row_number()
select 
	p.product_name,
	pg.group_name,
	p.price,
	row_number() over(partition by pg.group_name order by p.price) as row_number
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- rank()
select 
	p.product_name,
	pg.group_name,
	p.price,
	rank() over(partition by pg.group_name order by p.price) as rank
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- dense_rank()
-- rank()
select 
	p.product_name,
	pg.group_name,
	p.price,
	dense_rank() over(partition by pg.group_name order by p.price) as dense_rank
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- first_value()
-- 가장 첫번째 나오는 price 값을 출력하시오 (그룹별 가장 비싼것만 출력)
select 
	p.product_name,
	pg.group_name,
	p.price,
	first_value (p.price) over (partition by pg.group_name order by p.price desc) as first_value
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- 누적평균을 구하시오
select
	p.product_name,
	p.price,
	pg.group_name,
	avg(price) over (partition by pg.group_name order by p.price) 
	as cumulative_aggregate_avg
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- last_value()
select 
	p.product_name,
	pg.group_name,
	p.price,
	last_value (p.price) over (partition by pg.group_name order by p.price desc
	range between unbounded preceding and unbounded following) as last_values
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- unbounded following 생략시 아래와 같은 의미임
select 
	p.product_name,
	pg.group_name,
	p.price,
	last_value (p.price) over (partition by pg.group_name order by p.price desc
	range between unbounded preceding and current row) as last_values
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- lag()
select
	p.product_name,
	pg.group_name,
	p.price,
	lag(p.price,1) over (partition by pg.group_name order by p.price) as prev_price,
	p.price - lag(p.price,1) over (partition by pg.group_name order by p.price) as cur_prev_diff
from product p
join product_group pg
on p.group_id = pg.group_id
;

select
	p.product_name,
	pg.group_name,
	p.price,
	lag(p.price,2) over (partition by pg.group_name order by p.price) as prev_price,
	p.price - lag(p.price,2) over (partition by pg.group_name order by p.price) as cur_prev_diff
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- lead()
select
	p.product_name,
	pg.group_name,
	p.price,
	lead(p.price,1) over (partition by pg.group_name order by p.price) as prev_price,
	p.price - lead(p.price,1) over (partition by pg.group_name order by p.price) as cur_prev_diff
from product p
join product_group pg
on p.group_id = pg.group_id
;

-- rental 테이블을 이용하여 연, 연월, 연월일, 전체 각각의 기준으로
-- rental_id 기준 렌탈이 일어난 횟수를 출력하시오.
-- y	m	d	count
select
	to_char(r.rental_date,'yyyy') as year,
	to_char(r.rental_date,'mm') as month,
	to_char(r.rental_date,'dd') as day,
	count(*)
from rental r
group by 1,2,3
order by 1,2,3
;

select
	to_char(r.rental_date,'yyyy') as y,
	to_char(r.rental_date,'mm') as m,
	to_char(r.rental_date,'dd') as d,
	count(*)
from rental r
group by rollup (y,m,d)
order by y,m,d
;

-- rental과 customer 테이블을 이용하여 현재까지 가장 많이 rental을 한 고객의
-- 고객 아이디, 렌탈순위, 누적렌탈횟수, 이름을 출력하시오.
-- row_number()
select 
	c.customer_id,
	row_number() over (order by count(r.rental_id) desc) as rank,
	count(r.rental_id),
	c.first_name||' '||c.last_name as name
from customer c
join rental r
on c.customer_id = r.customer_id
group by c.customer_id
order by 2
limit 1
;

-- 서브쿼리 이용(인라인뷰)
select a.*,	c.first_name||' '||c.last_name as name
from customer c,
	(
	select 	r.customer_id,
	row_number() over (order by count(r.rental_id) desc) as rank,
	count(r.rental_id)
	from rental r
	group by r.customer_id
	order by 2
	limit 1
	) a
where a.customer_id = c.customer_id
;

