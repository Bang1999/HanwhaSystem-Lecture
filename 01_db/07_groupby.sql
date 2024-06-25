-- group by절
-- 느낌이 distinct와 유사
-- 해석 : 메뉴가 존재하는 카테고리 그룹 조회
-- 그룹 함수(sum, avg, count, max, min)를 적용하기 위한 설정
-- 그룹으로 묶고 그룹의 결과를 본다.
SELECT
		 category_code
  FROM tbl_menu
 GROUP BY category_code;

-- 1) count 함수 활용
SELECT 				-- select의 횟수가 그룹의 횟수만큼 돈다.
 		 COUNT(*)
 	  , concat(a.category_code, '번 카테고리') AS '카테고리 번호'
--  	  , a.menu_name	-- 무의미하다. 모두 보여주지 않아서..
  FROM tbl_menu a
 GROUP BY a.category_code;

-- count 함수
-- count(컬럼명 또는 *)
-- count(컬럼명) 해당 컬럼에 null이 아닌 행의 갯수
-- count(*) 모든 행의 갯수
SELECT 
		 COUNT(*) AS '모든 카테고리 행 개수'
	  , COUNT(ref_category_code) '상위 카테고리가 존재하는 카테고리'-- null값 제외, 유효한 데이터
  FROM tbl_category;

-- 2) sum 함수 활용
SELECT
		 category_code
	  , SUM(menu_price)
  FROM tbl_menu
 GROUP BY category_code;

-- avg 함수 활용
SELECT
		 category_code
	  ,  FLOOR(AVG(menu_price))
  FROM tbl_menu
 GROUP BY category_code;


-- having절
SELECT 
		 SUM(menu_price)
	  , category_code
  FROM tbl_menu
 GROUP BY category_code 
--  HAVING category_code BETWEEN 5 AND 9;
HAVING SUM(menu_price) >= 20000;


