-- Film 테이블에서 길이가 가장 긴 File_Id를 추출하시오

select max(f.length)
from film f
;

select f.film_id, f.title, f.description, f.release_year, f.length
from film f
where f.length = 185
order by f.title
;

select f.film_id, f.title, f.description, f.release_year, f.length
from film f
where f.length =
(select max(f.length)
from film f)
order by f.title
;

select f.film_id, f.title, f.description, f.release_year, f.length
from film f
where f.length >=
(select round(avg(f.length),2) as avg
from film f)
order by f.title
;
/** 서브쿼리
 * - SQL문 내에서 메인 쿼리가 아닌 하위에 존재하는 쿼리를 말함
 * - 서브쿼리를 활용함으로써 다양한 결과를 도출 가능
 */

-- rental_rate 평균
select avg(rental_rate)
from film f
;

-- 
select
	film_id,
	title,
	rental_rate
from film
where rental_rate >2.98
;

-- 중첩서브쿼리
select
	film_id,
	title,
	rental_rate
from film
where rental_rate >
(	-- 중첩서브쿼리 시작
	select
		avg(rental_rate)
	from film
);	-- 중첩서브쿼리 종료
;

-- 인라인 뷰의 활용
-- rental_rate가 평균보다 큰 집합의 영화정보를 추출하시오
select
	a.film_id,
	a.title,
	a.rental_rate
from film a,
	(
	select	--인라인 뷰 시작
		avg(rental_rate) as avg_rental_rate
	from film 
	) b
where a.rental_rate > b.avg_rental_rate	-- 인라인 뷰 종료
;

-- 스칼라 서브쿼리 활용
select
	a.film_id,
	a.title,
	a.rental_rate
from
(	-- 인라인뷰 시작
	select
		a.film_id,
		a.title,
		a.rental_rate,
		(	-- 스칼라 시작
			select avg(b.rental_rate)
			from film b
		) as avg_rental_rate	-- 스칼라 종료
	from film a
) a -- 인라인뷰 종료
where a.rental_rate > a.avg_rental_rate	
;


-- 영화분류별 상영시간이 가장 긴 영화의 제목 및 상영시간을 추출하시오
select c.category_id, max(length)
from film f,
	film_category c
where f.film_id = c.film_id
group by c.category_id
order by 1
;

select film_id,title, length
from film
where length >= any
(
	select max(length)
	from film a,
		 film_category b
	where a.film_id = b.film_id
	group by b.category_id
)
;

-- 영화분류별 상영시간이 가장 긴 영화의 상영시간과 동일한 시간을 갖는 영화의 제목 및 상영시간을 추출하시오.
-- 영화분류별 상영시간이 가장 긴 상영시간을 구하시오.
select film_id,title, length
from film
where length = any
(
	select max(length)
	from film a,
		 film_category b
	where a.film_id = b.film_id
	group by b.category_id
)
;
-- '=any'는 'in'과 동일함
select film_id,title, length
from film
where length in
(
	select max(length)
	from film a,
		 film_category b
	where a.film_id = b.film_id
	group by b.category_id
)
;

-- all, 영화분류별 상영시간이 가장 긴 영화의 모든 상영시간보다 크거나 같아야 조건 성립함.
-- 영화분류별 상영시간이 가장 긴 상영시간을 구함
select film_id,title, length
from film
where length >= all
(
	select max(length)
	from film a,
		 film_category b
	where a.film_id = b.film_id
	group by b.category_id
)
;

------------------------------
select max(length)
from film a,
	film_category b
where a.film_id = b.film_id
group by b.category_id
;

select film_id,title, length
from film
where length >= any
(
	select max(length)
	from film a,
	film_category b
	where a.film_id = b.film_id
	group by b.category_id
)
;

select film_id,title, length
from film
where length >= all
(
	select max(length)
	from film a,
	film_category b
	where a.film_id = b.film_id
	group by b.category_id
)
;

-- 등급시간 평균값들보다 상영시간이 긴 영화정보를 추출하시오
select round(avg(length),2)
from film a
group by rating
;

select
	film_id,
	title,
	length
from film
where length >= all
	(
		select round(avg(length),2)
		from film
		group by rating
	)
order by length
;

-- exists
-- 고객 중에서 지불내역이 있는 고객을 추출하시오

select
	c.first_name,
	c.last_name,
	c.customer_id
from customer c
where exists (
	select 1
	from payment p
	where p.customer_id = c.customer_id
	and p.amount > 11
				)
order by first_name,last_name
;

-- 고객 중에서 11달러 초과한 적이 없는 지불내역이 있는 고객을 추출하시오.
select
	c.first_name,
	c.last_name,
	c.customer_id
from customer c
where not exists (
	select 1
	from payment p
	where p.customer_id = c.customer_id
	and p.amount > 11
				)
order by first_name,last_name
;

-- 재고가 없는 영화를 추출하시오 (except)

select film_id, title
from film f
;
--except
select distinct i.film_id, f.title
from inventory i
join film f
on f.film_id = i.film_id
order by f.title
;

select film_id, title
from film f
except
select distinct i.film_id, f.title
from inventory i
join film f
on f.film_id = i.film_id
order by title
;

select f.film_id, f.title
from film f
where not exists
(
	select 1
	from inventory i
	where f.film_id=i.film_id
)
order by f.title
;