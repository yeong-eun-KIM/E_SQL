drop table if exists TB_FILM_GRADE;
create table TB_FILM_GRADE
(
	FILM_GRADE_NO INT primary key,
	TITLE_NM VARCHAR not null,
	RELEASE_YEAR smallint,
	GRADE_RANK INT
);

insert into tb_film_grade values (1,'늑대사냥',2022,1);
insert into tb_film_grade values (2,'공조2: 인터내셔날',2022,2);
insert into tb_film_grade values (3,'아바타 리마스터링',2022,3);

select * from tb_film_grade;

drop table if exists TB_FILM_ATTENDANCE;
create table TB_FILM_ATTENDANCE
(
	FILM_GRADE_NO INT not null,
	TITLE_NM VARCHAR not null,
	release_YEAR smallint,
	ATTENDANCE_RANK INT
);

insert into TB_FILM_ATTENDANCE values (1,'아바타 리마스터링',2022,1);
insert into TB_FILM_ATTENDANCE values (2,'헌트',2022,2);
insert into TB_FILM_ATTENDANCE values (3,'늑대사냥',2022,3);

commit;

select * from TB_FILM_ATTENDANCE;

select A.TITLE_NM, A.RELEASE_YEAR
from TB_FILM_GRADE A;

select B.TITLE_NM, B.release_YEAR
from tb_film_attendance B;

-- 중복된 행을 하나씩만 보여주고 있음
-- 중복된 행의 중복을 제거하고 유일한 값만 보여줌
select A.TITLE_NM, A.RELEASE_YEAR from tb_film_grade A
union
select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
;

-- 중복된 행도 모두 보여줌
select A.TITLE_NM, A.RELEASE_YEAR from tb_film_grade A
union ALL
select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
;

select A.TITLE_NM as "타이틀명", A.RELEASE_YEAR as "출시년도" from tb_film_grade A
union ALL
select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
order by "타이틀명"
;


-- INTERSECT --
drop table if exists TB_FILM_GRADE;
create table TB_FILM_GRADE
(
	FILM_GRADE_NO INT primary key,
	TITLE_NM VARCHAR not null,
	RELEASE_YEAR smallint,
	GRADE_RANK INT
);

insert into tb_film_grade values (1,'늑대사냥',2022,1);
insert into tb_film_grade values (2,'공조2: 인터내셔날',2022,2);
insert into tb_film_grade values (3,'아바타 리마스터링',2022,3);

select * from tb_film_grade;

drop table if exists TB_FILM_ATTENDANCE;
create table TB_FILM_ATTENDANCE
(
	FILM_GRADE_NO INT not null,
	TITLE_NM VARCHAR not null,
	release_YEAR smallint,
	ATTENDANCE_RANK INT
);

insert into TB_FILM_ATTENDANCE values (1,'아바타 리마스터링',2022,1);
insert into TB_FILM_ATTENDANCE values (2,'헌트',2022,2);
insert into TB_FILM_ATTENDANCE values (3,'늑대사냥',2022,3);

commit;

select A.TITLE_NM as "타이틀명", A.RELEASE_YEAR as "출시년도" from tb_film_grade A
INTERSECT
select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
order by "타이틀명" desc
;

-- INNER JOIN 사용 위와 같은 결과 도출 --
select a.title_nm "타이틀명",
	   a.release_year "출시년도"
from tb_film_grade a
join tb_film_attendance b
on a.title_nm = b.title_nm
and a.release_year = b.release_year
order by 타이틀명 desc
;


-- EXCEPT --
drop table if exists TB_FILM_GRADE;
create table TB_FILM_GRADE
(
	FILM_GRADE_NO INT primary key,
	TITLE_NM VARCHAR not null,
	RELEASE_YEAR smallint,
	GRADE_RANK INT
);

insert into tb_film_grade values (1,'늑대사냥',2022,1);
insert into tb_film_grade values (2,'공조2: 인터내셔날',2022,2);
insert into tb_film_grade values (3,'아바타 리마스터링',2022,3);

