/* INDEX(색인) */
-- 목적 : 빨리 찾기 위함(빠른 검색)
-- DBMS에서의 INDEX의 개념 : idx와 실제 코드와 맵핑 해놓은 따로 만든 테이블
-- (우리가 지정한 컬럼과 맵핑)(별도의 공간에 저장~)(속도 FAST)
-- 모든 테이블의 primary key는 자동으로 idx가 부여된다.
-- <장점>
-- 속도 FAST
-- 30% 정도 범위를 검색할 때 효율 UP!
-- <단점>
-- 1. 별도의 저장공간이 별요하다.(추가적인 공간)
-- 2. 잦은 변화가 있는 것에 대해 효율이 안좋아질 수 있다.(BUT, 인덱스 작업을 주기적을 해주면 괜츈)
-- 최대한 잦은 변동 X, 만약 잦은 변동 O -> rebuild idx

SELECT * FROM tbl_menu;
DROP TABLE if EXISTS phone;
CREATE TABLE phone(
  phone_code INT PRIMARY KEY,
  phone_name VARCHAR(100),
  phone_price DECIMAL(10, 2)
);

INSERT 
  INTO phone
VALUES
(1, 'galaxyS24', 1200000),
(2, 'iphone14pro', 1430000),
(3, 'galaxyfold3', 1730000);

SELECT * FROM phone;

-- (idx 활용x) where절을 활용한 단순 조회
SELECT * FROM phone WHERE phone_name = 'galaxyS24';
-- phone 테이블의 phone_name이 'galaxyS24'인 행의 설명
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS24';		-- EXPLAIN : 실행 계획 확인하는 것


-- phone_name에 index 추가하기
CREATE INDEX idx_name ON phone(phone_name);
SHOW INDEX FROM phone; 		-- phone에 인덱스 걸려있는거 보는 법



-- 다시 INDEX가 추가된 컬럼으로 조회해서 INDEX를 태웠는지 확인
SELECT * FROM phone WHERE phone_name = 'galaxyS24';
EXPLAIN SELECT * FROM phone WHERE phone_name = 'galaxyS24';


-- rebuild(주기적으로 한번씩 다시 index를 rebuild해 주어야 한다.
-- (mariadb는 optimize 키워드를 사용한다.))
OPTIMIZE TABLE phone;

DROP INDEX idx_name ON phone;
SHOW INDEX FROM phone;		-- index가 두줄이였는데 한줄로 변경되었다.

