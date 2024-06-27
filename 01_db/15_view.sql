/* view */
-- user, table 다음으로 배우는 view
-- 테이블을 활용한 가상 테이블(주로 조회용)
-- view는 원본 테이블을 참조해서 보여주는 용도이고
-- 보여지는건 실제 테이블(베이스 테이블)의 값이다.
-- view 사용 목적
-- 1. DBA가 개발자에게 보여주고 싶은 것만 추출해서 보여준다.
-- 2. 업무할때 이해하기 쉬운 평이한 용어로 바꿔준다.(별칭을 달아준다.)

SELECT
		 menu_name
	  , menu_price
  FROM tbl_menu;

-- DROP VIEW v_menu;
CREATE OR REPLACE VIEW v_menu			-- or REPLACE(덮어씌우기), drop 없이 다시 만들기 가능하다.
AS
SELECT
		 menu_name AS '메뉴명'
	  , menu_price AS '메뉴단가'
  FROM tbl_menu
--   WITH READ ONLY;						-- 뷰를 통해 수정을 가하면 db가 수정된다.
  												-- 이를 막기위해 다른 db에서는 WITH READ ONLY라는게 있다.
SELECT * FROM v_menu;

/* view를 통한 DML(절대 절대 비추!)*/
-- 베이스 테이블(tbl_menu) 조회
SELECT * FROM tbl_menu;

-- view 생성
CREATE OR REPLACE VIEW hansik
AS
SELECT
		 menu_code
	  , menu_name
	  , menu_price
	  , category_code
	  , orderable_status
  FROM tbl_menu
 WHERE category_code = 4;

SELECT * FROM hansik;

-- hansik이라는 view를 통해 tbl_menu라는 베이스 테이블에 영향을 줌
INSERT 									-- 베이스 테이블(tbl_menu)에도 들어감
  INTO hansik
VALUES 
(NULL, '식혜맛국밥', 5500, 4, 'Y');

SELECT * FROM tbl_menu;

UPDATE hansik
   SET menu_name = '버터맛국밥'
     , menu_price = 6000
 WHERE menu_name = '식혜맛국밥';


CREATE OR REPLACE VIEW v_test
AS
SELECT 
		 AVG(menu_price)+3
  FROM tbl_menu;

SELECT * FROM v_test;

INSERT INTO v_test VALUES (10);			-- ERROR 당연하게 말이 안되죠~