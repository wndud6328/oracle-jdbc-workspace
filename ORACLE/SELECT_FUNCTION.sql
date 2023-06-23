--1. 영어영문학과(학과코드 002) 학생들의 학번과 이름, 입학년도를 입학년도가 빠른 순으로 표시
--하는 SQL 문장을 작성하시오. (단, 헤더는 “학번”, “이름”, “입학년도” 가 표시되도록 한다
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

SELECT STUDENT_NO, STUDENT_NAME, ENTRANCE_DATE
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY  DEPARTMENT_NO;

--2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 한 명 있다고 한다. 그 교수의 이름과
--주민번호를 화면에 출력하는 SQL 문장을 작성해 보자
SELECT PROFESSOR_NAME, PROFESSOR_SSN, LPAD(SUBSTR(PROFESSOR_SSN, 1, 2),4,'19')
FROM TB_PROFESSOR
WHERE LENGTH(PROFESSOR_NAME) != 3;

-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 이때 나
--이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. (단, 교수 중 2000년 이후 
--출생자는 없으며 출력 헤더는 “교수이름”, “나이”로 한다.) -> 정확한 건 오른쪽!
SELECT PROFESSOR_NAME "교수이름", EXTRACT(YEAR FROM SYSDATE) - (LPAD(SUBSTR(PROFESSOR_SSN, 1, 2),4,'19'))+1 "나이"
FROM TB_PROFESSOR;


