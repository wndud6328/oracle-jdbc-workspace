/*
   뷰(VIEW)
   - SELECT문을 저장할 수 있는 객체
   - 가상 테이블 (실제 데이터가 담겨있는 건 아님!! => 논리적인 테이블)
   - DML(INSERT, UPDATE, DELETE) 작업이 가능 (단, 일부만!)
   
   * 사용 목적
   - 편리성 : SELECT문의 복잡도 완화
   - 보안성 : 테이블의 특정 열을 노출하고 싶지 않은 경우
*/
-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE)
WHERE NATIONAL_NAME = '일본';

/*
   1. VIEW 생성 방법
   
   [표현식]
   CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰명
   AS 서브쿼리
   [WITH CHECK OPTION]
   [WITH READ ONLY];
   
   * VIEW 옵션들
   - OR REPLACE : 뷰 생성시 기존에 중복된 이름의 뷰가 없다면 새로이 뷰를 생성하고 
                        기존에 중복된 이름의 뷰가 있다면 해당 뷰를 변경(갱신)하는 옵션
   - FORCE : 서브 쿼리에 기술된 테이블이 존재하지 않는 테이블이어도 뷰가 생성된다.
   - NOFORCE : 서브 쿼리에 기술된 테이블이 존재해야만 뷰가 생성된다. (기본값)
   - WITH CHECK OPTION : 서브 쿼리에 기술된 조건에 부합하지 않는 값으로 수정하는 경우 오류를 발생시킨다.
   - WITH READ ONLY : 뷰에 대해 조회만 가능하다. (DML 수행 불가)
*/
-- 관리자 계정으로 CREATE VIEW 권한을 부여
GRANT CREATE VIEW TO KH; -- 관리자 계정 SYS에서만 만들 수 있음

CREATE OR REPLACE VIEW VW_EMPLOYEE
AS SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
JOIN NATIONAL USING (NATIONAL_CODE);

-- 가상의 테이블로 실제 데이터가 담겨있는 것은 아님!
SELECT * FROM VW_EMPLOYEE;

-- 참고 : 접속한 계정이 가지고 있는 VIEW에 대한 정보를 조회하는 뷰 테이블
SELECT * FROM USER_VIEWS;

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여 ,근무국가명 조회
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- '일본'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명 조회
SELECT *
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '일본';

/*
   뷰 컬럼에 별칭 부여
   - 서브쿼리의 SELECT절에 함수식이나 산술연산식이 기술되어 있을 경우 반드시 별칭 지정
*/

-- 사원의 사번, 사원명, 직급명, 성별(남/여), 근무년수를 조회
-- 할 수 있는 SELECT문을 뷰(VW_EMP_JOB)로 정의
CREATE OR REPLACE VIEW VW_EMP_JOB
AS SELECT EMP_ID, EMP_NAME , JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') "성별(남/여)",
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
FROM EMPLOYEE
NATURAL JOIN JOB;

SELECT * FROM VW_EMP_JOB;

-- 뷰 삭제
DROP VIEW VW_EMP_JOB;

-- 2) 뷰 생성 시 모든 컬럼에 별칭을 부여하는 방법/ 대신 모든 컬럼에 별칭을 부여해야함
CREATE OR REPLACE VIEW VW_EMP_JOB("사번", "사원명", "직급명", "성별", "근무년수")
AS SELECT EMP_ID, EMP_NAME , JOB_NAME, DECODE(SUBSTR(EMP_NO, 8, 1), 1, '남', 2, '여') ,
          EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 
FROM EMPLOYEE
NATURAL JOIN JOB;

-- 성별이 남자인 사원의 사원명과 직급명 조회
SELECT 사원명, 직급명
FROM VW_EMP_JOB
WHERE 성별 = '남';

-- 근무년수가 20년 이상인 사원 조회
SELECT 사원명
FROM VW_EMP_JOB
WHERE 근무년수 >= 20;

/*
   VIEW를 이용해서 DML(INSERT, UPDATE, DELETE) 사용 가능
   - 뷰를 통해서 조작하게 되면 실제 데이터가 담겨있는 베이스테이블에 반영됨
*/
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE, JOB_NAME
    FROM JOB;
    
SELECT * FROM VW_JOB; -- 논리적인 테이블 (실제데이터가 담겨있지 않음)
SELECT * FROM JOB; -- 베이스 테이블 (실제데이터가 담겨있음)

-- 뷰를 통해서 INSERT
INSERT INTO VW_JOB VALUES( 'J8', '인턴');

-- 뷰를 통해서 UPDATE
-- JOB_CODE가 J8인 데이터를 JOB_NAME을 알바로 변경
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

