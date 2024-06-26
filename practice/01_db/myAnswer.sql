-- Mini assignment : EMPLOYEE 데이터로 mariadb 조회 연습
-- 이름 : 방동호
-- 날짜 : 24.06.25

-- 1. 모든 사원 모든 컬럼 조회
SELECT 
		 *
  FROM employee a;

-- 2. 사원들의 사번(사원번호), 이름 조회
SELECT 
	    a.EMP_ID
	  , a.EMP_NAME
  FROM employee a;

-- 3. 201번 사번의 사번 및 이름 조회
SELECT 
	    a.EMP_ID
	  , a.EMP_NAME
  FROM employee a
 WHERE a.EMP_ID = 201;
 
-- 4. employee 테이블에서 부서 코드가 'D9'인 사원 조회
SELECT
		 *
  FROM employee a
 WHERE a.DEPT_CODE = 'D9';
 
-- 5. employee 테이블에서 직급 코드가 'J1'인 사원 조회
SELECT
		 *
  FROM employee a
 WHERE a.JOB_CODE = 'J1';
 
-- 6. employee 테이블에서 급여가 300만원 이상(>=)인 사원의
--    사번, 이름, 부서코드, 급여를 조회하시오.
SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , a.DEPT_CODE
     , a.SALARY
  FROM employee a
 where a.SALARY >= 3000000;
 
-- 7. 부서코드가 'D6'이고, 급여를 300만원보다 많이 받는
--    직원의 이름, 부서코드, 급여 조회
SELECT
		 a.EMP_NAME
	  , a.DEPT_CODE
	  , a.SALARY
  FROM employee a
 WHERE a.DEPT_CODE = 'D6'
   AND a.SALARY > 3000000;
 
-- 8. 보너스를 받지 않는 사원에 대한
--    사번, 직원명, 급여, 보너스를 조회
SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , a.SALARY
	  , a.BONUS
  FROM employee a
 WHERE a.BONUS IS NULL;
 
-- 9. 'D9'부서에서 근무하지 않는 사원의
--    사번, 이름, 부서코드를 조회
SELECT 
		 a.EMP_ID
	  , a.EMP_NAME
	  , a.DEPT_CODE
  FROM employee a
 WHERE a.DEPT_CODE <> 'D9';	-- != 사용가능~
 
-- 10. employee 테이블에서 퇴사 여부가 N인 직원들 조회하고
-- 사번, 이름, 입사일을 별칭을 사용해 조회해 보기
-- (퇴사 여부 컬럼은 ENT_YN이고, N은 퇴사 안한 사람, Y는 퇴사 한 사람)
SELECT
		 a.EMP_ID AS '사번'
	  , a.EMP_NAME AS '이름'
	  , a.HIRE_DATE AS '입사일'
  FROM employee a
 WHERE a.ENT_YN = 'N';
 
-- 11. employee 테이블에서 급여 350만원 이상
-- 550만원 이하를 받는 직원의
-- 사번, 이름, 급여, 부서코드, 직급코드를 별칭을 사용해 조회해보기
SELECT
		 a.EMP_ID AS '사번'
	  , a.EMP_NAME AS '이름'
	  , a.SALARY AS '급여'
	  , a.DEPT_CODE AS '부서코드'
	  , a.JOB_CODE AS '직급코드'
  FROM employee a
 WHERE a.SALARY BETWEEN 3500000 AND 5500000;
--  WHERE a.SALARY <= 5500000
--  	AND a.SALARY >= 3500000;
 
-- 12. employee 테이블에서 '성이 김씨'인 직원의 사번, 이름, 입사일 조회
SELECT 
		 a.EMP_ID
	  , a.EMP_NAME
	  , a.HIRE_DATE
  FROM employee a
 WHERE a.EMP_NAME LIKE '김%';
 
-- 13. employee 테이블에서 '성이 김씨'가 아닌 직원의 사번, 이름, 입사일 조회
SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , a.HIRE_DATE
  FROM employee a
 WHERE a.EMP_NAME NOT LIKE '김%';
 
-- 14. employee 테이블에서 '하'문자가 이름에 포함된 
-- 직원의 이름, 주민번호, 부서코드 조회
SELECT
		 a.EMP_NAME
	  , a.EMP_NO
	  , a.DEPT_CODE
  FROM employee a
 WHERE a.EMP_NAME LIKE '%하%';
 
-- 15. 'J2'직급이면서 급여가 200만원 이상인 직원이거나
-- 'J7' 직급인 직원의 이름, 급여, 직급코드 조회
-- myCode
SELECT
		 a.EMP_NAME
	  , a.SALARY
	  , a.JOB_CODE
  FROM employee a
 WHERE (a.JOB_CODE = 'J2' AND a.SALARY >= 2000000)
    OR a.JOB_CODE = 'J7';
    
