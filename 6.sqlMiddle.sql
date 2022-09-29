-- 주문 테이블
select *
from online_order oo
;

-- 상품 테이블
select *
from item i
; 

-- 카테고리 테이블
select *
from category c
;

-- 유저 테이블
select *
from user_info ui
;

-- 상품별 매출액 집계 후, 매출액 높은 순으로 정렬하기
select itemid, sum(gmv) "매출액"
from online_order oo
group by itemid
order by 2 desc
;

-- 상품이름을 상품 ID와 나란히 상품별 매출액을 출력하시오.
select 
	i.id
,	i.item_name
,	sum(oo.gmv) as "매출액"
from item i
join online_order oo
on i.id = oo.itemid
group by 1,2
order by 3 desc
;

-- 카테고리별 매출액을 출력하시오.
select
	c.cate1
,	sum(oo.gmv) "매출액"
from item i
join online_order oo
on i.category_id = oo.itemid
join category c
on c.id = oo.itemid
group by 1
order by 2 desc
;

-- 성별 매출액을 출력하시오.
select
	ui.gender
,	sum(oo.gmv) "매출액"
,	count(distinct ui.userid) as "유저수"
from user_info ui
join online_order oo
on ui.userid = oo.userid
group by 1
order by 2 desc
;

-- 연령별 매출액을 출력하시오.
select
	ui.age_band
,	sum(oo.gmv) "매출액"
,	count(ui.userid) "유저수"
from user_info ui
join online_order oo
on ui.userid = oo.userid
group by 1
order by 2 desc
;

-- 카테고리별 주요 상품의 매출액을 출력하시오.
-- 매출액(거래액) = unitsold*price
select
	c.cate3
,	c.cate2
,	c.cate1
,	i.item_name
,	sum(oo.gmv) "매출액"
,	sum(unitsold) "판매량"
,	sum(gmv)/sum(unitsold) "제품가격"
from online_order oo
join item i
on oo.itemid = i.id
join category c
on i.category_id = c.id
group by 1,2,3,4
order by 1, 5 desc
;


-- 남성이 구매하는 아이템을 출력하시오
select
	i.item_name 상품
,	c.cate1 카테고리
,	sum(gmv) "매출액"
from user_info ui
join online_order oo
on ui.userid = oo.userid
join item i
on oo.itemid = i.id
join category c
on i.category_id = c.id
where ui.gender='M'
group by 1,2
order by 3 desc
;

-- SELFJOIN
drop table if exists TB_EMP;
create table TB_EMP
(	EMP_NO INT primary key
,	EMP_NM VARCHAR(50) not null
,	DIRECT_MANAGE_EMP_NO INT
,	foreign key(DIRECT_MANAGE_EMP_NO) references TB_EMP(EMP_NO)
	on delete NO action
);

insert into tb_emp values (1,'김회장',null);
insert into tb_emp values (2,'박사장',1);
insert into tb_emp values (3,'송전무',2);
insert into tb_emp values (4,'이상무',2);
insert into tb_emp values (5,'정이사',2);
insert into tb_emp values (6,'최부장',3);
insert into tb_emp values (7,'정차장',4);
insert into tb_emp values (8,'김과장',5);
insert into tb_emp values (9,'오대리',8);
insert into tb_emp values (10,'신사원',8);

select *
from tb_emp;

-- 모든 직원을 출력하면서 직속 상사의 이름을 출력하시오
select
	A.emp_no
,	A.EMP_NM
,	B.EMP_NM as DIRECT_MANAGE_EMP_NO
from tb_emp A
left join tb_emp B
on (A.emp_no = B.DIRECT_MANAGE_EMP_NO)
;

--<dvdrental>--
-- 상영시간이 동일한 필름을 출력하시오.
select
	f1.title "영화1"
,	f2.title "영화2"
,	f1.length "상영시간"
from film f1
join film f2
on f1.length = f2.length
and f1.title != f2.title
;

drop table if exists TB_EMP;
drop table if exists TB_DEPT;
create table TB_DEPT
(
	DEPT_NO INT primary key
,	DEPT_NM VARCHAR(50)
);

-- 아직 어떠한 사원도 존재하지 않는 4차산업팀이 있습니다.
insert into TB_DEPT values (1,'회장실');
insert into TB_DEPT values (2,'경영지원본부');
insert into TB_DEPT values (3,'영업부');
insert into TB_DEPT values (4,'개발1팀');
insert into TB_DEPT values (5,'개발2팀');
insert into TB_DEPT values (6,'4차산업혁명팀');

select * from tb_dept;


-- 아직 부서배치를 받지 못한 사원이 있습니다.
create table TB_EMP
(	EMP_NO INT primary key
,	EMP_NM VARCHAR(50) not null
,	DEPT_NO INT
,	foreign key(DEPT_NO) references TB_DEPT(DEPT_NO)
	on delete NO action
);

insert into tb_emp values (1,'김회장',1);
insert into tb_emp values (2,'박사장',2);
insert into tb_emp values (3,'송전무',2);
insert into tb_emp values (4,'이상무',2);
insert into tb_emp values (5,'정이사',2);
insert into tb_emp values (6,'최부장',3);
insert into tb_emp values (7,'정차장',3);
insert into tb_emp values (8,'김과장',4);
insert into tb_emp values (9,'오대리',4);
insert into tb_emp values (10,'신사원',5);
insert into tb_emp values (11,'송인턴',null);

select * from tb_emp;

select te.emp_no
,	te.emp_nm
,	te.dept_no
,	de.dept_no
,	de.dept_nm
from tb_emp te
full outer join TB_DEPT de
on te.dept_no = de.dept_no
;

-- 오른쪽에만 존재하는 행 => 직원이 없는 6번 부서도 출력
select te.emp_no
,	te.emp_nm
,	te.dept_no
,	de.dept_no
,	de.dept_nm
from tb_emp te
full outer join TB_DEPT de
on te.dept_no = de.dept_no
where te.emp_nm is null
;

-- 부서 없는 직원도 출력
select te.emp_no
,	te.emp_nm
,	te.dept_no
,	de.dept_no
,	de.dept_nm
from tb_emp te
full outer join TB_DEPT de
on te.dept_no = de.dept_no
where de.dept_nm is null
;

drop table if exists T1;
create table T1
(
	COL_1 CHAR(1) primary KEY
);

drop table if exists T2;
create table T2
(
	COL_2 int primary KEY
);

insert into t1 (col_1) values ('A');
insert into t1 (col_1) values ('B');
insert into t1 (col_1) values ('C');
insert into t2 (col_2) values ('1');
insert into t2 (col_2) values ('2');
insert into t2 (col_2) values ('3');

select * from t1;
select * from t2;

select *
from t1
cross join t2
order by t1.col_1, t2.col_2
;