SELECT * FROM VW_JOB;

-- 뷰를 통해서 DELETE
DELETE
FROM VW_JOB
WHERE JOB_CODE = 'J8';

DROP VIEW VW_JOB;

/*
   DML 구문으로 VIEW 조작이 불가능한 경우
   1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
   2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
   3. 산술표현식 또는 함수식으로 정의된 경우
   4. 그룹함수나 GROUP BY 절을 포함한 경우
   5. DISTINCT  구문이 포함된 경우
   6. JOIN을 이용해서 여러 테이블을 연결한 경우
*/

-- 1. 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_CODE
    FROM JOB;

-- INSERT 
INSERT INTO VW_JOB VALUES('J8', '인턴'); -- 에러 발생
INSERT INTO VW_JOB VALUES('J8');

SELECT * FROM JOB;

-- UPDATE
UPDATE VW_JOB SET JOB_NAME = '인턴' WHERE JOB_CODE = 'J7'; -- 에러 발생
UPDATE VW_JOB SET JOB_CODE = 'J0' WHERE JOB_CODE = 'J8';

-- DELETE
DELETE FROM VW_JOB WHERE JOB_NAME = '사원'; -- 에러 발생
DELETE FROM VW_JOB WHERE JOB_CODE = 'J0';

DROP VIEW VW_JOB;

-- 2. 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 컬럼이 NOT NULL 제약조건이 지정된 경우
CREATE OR REPLACE VIEW VW_JOB
AS SELECT JOB_NAME
    FROM JOB;
    
-- INSERT
INSERT INTO VW_JOB VALUES('인턴'); -- JOB_CODE가 없으니까 NULL로 들어가는데 그럼 제약조건 위배

-- UPDATE
UPDATE VW_JOB
SET JOB_NAME = '알바'
WHERE JOB_NAME = '사원';

ROLLBACK;

-- DELETE
DELETE
FROM VW_JOB
WHERE JOB_NAME = '사원';

-- 3. 산술표현식 또는 함수식으로 정의된 경우
CREATE OR REPLACE VIEW VW_EMP_SAL
AS SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 연봉
    FROM EMPLOYEE;
    
-- INSERT
-- 산술연산으로 정의된 컬럼은 데이터 삽입 불가능
INSERT INTO VW_EMP_SAL VALUES(400, '홍길동', 3000000, 36000000);

INSERT INTO VW_EMP_SAL(EMP_ID, EMP_NAME, SALARY)
VALUES(400, '홍길동', 3000000);

ALTER TABLE EMPLOYEE MODIFY EMP_NO NULL;

SELECT * FROM EMPLOYEE;

-- UPDATE
-- 200번 사원의 연봉을 800만원으로
UPDATE VW_EMP_SAL
SET 연봉 = 8000000
WHERE EMP_ID = 200; --에러 (산술연산으로 정의된 컬럼은 데이터 변경 불가능)

-- 200번 사원의 급여를 700만원으로
UPDATE VW_EMP_SAL
SET SALARY = 7000000
WHERE EMP_ID = 200; -- 성공 (산술연산과 무관한 컬럼은 데이터 변경 가능)

ROLLBACK;

-- DELETE
DELETE
FROM VW_EMP_SAL
WHERE 연봉 = 72000000; -- 산술연산으로 정의된 컬럼 DELETE는 가능

ROLLBACK;

-- 4. 그룹함수나 GROUP BY 절을 포함한 경우
-- 부서별 급여의 합계, 평균을 조회
SELECT DEPT_CODE, SUM(SALARY), FLOOR(AVG(NVL(SALARY, 0)))
FROM EMPLOYEE
GROUP BY DEPT_CODE;

CREATE OR REPLACE VIEW VW_GROUPDEPT
AS SELECT DEPT_CODE,
    SUM(SALARY) "합계",
     FLOOR(AVG(NVL(SALARY, 0))) "평균"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- INSERT
INSERT INTO VW_GROUPDEPT VALUES('D3', 8000000, 4000000);

-- UPDATE (에러)
UPDATE VW_GROUPDEPT
SET 합계 = 8000000
WHERE DEPT_CODE = 'D1';

-- DELETE (에러)
DELETE 
FROM VW_GROUPDEPT
WHERE 합계 = 5210000;

-- 5. DISTINCT 구문이 포함된 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS SELECT DISTINCT JOB_CODE
    FROM EMPLOYEE;
    
SELECT * FROM VW_DT_JOB;

-- INSERT 
INSERT INTO VW_DT_JOB VALUES('J8');














