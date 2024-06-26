/* set operator(집합연산자) */
-- join과 유사하지만, join과 다르게 테이블을 옆으로 붙이는게 아닌 나온 resultset을 위아래로 보여준다.

/* UNION(합집합) : 교집합 빼고 합하기 */
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
UNION 
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
/* UNION ALL(합집합인데 겹치는 것도 보여줘) */
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 10
UNION ALL
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE menu_price < 9000;
 
/* INTERSECT(교집합) */
-- MYSQL과 MARIADB는 INTERSECT가 공식적으로 지원되지 않는다.
-- 1) inner join 활용
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 INNER JOIN (SELECT b.menu_code
				  	   , b.menu_name
				  	   , b.menu_price
	 		 			, b.category_code
		  				, b.orderable_status
				   FROM tbl_menu b
				  WHERE b.menu_price < 9000) c ON (a.menu_code = c.menu_code)
 WHERE a.category_code = 10;
 
-- 2) in 연산자 활용
SELECT 
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
 WHERE a.category_code = 10
   AND a.menu_code IN (SELECT b.menu_code
								 FROM tbl_menu b
								WHERE b.menu_price < 9000);
-- 다중행 서브 쿼리는 = 쓰지 못한다. (IN 사용해야함)

/* minus(차집합) */
SELECT
		 a.menu_code
	  , a.menu_name
	  , a.menu_price
	  , a.category_code
	  , a.orderable_status
  FROM tbl_menu a
  LEFT JOIN (SELECT b.menu_code
				  	   , b.menu_name
				  	   , b.menu_price
	 		 			, b.category_code
		  				, b.orderable_status
				   FROM tbl_menu b
				  WHERE b.menu_price < 9000) c ON (a.menu_code = c.menu_code)
 WHERE a.category_code = 10
   AND c.menu_code IS NULL; -- 교집합을 빼는 조건을 달아준것이다.

