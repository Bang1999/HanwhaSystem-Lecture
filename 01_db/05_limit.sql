-- limit
-- 전체 행 조회		LIMIT은 키워드(Keyword)!
-- (참고) 페이징 처리할 때 많이 사용한다.
SELECT 
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu
 ORDER BY menu_price DESC;

-- limit이 포함된 order by랑 단순 order by는 정렬 기준 컬럼의 값이 같으면
-- 약간의 순서 차이가 있을 수 있다.(추가적인 정렬 기준으로 조정가능)
SELECT
		 menu_code
	  , menu_name
	  , menu_price
  FROM tbl_menu 
 ORDER BY menu_price DESC, menu_code DESC
 LIMIT 4, 3;		-- 4번 인덱스 위치부터 3개를 자른다(즉, 5부터 7까지).


-- 단순 위에서부터 10개 짜르기! 그냥 length만 적으면 된다.
SELECT 
		 *
  FROM tbl_menu
 ORDER BY menu_code LIMIT 10;
 


