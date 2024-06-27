-- type casting(형 변환)
-- 1. 명시적 형변환(Explicit Type Casting)

-- 1) 숫자 -> 숫자
SELECT CAST(AVG(menu_price) AS UNSIGNED INTEGER) AS '가격평균'	-- 음수 빼고 부호가 없는 정수 형태)소수점 이하 짤라버린 상태
  FROM tbl_menu;
DESC tbl_menu;

-- 소수점 이하 한자리까지만 표기할 수도 있다.
SELECT CAST(AVG(menu_price) AS FLOAT) AS '가격평균'
  FROM tbl_menu; 

-- 소수점 이하 12자리까지도 표기할 수 있다.
SELECT CAST(AVG(menu_price) AS DOUBLE) AS '가격평균'
  FROM tbl_menu; 

-- 2) 문자 -> 날짜
-- 2024년 6월 27일 data형으로 변환
SELECT CAST('2024$6$27' AS DATE);
SELECT CAST('2024/6/27' AS DATE);  
SELECT CAST('2024%6#27' AS DATE);


-- 3) 숫자 -> 문자
SELECT CONCAT(CAST(1000 AS CHAR), '원');
SELECT CONCAT(1000, '원');		-- 묵시적 형변환 or 암시적 형변환
  
  
  
-- --------------------------------------------------------  
-- 2. 암시적 형변환 (Implicit Type Casting)
-- --------------------------------------------------------
SELECT 1 + '2';
SELECT 1 + CAST('2' AS INT);  -- mariaDB가 연산 시 치환하기 힘든 문자열은 0으로 치환하여 적용한다.
SELECT 5 > '반가워';				-- '반가워' int 변환시 0으로 치환, '2반가워' int 변환시 2로 치환(숫자가 앞에 나올때만)
										-- (true에 해당하는 건 1, false는 0)


SELECT RAND(), FLOOR(RAND() * (11 - 1) + 1);
