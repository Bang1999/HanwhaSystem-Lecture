/* constraint(제약조건) */

/* 1. not null 제약조건 */
-- null값을 포함할 수 없는 컬럼에 대한 제약조건이자 컬럼 레벨에서만 
-- 제약조건 추가가능
DROP TABLE if EXISTS user_notnull;

-- user_notnull 테이블 생성
CREATE TABLE if NOT EXISTS user_notnull(
  user_no INT NOT NULL,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),		-- not null을 안적으면 default로다가 nullable 제약 조건 상태
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255)
) ENGINE=INNODB;

-- 값 INSERT
INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');
SELECT * FROM user_notnull;

-- 아래 INSERT는 에러발생!(user_name 'NOT NULL'이라서)
INSERT
  INTO user_notnull
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass03', NULL, '남', '010-1234-5678', 'hong1234@gmail.com') -- not null constraint 변환


/* 2.unique 제약조건 */
-- 중복값이 들어가지 않도록 하는 제약조건이다.
-- 컬럼레벨 및 테이블레벨 모두 가능하다.
DROP TABLE if EXISTS user_unique;
CREATE TABLE if NOT EXISTS user_unique(
  user_no INT NOT NULL UNIQUE,		-- 컬럼 제약 조건
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),		-- not null을 안적으면 default로다가 nullable 제약 조건 상태
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone)							-- 테이블 제약 조건
) ENGINE=INNODB;

-- 값 INSERT
INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');
SELECT * FROM user_unique;

-- 'phone'은 UNIQUE라서 중복 불가!
INSERT
  INTO user_unique
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(3, 'user03', 'pass01', '홍길동2', '남', '010-1234-5678', 'hong1234@gmail.com');


/* 3. primary key 제약 조건 */
-- not null + unique 제약조건이라고 볼 수 있다.
-- 모든 테이블은 반드시 primary key를 가져야 한다.(두 개 이상 제약조건을 할 수는 없다.)
DROP TABLE if EXISTS user_primarykey;
CREATE TABLE if NOT EXISTS user_primarykey (
  user_no INT,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),				-- not null을 안적으면 default로다가 nullable 제약 조건 상태
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  UNIQUE(phone),							-- 테이블 제약 조건
  PRIMARY KEY(user_no)					-- 테이블 제약 조건
) ENGINE=INNODB;

-- 값 INSERT
INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-1234-5678', 'hong123@gmail.com'),
(2, 'user02', 'pass02', '유관순', '여', '010-777-7777', 'yu77@gmail.com');

-- PRIMARY KEY(user_no), 중복 불가, NULL 불가(기본 패시브)
INSERT
  INTO user_primarykey
(user_no, user_id, user_pwd, user_name, gender, phone, email)
VALUES
(1, 'user012', 'pass012', '홍길동2', '남2', '010-1234-56782', 'hong1232@gmail.com');

TRUNCATE user_primarykey;


/* 4. foreign key 제약조건 */
-- 4-1. 회원등급 부모 테이블 먼저 생성
DROP TABLE if EXISTS user_grade;
CREATE TABLE if NOT EXISTS user_grade(
  grade_code INT NOT NULL UNIQUE,
  grade_name VARCHAR(255) NOT NULL
);

-- 4-2. 회원 자식 테이블을 이후에 생성
CREATE TABLE if NOT EXISTS user_foreignkey1 (
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,
-- grade_code INT REFERENCES user_grade(grade_code)	 <- 이것도 가능~
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)		-- user_grade(grade_code)에서 grade_code는 부모 pk,
) ENGINE=INNODB;																-- FOREIGN KEY(grade_code)에서 grade_code는 자식 fk
																					-- ex) 'FROM <A> JOIN <B> ON A.KEY = B.KEY' 느낌 서로 연결

-- 부모 테이블 값 INSERT
INSERT
  INTO user_grade
VALUES
(10, '일반회원'),
(20, '우수회원'),
(30, '특별회원');

-- 자식 테이블 값 INSERT
INSERT 
  INTO user_foreignkey1
VALUES
(1, 'user01', 'pass01', '홍길동', '남', '010-111-2222', 'hong@gmail.com', 10),
(2, 'user02', 'pass02', '유관순', '여', '010-333-2123', 'yu@gmail.com', 20);
SELECT * FROM user_foreignkey1;

-- foreign key 제약조건이 걸린 컬럼은 부모테이블의 (pk값 & null값)까지 들어갈 수 있다.
INSERT 
  INTO user_foreignkey1
VALUES
(3, 'user01', 'pass01', '홍길동', '남', '010-111-2222', 'hong@gmail.com', NULL);
SELECT * FROM user_foreignkey1;

-- FOREIGN KEY 제약조건이 걸린 컬럼이 부모에 없는 값이 들어갈 수는 없다. -> (40 부모에 없어 ERROR)
INSERT 
  INTO user_foreignkey1
VALUES
(4, 'user02', 'passmenudb02', '유관순', '여', '010-333-2123', 'yu@gmail.com', 40);


-- 10번 등급의 회원이 이미존재하므로 10번 등급은 삭제할 수 없다.(참조 O, 관계를 맺고 있어서 ERROR)
DELETE 
  FROM user_grade
 WHERE grade_code = 10;

-- 30번 등급의 회원은 존재하지 않으므로 30번 등급은 삭제할 수 있다.(참조 X, 관계를 맺지 않고 있다.)
DELETE 
  FROM user_grade
 WHERE grade_code = 30;
SELECT * FROM user_foreignkey1;

-- 4-3. 삭제룰을 적용한 foreign key 제약조건 작성(참조하고 있어도 삭제할 수 있는 방법)
DROP TABLE IF EXISTS user_foreignkey2;
CREATE TABLE if NOT EXISTS user_foreignkey2 (
  user_no INT PRIMARY KEY,
  user_id VARCHAR(255) NOT NULL,
  user_pwd VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  gender VARCHAR(3),
  phone VARCHAR(255) NOT NULL,
  email VARCHAR(255),
  grade_code INT,
  FOREIGN KEY(grade_code) REFERENCES user_grade(grade_code)		
  ON DELETE SET NULL 		-- [삭제룰 추가]	참조중인거 지우면 null로 표기해주는거 
) ENGINE=INNODB;				-- 원래 참조중인거 못지움 

-- user_foreignkey2 값 INSERT
INSERT 
  INTO user_foreignkey2
VALUES
(1, 'user02', 'passmenudb02', '유관순', '여', '010-333-2123', 'yu@gmail.com', 10);

-- 다른 삭제룰이 없는 자식 테이블의 데이터 방해를 제거
TRUNCATE user_foreignkey1;

-- 현재 회원의 참조 컬럼 값 확인
SELECT * FROM user_foreignkey2;

-- 참조하는 부모 테이블의 행 삭제 후 참조 컬럼 값 확인
DELETE FROM user_grade WHERE grade_code = 10;		-- 테이블을 CREATE할 때 [삭제룰]을 적용해서가능
SELECT * FROM user_foreignkey2;