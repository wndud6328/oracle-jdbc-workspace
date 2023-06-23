함수 : 전달된 컬럼값을 읽어들여서 함수를 실행한 결과를 반환
​
단일행 함수 n개의 값을 읽어서 n개의 결과값을 리턴
매행마다 함수 실행 결과 반환
​
그룹 함수 : n개의 값을 읽어서 1개의 결과값을 리턴
​
select절에 단일행 함수와 그룹 함수는 함께 사용하지 못함
왜? 결과 행의 갯수가 다르기 때문에!
​
함수식을 기술할 수 있는 위치, select, where, order by, group by, having
​
--- 단일행 함수 --------------------------------------
/*
문자 처리 함수
​
LENGTH /LENGTHB
LENGTH(컬럼|'문자열값') : 해당 값의 글자 수 반환
LENGTHB(컬럼|'문자열값') : 해당 값의 바이트 수 반환
​
한글 한 글자 -> 3BYTE
영문자, 숫자, 특수문자 한 글자 -> 1BYTE
​
*/
SELECT LENGTH('오라클'), LENGTHB('오라클'), LENGTH('oracle'), lengthb('oracle')
from dual;
​
-- dual 가상 테이블
​
-- 사원명, 사원명의 글자 수, 사원명의 바이트 수
select emp_name, length(emp_name), lengthb(emp_name) from employee;
--이메일, 이메일의 글자 수, 이메일의 바이트 수 조회
select email, length(email), lengthb(email) from employee;
​
/*
INSTR
INSTR(STRING, STR [, POSITION, OCCURRENCE])
지정한 위치부터 지정된 숫자 번째로 나타나는 문자의 시작 위치를 반환
​
설명
STRING : 문자 타입 컬럼 또는 문자열
STR : 찾으려는 문자열
POSITION : 찾을 위치의 시작 값(기본값 1)
1: 앞에서부터 찾는다.
-1: 뒤에서부터 찾는다.
OCCURRENCE : 찾을 문자값이 반복될 때 지정하는 빈도(기본값 1), 음수 사용 불가
*/
​
select instr('aabaacaabbaa', 'b') from dual;
select instr('aabaacaabbaa', 'b', -1) from dual;
select instr('aabaacaabbaa', 'b', -1, 2) from dual;
​
-- 's'가 포함되어 있는 이메일 중 이메일, 이메일의 @위치, 이메일에서 뒤에서 2번째에 있는 's'위치 조회
​
select EMAIL, instr(EMAIL, 's', -1, 2), INSTR(EMAIL, '@') from employee where email like '%s%';
​
/*
LPAD/RPAD
​
문자열을 조회할 때 통일감있게 조회하고자 할 때 사용
LPAD/RPAD(STIRNG, 최종적으로 반환할 문자의 길이, [덧붙이고자하는 문자])
문자열에 덧붙이고자하는 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
*/
​
select lpad('hello', 10) from dual; -- 덧붙이고자하는 문자 생략시 공백으로 채운다.
select lpad('hello', 10, 'a') from dual;
select rpad('hello', 10) from dual;
select rpad('hello', 10, '*') from dual;
​
/*
LTRIM/RTRIM
​
문자열에서 특정 문자를 제거한 나머지를 반환
LTRIM/RTRIM(STRING, [제거하고자하는문자들])
문자열의 왼쪽 또는 오른쪽에서 제거하고자하는 문자들을 찾아서 제거한 나머지 문자열을 반환
*/
​
-- 제거하고자 하는 문자 생략 시 기본값으로 공백을 제거
select ltrim('       k              h') from dual;
select ltrim('acabacckh', 'abc') from dual;
select rtrim('5782kh123', '0123456789') from dual;
​
/*
TRIM
​
문자열의 양쪽(앞/뒤/)에 있는 지정한 문자들을 제거한 나머지 문자열 반환
TRIM([LEADING|TRAILING|BOTH] 제거하고자하는문자들 FROM STRING)
*/
​
select trim('       kh              ') from dual;
select trim('z' from 'zzzkhzzz') from dual;
select trim(leading 'z' from 'zzzkhzzz') from dual; --ltrim
select trim(trailing 'z' from 'zzzkhzzz') from dual; --rtrim
select trim(both 'z' from 'zzzkhzzz') from dual;
​
/*
SUBSTR
문자열에서 특정 문자열을 추출해서 반환
SUBSTR(STRING, POSITION, [LENGTH])
STRING:문자타입컬럼 또는 '문자열값'
POSITION:문자열을 추출할 시작위치값(음수값도 가능)
LENGTH:추출할 문자 개수(생략시 끝까지)
*/
​
select substr('programimng', 5, 2) from dual;
select substr('programimng', -8, 3) from dual;
​
-- 여자사원들의 이름만 조회
select emp_name from employee where substr(emp_no, 8, 1) = 2; 
-- 남자사원들의 이름만 조회
select emp_name from employee where substr(emp_no, 8, 1) = 1; 
-- 사원명과 주민등록번호(991212-1******)
select emp_name, rpad(substr(emp_no, 1, 8), 14, '*') from employee;
-- 직원명, 이메일, 아이디(이메일에서 '@' 앞의 문자) 조회
select emp_name, email, substr(email, 1, instr(email,'@')-1) "아이디" from employee;
​
​
/*
LOWER/UPPER/INITCAP
​
LOWER/UPPER/INITCAP(STINR)
LOWER : 다 소문자로 변경한 문자열 반환
UPPER : 다 대문자로 변경한 문자열 반환
INITCAP : 단어 앞글자마다 대문자로 변경한 문자열 반환
*/
​
select lower('Welcome To My World') from dual;
select upper('Welcome To My World') from dual;
select initcap('welcome to my world') from dual;
​
/* 
CONCAT
문자열 두개 전달받아 하나로 합친 후 결과 반환
CONCAT(STINRG, STRING)
*/
​
select concat('가나다라', 'abcd') from dual;
select '가나다라'||'abcd' from dual; --연결 연산자와 동일;
​
select '가나다라'||'abcd'||'1234' from dual;
select concat(concat('가나다라', 'abcd'), '1234') from dual;
​
/*
replace
​
select * from employee;
*/

/*
    REPLACE
    - REPLACE(STRING, STR1, STR2 )
       STRING : 컬럼 또는 문자열 값
       STR1 : 변걍시킬 문자열
       STR2 : STR1을 변경할 문자열
*/
SELECT REPLACE('서울시 강남구 역삼동' , '역삼동' , '삼성동) from DUAL







