-- NULLIF 함수
select
	nullif(1,1)	as 첫번째 -- 1,1이 같으니 null이 리턴됨
,	nullif(1,0) as 두번째	-- 1,0은 다르니 첫번째 인자인 1이 리턴됨
,	nullif('A','A') as 세번쩨	-- 'A','A'는 같으니 null이 리턴됨
,	nullif('A','B') as 네번째	-- 'A','B'는 다르니 첫번째 인자인 'A'가 리턴됨
;

-- COALESCE 함수
select
	coalesce (null,1)	as 첫번째 -- 첫번째 인자가 NULL이라서 NULL이 아닌 두번째 인자인 1을 리턴함
,	coalesce (1,0)	as 두번째	-- 첫번째 인자가 NULL이 아니기 때문에 첫번째 인자인 1을 리턴함
, 	coalesce ('A','B') as 세번째	-- 첫번째 인자가 NULL이 아니라 첫번째 인자인 'A'를 리턴함
,	coalesce (null,'B') as 네번째	-- 첫번째 인자가 NULL이라서 NULL이 아닌 두번째 인자인 'B'를 리턴함
;

-- CAST 함수
-- 문자열 '100'을 INTEGER형으로 변환
select
	cast ('100' as INTEGER) as CAST_AS_INTEGER
;

-- 오류
-- 문자열 '10C'는 INTGER형이 될 수 없으므로 변환 실패
select
	cast ('10C' as integer) as CAST_AS_INTEGER
;

-- 문자형을 날짜형으로 변환
select
	cast('2023-01-01' as date)	as 첫번째
,	cast('01-OCT-2023' as date) as 두번째
;

-- 오류
-- 유효한 일자가 아니므로 변환 실패
select
	cast('2022-02-30' as date) as 첫번째
;

-- 문자열을 실수형으로 벼환함
select cast ('10.2' as double precision) as 소수점포함
;

-- 오류
select cast ('십쩜영이' as double precision) as 오류
;

-- 문자형을 INTERVAL 형으로 형변환
select
	CAST('15MINUTE' as INTERVAL) as 분
,	CAST('2hour' as INTERVAL) as 시
,	CAST('1 day' as INTERVAL) as 일
,	CAST('2 week' as INTERVAL) as 주
,	CAST('3 month' as INTERVAL) as 월
;

select now();
-- 문자열을 TIMESTAMP 형식으로 변환, 시간계산
select
	CAST('2022-09-26 10:44:18.256 +0900' as timestamp) - cast('2hour' as interval) as 두시간빼기
;

-- 문자열함수
select ascii('A') as ascii-- 문자 'A'의 아스키코드값 리턴
,	chr(65) as chr	-- 아스키코드 65의 문자를 리턴
,	concat('A','B','C') as concat 	-- 문자열 합침
-- 문자열을 구분자(|)로 구분하면서 합침
,	concat_ws('|','A','B','C') as concat_ws
-- 구분자가 있는 문자열에서 2번째 문자열을 리턴
,	split_part('A|B|C','|',2) as split_part
,	left('ABC',1)	as left
,	right('ABC',1) as right
,	LENGTH('ABC') as LENGTH
-- 소,대문자 바꾸기
,	lower('ABC') as LOWER
,	upper('acb') as upper
-- 빈문자열 채우기
,	lpad('123',6,'0') as lpad
,	rpad('123',6,'0')  as rpad
-- 공백제거
,	ltrim(' 123 ') as ltrim
,	rtrim(' 123 ') as rtrim
,	trim(' 123 ') as trim
--ABC 문자열에서 B를 찾아서 위치를 리턴함
,	position ('B' in 'ABC') as  position
-- 반복
,	repeat('*',10) as repeat
,	reverse('NEZE') as REVERSE
,	substring('ABC',2,2) as subtring
;

-- 날짜 관련 함수
-- AGE 함수 : 첫번째 인자값 - 두번째 인자값 = 세월의 차이
select
	age('2023-01-11','2022-09-26') as 수업종료까지
,	age(current_date,'2022-01-11') as current_date
,	age(current_timestamp,current_timestamp-cast('2hour' as interval))
;

-- rental 테이블에서 대여기간이 가장 길었던 렌탈내역을 조회하시오.
select A.rental_id
	   ,A.customer_id
	   ,AGE(A.return_date,A.rental_date) as duration
from rental A
where A.return_date is not null
order by duration desc
limit 10
;

--현재시간정보조회
select
	current_date as "current_Date" -- 현재일자 리턴
,	current_time as "current_time" -- 현재시간 리턴
,	current_timestamp -- 현재 일자와 시간 리턴
,	localtime(6) as "localtime"
,	localtimestamp
,	now() as "now()"
,	now() + interval '1day' as "now()+interval'1day'"
,	now() - interval '1day 2hours 30 minute'
;

-- 일자와 시간 추출 함수
SELECT
	cast(date_part('year',current_timestamp) AS varchar)
,	CAST(DATE_PART('month',current_timestamp) as varchar)
,	cast(date_part('week',current_timestamp) as varchar)
,	cast(date_part('day',current_timestamp) as varchar)
,	cast(date_part('hour',current_timestamp) as varchar)
,	cast(date_part('minute',current_timestamp) as varchar)
,	cast(date_part('second',current_timestamp) as varchar)
,	cast (extract(year from current_timestamp) as varchar)
,	cast (extract(month from current_timestamp) as varchar)
,	cast (extract(week from current_timestamp) as varchar)
,	cast (extract(day from current_timestamp) as varchar)
,	cast (extract(hour from current_timestamp) as varchar)
,	cast (extract(minute from current_timestamp) as varchar)
,	cast (extract(second from current_timestamp) as varchar)
,	date_trunc('hour',current_timestamp)
,	date_trunc('minute',current_timestamp)
,	date_trunc('second', current_timestamp)
;

-- 문자열을 일자 및 시간형으로 형변환하는 함수
select
	to_date('20221224','YYYYMMDD')
,	to_date('2022-12-24','YYYY-MM-DD')
,	TO_Date('2022/12/24','YYYY/MM/DD')
,	to_timestamp('20111224093920','YYYYMMDDHH24MISS')
,	to_timestamp('2012-12-24 09:39:20.000 +0900','YYYY-MM-DD HH24:MI:SS')
;

-- 반올림, 올림, 내림, 자름 관련 함수
select
	round(10.78,0) as "0의자리에서 반올림"
,	round(10.78,1) as "소수점 첫번째 자리에서 반올림"
,	round(10.781,2) as "소수점 두번째 자리에서 반올림"
;

select
	ceil(12.4) as "12.4 올림"
,	ceil(12.8) as "12.8 올림"
,	ceil(12.0) as "12.0 올림" --0의 자리에서 올림해도 그대로 12가 됨
;

select
	floor(12.4) as "12.4 내림"
,	floor(12.0) as "12.0 내림"
;

select
	TRUNC(10.78,0) as "10.78을 0의 자리에서 자름"
,	TRUNC(10.78,1) as "10.78을 1의 자리에서 자름"
;

-- 연산관련함수
select
	abs(-10) as "-10 절대값"
,	sign(-3) as "sin 함수"
,	sign(0) as "sin(0) return"
,	div(9,2) as "9/2의 몫"
,	mod(9,2) as "9/2의 나머지"
,	log(10,1000) as "log1000"
,	power(2,3) as "2^3"
,	sqrt(2) as "루트 2"
,	random()
,	pi()
,	degrees(1)
;




