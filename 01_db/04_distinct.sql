-- distinct
-- 중복되는 값을 한번만 표기하는 방법

-- 단일 열 distinct
SELECT 
		 category_code
  FROM tbl_menu
 ORDER BY category_code;
 

-- ★테이블을 이해하고 아래 코드를 뽑을 수 있어야한다.
-- 메뉴가 할당된 카테고리의 종류
SELECT
		 DISTINCT category_code
  FROM tbl_menu
 ORDER BY category_code;
 
-- 상위 카테고리 조회하기
-- 1) where절 활용
SELECT 
		 *
  FROM tbl_category
  WHERE ref_category_code IS NULL;

-- 2) 아래 코드를 통해 카테고리의 상위 카테고리 번호를 알 수 있다.
SELECT
		 DISTINCT ref_category_code		
--   , category_name AS '카테고리명'		-- 그냥 별칭 붙여보기~
  FROM tbl_category
 WHERE ref_category_code IS NOT NULL;
 
-- 추후 배울 예정이지만 서브 쿼리를 활용하면 하나의 
-- 쿼리로 작성할 수 있다. 
-- 소괄호 : 서브 쿼리 각 행마다 소괄호 먼저 처리된후 밖으로 나온다/
SELECT 
		 *
  FROM tbl_category
 WHERE category_code IN (SELECT DISTINCT ref_category_code
 										 FROM tbl_category
 										WHERE ref_category_code IS NOT NULL
 									 );


-- 다중열 distinct
SELECT
		 category_code
	  , orderable_status 
  FROM tbl_menu;
  
SELECT 
		 DISTINCT
		 category_code
	  , orderable_status
  FROM tbl_menu;
  





