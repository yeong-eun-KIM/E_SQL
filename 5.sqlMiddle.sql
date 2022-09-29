-- 카테고리별, 연도별 매출을 추출하시오.
select category, yyyy, sum(gmv) total_gmv
from gmv_trend gt
group by category, yyyy
;

select category, yyyy, sum(gmv) total_gmv
from gmv_trend gt
where = category = '컴퓨터 및 주변기기'
group by 1,2 -- select 인덱스 사용
;


select category, mm, sum(gmv) total_gmv
from gmv_trend gt
group by category, mm
order by category, mm
;

select category, mm, platform_type, sum(gmv) total_gmv
from gmv_trend gt
group by category, mm, platform_type
;

select sum(gmv) as gmv , min(yyyy), max(yyyy), avg(gmv)
from gmv_trend;


-- 매출이 높은 주요 카테고리만 추출하시오
select category, sum(gmv) as gmv
from gmv_trend
group by 1
having sum(gmv) >=50000000
;


-- 매출이 높은 주요카테고리 중에 2020년에 해당것을 추출하시오.
select category,sum(gmv) as gmv
from gmv_trend
where yyyy=2020
group by 1
having sum(gmv) >= 10000000
;


select *
from gmv_trend gt
order by category, yyyy, mm, platform_type
;

-- 매출이 높은 순으로 카테고리 정렬하시오.
select category, sum(gmv) as gmv
from gmv_trend gt
group by 1
order by gmv desc
;

select category, yyyy, sum(gmv) as gmv
from gmv_trend gt
group by 1,2
order by 1 desc, 3 desc
;

---------dvdrental--------------------

--고객 중 결제 내역이 있는 고객의 고객정보 및 결제내역을 출력하시오.
	--  
select 
	c.customer_id
,	c.first_name
,	c.last_name
,	p.amount
,	p.payment_date
from customer c
inner join payment p
on c.customer_id = p.customer_id
order by p.payment_date
;

select 
	c.customer_id
,	c.first_name
,	c.last_name
,	p.amount
,	p.payment_date
from customer c, payment p
where c.customer_id = p.customer_id
order by p.payment_date
;

-- 고객 중 customer_id가 2인 고객의 고객정보와 결제내역을 출력하시오.
select 
	c.customer_id
,	c.first_name
,	c.last_name
,	p.amount
,	p.payment_date
from customer c, payment p
where c.customer_id = p.customer_id
and c.customer_id=2
order by p.payment_date
;

-- 고객 중 customer_id가 2인 고객의 고객정보와 결제내역을 출력하시오.
-- 해당 결제를 수행한 스탭의 정보까지 출력하시오.
-- 스탭id, 스탭의 first_name, last_name 
select 
	c.customer_id
,	c.first_name
,	c.last_name
,	p.amount
,	p.payment_date
,	s.staff_id
,	s.first_name
,	s.last_name
from customer c
inner join payment p
on c.customer_id = p.customer_id
join staff s
on p.staff_id = s.staff_id
where c.customer_id = 2
order by p.payment_date
;

select 
	c.customer_id
,	c.first_name
,	c.last_name
,	p.amount
,	p.payment_date
,	s.staff_id
,	s.first_name
,	s.last_name
from customer c, payment p, staff s
where c.customer_id = p.customer_id
and c.customer_id=2
and p.staff_id = s.staff_id
order by p.payment_date
;

--0927 FILM 테이블, INVENTORY 테이블
-- 왼쪽 film은 다 나오고 오른쪽 inventory는 매칭되는 것만 나오게 되는 것임
select 
	   f.film_id
,	   f.title
,	   i.inventory_id
from film f
left outer join inventory i
on f.film_id = i.film_id
where i.inventory_id is not null
order by f.title
;

-- right outer JOIN
-- film 테이블의 내용은 모두 나옴, inventory 테이블의 내용은 매칭되는 것만 나옴
select 
	   f.film_id
,	   f.title
,	   i.inventory_id
from inventory i
right join film f
on i.inventory_id = f.film_id
order by f.title
;