-- teacherCode
SELECT
       EMP_NAME
     , SALARY
     , JOB_CODE
  FROM EMPLOYEE
 WHERE JOB_CODE = 'J2'
   AND SALARY >= 2000000
    OR JOB_CODE = 'J7';
-- ---------------------------------------------------------

-- 16. 'J2'직급이거나 'J7'직급인 직원들 중에
-- 급여가 200만원 이상인 직원의 이름, 급여, 직급코드 조회
SELECT
		 a.EMP_NAME
	  , a.SALARY
	  , a.JOB_CODE
  FROM employee a
 WHERE (a.JOB_CODE = 'J2' OR a.JOB_CODE = 'J7')
 	AND a.SALARY >= 2000000;
 	
-- 17. IN연산자로 업그레이드
SELECT
		 a.EMP_NAME
	  , a.SALARY
	  , a.JOB_CODE
  FROM employee a
 WHERE a.JOB_CODE IN ('J2', 'J7')
 	AND a.SALARY >= 2000000;
 	
-- -------------------------------------------------------------
-- <JOIN 사용 연습문제>

-- 1. 이름에 '형'자가 들어가는 직원들의 사번, 사원명, 부서명을 조회하시오.(1명)
SELECT
		 a.EMP_ID
	  , a.EMP_NAME
	  , b.DEPT_TITLE
  FROM employee a
  JOIN department b ON a.DEPT_CODE = b.DEPT_ID
 WHERE a.EMP_NAME LIKE '%형%';
  
-- 2. 해외영업팀에 근무하는 
-- 사원명, 직급명, 부서코드, 부서명을 조회하시오.(9명)
-- myCode
SELECT
		 b.EMP_NAME AS '사원명'
	  , c.JOB_NAME AS '직급명'
	  , a.DEPT_ID AS '부서코드'
	  , a.DEPT_TITLE AS '부서명'
  FROM department a
 RIGHT JOIN employee b ON a.DEPT_ID = b.DEPT_CODE
  LEFT JOIN job c ON c.JOB_CODE = b.JOB_CODE
 WHERE a.DEPT_TITLE LIKE '해외영업%';
SELECT * FROM department;

-- teacherCode
SELECT
       A.DEPT_ID
  FROM DEPARTMENT A
 WHERE A.DEPT_TITLE LIKE '%해외영업%';  -- D5, D6, D7
SELECT
       A.EMP_NAME "사원명"
     , C.JOB_NAME "직급명"
     , A.DEPT_CODE "부서코드"
     , B.DEPT_TITLE "부서명"
  FROM EMPLOYEE A
  JOIN DEPARTMENT B ON (A.DEPT_CODE = B.DEPT_ID)
  JOIN JOB C ON (A.JOB_CODE = C.JOB_CODE)
 WHERE A.DEPT_CODE IN ('D5', 'D6', 'D7');
-- ---------------------------------------------------------

-- 3. 보너스포인트를 받는 직원들의 사원명, 
-- 보너스포인트, 부서명, 근무지역명을 조회하시오.(8명)
SELECT
		 a.EMP_NAME
	  , a.BONUS
	  , b.DEPT_TITLE
	  , c.LOCAL_NAME
  FROM employee a
 RIGHT JOIN department b ON b.DEPT_ID = a.DEPT_CODE
  LEFT JOIN location c ON c.LOCAL_CODE = b.LOCATION_ID
 WHERE a.BONUS IS NOT NULL;

-- 4. 부서코드가 D2인 직원들의 사원명, 
-- 직급명, 부서명, 근무지역명을 조회하시오.(3명)
-- 근무지역명
SELECT 
		 d.EMP_NAME AS '사원명'
	  , e.JOB_NAME AS '직급명'
	  , c.DEPT_TITLE AS '부서명'
	  , b.LOCAL_NAME AS '근무지역명'
  FROM location b 
 RIGHT JOIN department c ON c.LOCATION_ID = b.LOCAL_CODE
  JOIN employee d ON c.DEPT_ID = d.DEPT_CODE
  LEFT JOIN job e ON e.JOB_CODE = d.JOB_CODE
 WHERE c.DEPT_ID = 'D2';
 
-- 5. 급여 테이블의 등급별 최소급여(MIN_SAL)보다 많이 받는 직원들의
-- 사원명, 직급명, 급여, 연봉을 조회하시오.
-- 연봉에 보너스포인트를 적용하시요.(20명)
-- myCode
SELECT 
	    b.EMP_NAME AS '사원명'
     , a.JOB_NAME AS '직급명'
     , b.SALARY AS '급여'
     , LEAST(b.SALARY, b.SALARY*(1 + COALESCE(b.BONUS, 0)))*12 AS '연봉'  -- 연봉은 테이블을 따로 만들어서 해야할거같은데 어쩌노
  FROM job a
 RIGHT JOIN employee b ON a.JOB_CODE = b.JOB_CODE
  LEFT JOIN sal_grade c ON c.SAL_LEVEL = b.SAL_LEVEL
 WHERE b.SALARY > c.MIN_SAL;

