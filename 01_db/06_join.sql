-- join
-- SET operate와 JOIN 차이점은? 뭔데?

-- 그전 잠깐!
-- alias(별칭)
-- 컬럼에 별칭을 다는 것 외에도 from절에 작성되는 것들에 
-- 별칭도 추가 가능하다.
-- 테이블 또는 from절에 별칭을 추가할 때는 
-- 싱글쿼테이션('') 없이 별칭을 작성한다
-- AS는 생략가능하다.
SELECT
		 a.category_code
	  , a.menu_name
  FROM tbl_menu AS a
 ORDER BY a.category_code, a.menu_name;

-- inner join
-- JOIN 별칭이 필수!!
-- join을 하는 순서도 중요(아래는 메뉴를 보고싶은데 카테고리도 보고싶어의 코드이다.)
-- inner라는 키워드는 생략해도 inner join이다.
-- 1) on을 활용
SELECT 
 		 a.menu_name
 	  , b.category_name
 	  , a.category_code		-- a.category_code or b.category code
--  	  , b.category_code	-- 둘중 아무거나 사용해도 값은 똑같이 나온다.
  FROM tbl_menu a
 -- INNER JOIN tbl_category b ON a.category_code = b.category_code;
  JOIN tbl_category b ON a.category_code = b.category_code; -- 실제론 이렇게 더 많이 쓴다.

-- 2) using을 활용(권장x) 남의 코드 해석할 정도로만!
-- (제한적인 상황)
-- join할 테이블들의 매핑 컬럼명들이 동일할 경우에만 사용 가능한 문법
SELECT 
 		 a.menu_name
 	  , b.category_name
 	  , a.category_code
  FROM tbl_menu a JOIN tbl_category b USING(category_code);

-- --------------------------------------------------------------
-- outer join
-- join은 순차적으로 진행된다.
-- join 키워드를 기준으로 왼쪽 오른쪽 을 left, right join
-- 1) left join
SELECT
		 a.category_name
	  , b.menu_name
  FROM tbl_category a
  LEFT JOIN tbl_menu b ON (a.category_code = b.category_code);
-- 해석 : 카테고리를 보고 싶은데 메뉴도 보고싶어
-- 1 대 다 관계

-- 2) right join
SELECT 
		 a.menu_name
	  , b.category_name
  FROM tbl_menu a
 RIGHT JOIN tbl_category b ON(a.category_code = b.category_code);
-- 해석 : 메뉴를 보고 싶은데 카테고리도 보고싶네
-- 이번엔 다 대 1 관계

-- 3) cross join
-- 주로 잘못될 경우에 cross join 이 이루어진다.
-- 조건이 필요 없다.
SELECT
 		 a.menu_name
 	  , b.category_name
  FROM tbl_menu a
 CROSS JOIN tbl_category b;

-- 4) self join
-- (빙글빙글) 내가 내 테이블을 join해버리네? 키득키득
-- a에 해당하는 것은 하위 카테고리, b에 해당하는 것은 상위 카테고리
-- 무한 대댓글 시스템~
SELECT
  		 a.category_name
  	  , b.category_name
  FROM tbl_category a
  JOIN tbl_category b ON(a.ref_category_code = b.category_code);
  
