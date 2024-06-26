/* DDL(Data Definition Language) */
CREATE TABLE if NOT EXISTS tb1(
  pk INT PRIMARY KEY,
  fk INT,
  col1 VARCHAR(255),			-- varchar(가변) : 문자열 들어갈 예정, 255byte : 
  CHECK(col1 IN ('Y', 'N'))		-- 테이블 제약조건 'Y', 'N' 말고는 들어갈 수 없음
) ENGINE = INNODB;

-- 존재하는 테이블을 요약해서 보고 싶다면 describe 키워드 가능
DESC tb1;
DESCRIBE tb1;

INSERT
  INTO tb1
VALUES 
(
  1, 2, 'Y'
);

/* auto_increment */
/* drop */
DROP TABLE tb2;

-- 값을 기억하는 번호 발생기
CREATE TABLmenudbE tb2(
  pk INT PRIMARY KEY AUTO_INCREMENT,
  fk INT,
  col1 VARCHAR(255),
  CHECK(col1 IN('Y', 'N'))
) ENGINE=INNODB;

DESC tb2;

INSERT 
  INTO tb2
VALUES
(
  NULL
, 2
, 'N'
);

SELECT * FROM tb2;

/* alter */
-- 업데이트 같은 개념
-- 1) 컬럼 추가
ALTER TABLE tb2 ADD col2 INT NOT NULL;
DESC tb2;

-- 2) 컬럼 삭제
ALTER TABLE tb2 DROP COLUMN col2;
DESC tb2;

-- 3) 컬럼 이름 및 컬럼 정의 변경
ALTER TABLE tb2 CHANGE COLUMN fk CHANGE_fk INT NOT NULL;
DESC tb2;

-- 4) 제약조건 제거(primary key 제약조건 제거 도전)
ALTER TABLE tb2 DROP PRIMARY KEY;

-- auto_increment 먼저 제거(drop이 아닌 modify)
ALTER TABLE tb2 MODIFY pk INT;
DESC tb2;

-- 다시 primary key 제거
ALTER TABLE tb2 DROP PRIMARY KEY;
DESC tb2;

/* truncate */ 
-- 삭제(delete), 절삭(truncate) (남기는거 하나 없이 완전 없애는 방법)
-- 절삭(truncate) : 테이블의 데이터(데이터 및 관련 제약조건 관련 등 깔끔하게 제거)
-- 삭제(delete) : 테이블의 초기화(테이블 처음 만들 당시로 돌려줌)
-- 절삭(truncate) : 데이터에 관련된 인덱스도 같이 밀어준다. 효율좋은 초기화 방법
CREATE TABLE if NOT EXISTS tb3 (
  pk INT AUTO_INCREMENT,	-- 여기서 제약 조건 거는건 테이블 제약 조건
  fk INT,
  col1 VARCHAR(255),
  PRIMARY KEY(pk),			-- 컬럼 제약 조건
  CHECK(col1 IN('Y', 'N')) -- 컬럼 제약 조건
);

INSERT 
  INTO tb3
VALUES
(
  NULL
, 1
, 'N'
);

DESC tb3;

TRUNCATE TABLE tb3;