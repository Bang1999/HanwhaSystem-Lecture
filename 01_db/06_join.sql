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
  FROM tbl_menu a
  JOIN tbl_category b USING(category_code);
  



