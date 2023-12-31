-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명" , " 계열" 으로 표시

SELECT DEPARTMENT_NAME AS "학과 명", CATEGORY AS "계열"
FROM TB_DEPARTMENT;

-- 2. 학과의 학과 정원을 다음과 같은 형태로 출력
SELECT DEPARTMENT_NAME || '의 정원은 ' || CAPACITY || ' 명 입니다' AS "학과별정원"
FROM TB_DEPARTMENT;


-- 3. 국어국문학과에 다니는 여학생 중 휴학중인 학생 

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001 AND STUDENT_SSN LIKE '_______2%' And ABSENCE_YN = 'Y';

-- 4. 도서관 대출 도서 장기 연체자 찾기
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO IN ('A513079', 'A513090','A513091', 'A513110', 'A513119')
ORDER BY STUDENT_NO DESC;

--5.  입학 정원이 20 이상 30 이하인 학과들의 이름과 계열 출력
SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30 ;

-- 6. 총장의 이름을 알아낼 수 있는 SQL 작성
SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

--7. 학과가 지정되어있지 않은 학생
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

--8. 어떤 과목인지 과목번호 조회
SELECT CLASS_NO, CLASS_NAME
FROM TB_CLASS
WHERE CLASS_NO IN ('C0405500', 'C0409000', 'C3745400', 'C0432500', 'C3051900', 'C3221500');

--9. 대학에 어떤 계열이 있는지 조회
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT;

--10. 휴학생 제외, 02학번 전주 거주자 학생의 학번, 이름, 주민번호
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE ENTRANCE_DATE BETWEEN '02/01/01' AND '02/12/31' 
AND ABSENCE_YN LIKE '%N%' 
AND STUDENT_ADDRESS LIKE '%전주%';