select * from tb_film_grade;

drop table if exists TB_FILM_ATTENDANCE;
create table TB_FILM_ATTENDANCE
(
	FILM_GRADE_NO INT not null,
	TITLE_NM VARCHAR not null,
	release_YEAR smallint,
	ATTENDANCE_RANK INT
);

insert into TB_FILM_ATTENDANCE values (1,'아바타 리마스터링',2022,1);
insert into TB_FILM_ATTENDANCE values (2,'헌트',2022,2);
insert into TB_FILM_ATTENDANCE values (3,'늑대사냥',2022,3);

commit;

select A.TITLE_NM, A.RELEASE_YEAR from tb_film_grade A
EXCEPT
select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
;

select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
EXCEPT
select A.TITLE_NM, A.RELEASE_YEAR from tb_film_grade A
;

select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
union all
select A.TITLE_NM, A.RELEASE_YEAR from TB_FILM_ATTENDANCE A
except
select A.TITLE_NM, A.RELEASE_YEAR from tb_film_grade A
;

-- count()
-- payment 테이블의 건수를 조회하시오
select count(*)
from payment p
;

select count(*) as cnt from customer c;

drop table if exists tb_count_cust;
create table TB_COUNT_CUST
(
	COUNT_TEST_NO INT primary key,
	COUNT_TEST_NM VARCHAR(50) not NULL
);

commit;

select COUNT(*)
from tb_count_CUST
;

-- payment 테이블에서 customer_id 별 건수를 구하시ㅗㅇ.
select p.customer_id, count(p.customer_id) as cnt
from payment p
group by 1
;

select p.customer_id, count(p.customer_id) as cnt
from payment p
group by 1
order by 2 desc
limit 1
;

select p.customer_id ID, c.first_name||' '||c.last_name as name , count(p.customer_id) as cnt
from payment p
join customer c
on p.customer_id = c.customer_id
group by 1,2
order by 3 desc
limit 1
;

select p.customer_id ID, c.first_name||' '||c.last_name as name , count(p.customer_id) as cnt
from payment p, customer c
where p.customer_id = c.customer_id
group by 1,2
order by 3 desc
limit 1
;

-- amount 값 중 유일한 값만을 출력하시오
select distinct amount
from payment p
order by amount
;

select count(distinct amount) as count
from payment p
;

-- payment 테이블에서 customer_id 별 amount 컬럼의 유일값 개수를 리턴하시오
select p.customer_id,count(distinct amount) as count_amt
from payment p,customer c
where p.customer_id=c.customer_id
group by 1
;

-- amount 컬럼의 유일값의 개수가 11이상인 행들을 출력하시오.
select p.customer_id, count(distinct p.amount) as cnt_amt
from payment p
group by 1
having count(distinct p.amount) >=11
order by cnt_amt
;

-- max(), min()
-- payment 테이블에서 최대 amount 값과 최소 amount 값을 구하시오
select max(p.amount), min(p.amount)
from payment p
;

select p.customer_id, max(p.amount), min(p.amount)
from payment p
group by 1
order by 1
;

select p.customer_id, max(p.amount), min(p.amount)
from payment p
group by 1
having max(p.amount)>11.00
order by 1
;

drop table if exists tb_max_min_test;
create table tb_max_min_test
(
	MAX_MIN_TEST_NO CHAR(6) primary key,
	MAX_AMOUNT numeric(15,2),
	MIN_AMOUNT numeric(15,2)
);

commit;

insert into tb_max_min_test values ('100001',100.52,11.49);

select max_min_test_no
from tb_max_min_test
where max_min_test_no = '100111'
;
select max(tmmt.max_min_test_no) as max_no
from tb_max_min_test tmmt
where max_min_test_no = '100111'
;

select coalesce(max(max_min_test_no),'없음') as max_min_test_no
from tb_max_min_test
where max_min_test_no = '100111'
;

