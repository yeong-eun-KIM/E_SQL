drop table if exists TB_ORD;
create table TB_ORD
(
	ORD_NO CHAR(6) primary key,
	ORD_DE CHAR(8),
	PRDT_NM VARCHAR(50),
	BRAND_NM VARCHAR(50),
	ORD_AMOUNT NUMERIC(15,0),
	ORD_CNT INT
);

insert into tb_ord values ('100001','20221001','갤럭시 S22 Ultra','삼성',400000,1);
insert into tb_ord values ('100002','20221002','갤럭시 S22 Ultra','삼성',600000,2);
insert into tb_ord values ('100003','20221003','갤럭시 S23 Ultra','삼성',800000,4);
insert into tb_ord values ('100004','20221004','갤럭시 S23 Ultra','삼성',1000000,8);

insert into tb_ord values ('100005','20221005','iPhone 14 pro','애플',500000,1);
insert into tb_ord values ('100006','20221006','iPhone 14 pro','애플',700000,2);
insert into tb_ord values ('100007','20221007','iPhone 15 pro','애플',900000,4);
insert into tb_ord values ('100008','20221008','iPhone 15 pro','애플',1100000,8);

select * from tb_ord;

-- Group By : PRDT_NM, BRAND_NM
select a.prdt_nm, a.brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm, a.brand_nm
order by a.prdt_nm, a.brand_nm
;

-- 위와 동일, bran_nm은 null로 대체함
select a.prdt_nm, null as brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm
order by a.prdt_nm
;

-- 위와 동일, prdt_nm은 null로 대체함
select null as prdt_nm, a.brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm, a.brand_nm
order by a.prdt_nm, a.brand_nm
;

-- GROUP BY : 전체 집계
select null as prdt_nm,null as brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm, a.brand_nm
order by a.prdt_nm, a.brand_nm
;

-- gropu by + union all 사용
-- prdt_nm,brand_nm 합계 + prdt_nm 합계 + brand_nm 합계 +  테이블 전체 합계
select a.prdt_nm, a.brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm, a.brand_nm
union all
select a.prdt_nm, null as brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm
union all
select null as prdt_nm, a.brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm, a.brand_nm
union all
select null as prdt_nm,null as brand_nm, sum(a.ord_amount) sum_amt, sum(a.ord_cnt) sum_cnt
from tb_ord a
group by a.prdt_nm, a.brand_nm
order by prdt_nm, brand_nm
;

-- grouping set()
select
	a.prdt_nm,
	a.brand_nm,
	sum(ord_amount) as sum_amnt,
	sum(ord_cnt) as sum_cnt
from tb_ord a
group by
grouping sets(
	(a.prdt_nm,a.brand_nm),
	(a.prdt_nm),
	(a.brand_nm),
	()
	)
order by 1,2
;

-- cube
-- cube 	(a.prdt_nm,a.brand_nm),
--			(a.prdt_nm),
--			(a.brand_nm),
--			()
-- 총 4개의 그룹화 결과가 출력됨
-- 인자가 두개 => 2^2= 4
select
	a.prdt_nm,
	a.brand_nm,
	sum(ord_amount) as sum_amnt,
	sum(ord_cnt) as sum_cnt
from tb_ord a
group by cube (a.prdt_nm,a.brand_nm)
order by 1,2
;

-- rollup
-- prdt_nm, brand_nm 별 집계 출력
-- prdt_nm 별 집혜 출력
-- 전체 집계 출력
-- brand_nm 별로는 집계 하지 않음 => prdt_nm을 기준으로 계층형 그룹화 집합을 리턴함

select
	a.prdt_nm,
	a.brand_nm,
	sum(ord_amount) as sum_amnt,
	sum(ord_cnt) as sum_cnt
from tb_ord a
group by rollup (a.prdt_nm,a.brand_nm)
order by 1,2
;