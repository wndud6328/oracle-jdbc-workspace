 -- 1. 보너스 포함한 연봉이 높은 5명의 사번, 이름, 부서명, 직급, 입사일, 순위 조회
SELECT EMP_ID, EMP_NAME,  DEPT_TITLE, JOB_NAME , HIRE_DATE , ROWNUM "순위"
FROM (
    SELECT ROWNUM, EMP_NAME, EMP_ID, (SALARY + SALARY * NVL(BONUS,0)) * 12 AS "연봉"
                            ,HIRE_DATE, JOB_NAME,DEPT_TITLE
    FROM EMPLOYEE E
    JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
    JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
    ORDER BY (SALARY + SALARY * NVL(BONUS,0)) * 12 DESC
    )
WHERE ROWNUM  <=5;


-- 2. 부서별 급여 합계가 전체 급여 총 합의 20% 보다 많은 부서의 부서명, 부서별 급여 합계 조회
SELECT DEPT_TITLE,  SUM(SALARY)
FROM DEPARTMENT D, EMPLOYEE E
WHERE E.DEPT_CODE = D.DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY) * 0.2 
                                    FROM EMPLOYEE E);
                                    
-- 3. WITH를 이용하여 급여 합과 급여 평균 조회
WITH TOPN_SAL AS(
    SELECT SUM(SALARY) AS "SUM(SALARY)",(AVG(NVL(SALARY,0))) "평균급여"
    FROM EMPLOYEE
    ORDER BY(AVG(NVL(SALARY,0))) DESC
)
SELECT "SUM(SALARY)", 평균급여
FROM TOPN_SAL


        
 