SELECT * FROM sal_grade;

-- teacherCode
SELECT
       A.EMP_NAME "사원명"
     , B.JOB_NAME "직급명"
     , A.SALARY "급여"
--      , A.SALARY * ( 1 + NVL(A.BONUS, 0)) * 12 "연봉"
     , A.SALARY * ( 1 + IFNULL(A.BONUS, 0)) * 12 "연봉"
  FROM EMPLOYEE A
  JOIN JOB B ON (A.JOB_CODE = B.JOB_CODE)
  JOIN SAL_GRADE C ON (A.SAL_LEVEL = C.SAL_LEVEL)
 WHERE A.SALARY > C.MIN_SAL;
 
-- 상관 서브쿼리를 활용해서 풀어보기
SELECT
       A.EMP_NAME "사원명"
     , B.JOB_NAME "직급명"
     , A.SALARY "급여"
     , A.SALARY * ( 1 + NVL(A.BONUS, 0)) * 12 "연봉"
  FROM EMPLOYEE A
  JOIN JOB B ON (A.JOB_CODE = B.JOB_CODE)
 WHERE A.SALARY > (SELECT C.MIN_SAL
                     FROM SAL_GRADE C
                    WHERE A.SAL_LEVEL = C.SAL_LEVEL);
-- ------------------------------------------------------------------- 

-- 6. 한국(KO)과 일본(JP)에 근무하는 직원들의
-- 사원명, 부서명, 지역명, 국가명을 조회하시오.(15명)
SELECT
		 b.EMP_NAME AS '사원명'
	  , c.DEPT_TITLE AS '부서명'
	  , d.LOCAL_NAME AS '지역명'
	  , e.NATIONAL_NAME AS '국가명'
  FROM job a
 RIGHT JOIN employee b ON a.JOB_CODE = b.JOB_CODE
  LEFT JOIN department c ON c.DEPT_ID = b.DEPT_CODE
 RIGHT JOIN location d ON d.LOCAL_CODE = c.LOCATION_ID
  LEFT JOIN national e ON d.NATIONAL_CODE = e.NATIONAL_CODE
 WHERE e.NATIONAL_CODE = 'KO' 
    OR e.NATIONAL_CODE = 'JP';
--  WHERE e.NATIONAL_CODE IN ('KO', 'JP');
  
-- 7. 같은 부서에 근무하는 직원들의 사원명, 부서코드, 동료이름을 조회하시오.
-- self join 사용(60명)
SELECT
		 a.EMP_NAME
	  , a.DEPT_CODE
	  , b.EMP_NAME
  FROM employee a
  JOIN employee b ON a.DEPT_CODE = b.DEPT_CODE
 WHERE a.EMP_NAME <> b.EMP_NAME;

-- 8. 보너스포인트가 없는 직원들 중에서 직급코드가 
-- J4와 J7인 직원들의 사원명, 직급명, 급여를 조회하시오.
-- 단, join과 IN 사용할 것(8명)
SELECT 
		 a.EMP_NAME
	  , b.JOB_NAME
	  , a.SALARY
  FROM employee a
  JOIN job b ON b.JOB_CODE = a.JOB_CODE
 WHERE a.BONUS IS NULL
   AND a.JOB_CODE IN ('J4','J7');
   
-- 9. 직급이 대리이면서 아시아 지역(ASIA1, ASIA2, ASIA3 모두 해당)에 근무하는 직원 조회
-- 사번(EMPLOYEE.EMP_ID), 이름(EMPLOYEE.EMP_NAME), 직급명(JOB.JOB_NAME), 부서명(DEPARTMENT.DEPT_TITLE),
-- 근무지역명(LOCATION.LOCAL_NAME), 급여(EMPLOYEE.SALARY)를 조회하시오
-- (해당 컬럼을 찾고, 해당 컬럼을 지닌 테이블들을 찾고, 테이블들을 어떤 순서로 조인해야 하는지 고민하고 SQL문을 작성할 것)
SELECT
		 b.EMP_ID
	  , b.EMP_NAME
	  , a.JOB_NAME
	  , c.DEPT_TITLE
	  , d.LOCAL_NAME
	  , b.SALARY
  FROM job a
 RIGHT JOIN employee b ON a.JOB_CODE = b.JOB_CODE
  LEFT JOIN department c ON c.DEPT_ID = b.DEPT_CODE
 RIGHT JOIN location d ON d.LOCAL_CODE = c.LOCATION_ID
  LEFT JOIN national e ON d.NATIONAL_CODE = e.NATIONAL_CODE
 WHERE a.JOB_NAME = '대리'
   AND d.LOCAL_NAME LIKE 'ASIA%';