-- avg(), sum()
select round(avg(amount),2) avg, round(sum(amount),2) sum
from payment p
;

-- payment 테이블에서 customer_id 별 amount의 avg,sum을 구하고 sum을 기준으로 내림차순 정렬하시오.
select p.customer_id, avg(amount), sum(amount)
from payment p
group by 1
order by 3 desc
;

-- amount의 평균값이 5.00 이상인 결과집합을 출력하시오
select p.customer_id,round(avg(amount),2), round(sum(amount),2)
from payment p
group by 1
having round(avg(p.amount),2) >=5.00
order by sum(amount) desc
;

select p.customer_id,c.first_name,c.last_name,round(avg(amount),2), round(sum(amount),2)
from payment p, customer c
where p.customer_id = c.customer_id
group by 1,2,3
having round(avg(p.amount),2) >=5.00
order by sum(amount) desc
;


drop table if exists tb_avg_sum_test;
create table tb_avg_sum_test
(
	AVG_SUM_TEST_NO CHAR(6) primary key,
	AVG_AMOUNT numeric(15,2),
	SUM_AMOUNT NUMERIC(15,2)
);

commit;


insert into tb_avg_sum_test values ('100001',100.00,10.00);
insert into tb_avg_sum_test values ('100002',100.00,20.00);
insert into tb_avg_sum_test values ('100003',100.00,30.00);
insert into tb_avg_sum_test values ('100004',NULL,40.00);
insert into tb_avg_sum_test values ('100005',200.00,NULL);
insert into tb_avg_sum_test values ('100006',NULL,NULL);
commit;

-- AVG 계산시 6이 아닌 4로 나눔 = NULL을 포함 안함 , SUM도 동일
select round(AVG(avg_amount),2) as AVG_AMOUNT, ROUND(SUM(sum_amount),2) as SUM_AMOUNT
from tb_avg_sum_test tast
;

-- 그냥 연산시에는 NULL이 나옴
select avg_amount+sum_amount
from tb_avg_sum_test tast;

-- 숫자를 문자열로 바꾸기
select DT, CAST(DT as VARCHAR) as YYYYMMDD
from online_order oo
;
-- 문자열 컬럼에서 일부만 잘라내기
select DT, LEFT(CAST(DT as VARCHAR),4)
from online_order oo
;

select DT, substring(CAST(DT as VARCHAR),5,2) as MONTH
from online_order oo
;

select DT, right(CAST(DT as VARCHAR),2)
from online_order oo
;

-- YYYY-MM-DD 형식으로 이어서 출력해보시오
select DT, CONCAT(LEFT(CAST(DT as VARCHAR),4),'-',SUBSTRING(CAST(DT as VARCHAR),5,2),'-',right(CAST(DT as VARCHAR),2)) as "YYYY-MM-DD"
from online_order oo
;

select DT, LEFT(CAST(DT as VARCHAR),4)||'-'||SUBSTRING(CAST(DT as VARCHAR),5,2)||'-'||right(CAST(DT as VARCHAR),2) as "YYYY-MM-DD"
from online_order oo
;

-- NULL 값인 경우 임의값으로 바꿔주기
select coalesce(ui.gender,'NA') as GENDER,
		coalesce(ui.age_band,'NA') as age_and,
		sum(oo.gmv)
from online_order oo
left join user_info ui
on oo.userid = ui.userid
group by 1,2
order by 1,2
;

-- 내가 원하는 값으로 컬럼추가해보기
select distinct case when gender = 'M' then '남성'
					when GENDER = 'F' then '여성'
					else 'NA'
					end as "GENDER"
from user_info ui
;

select distinct case 
	when age_band = '20~24' OR age_band = '25~29' then '20대'
	when age_band = '30~34' OR age_band = '35~39' then '30대'
	when age_band = '40~44' then '40대'
	end as 연령대,
	sum(oo.gmv)
from user_info ui, online_order oo
where ui.userid = oo.userid
group by 1
order by 1
;