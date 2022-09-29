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