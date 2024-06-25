CREATE user 'swcamp'@'%' IDENTIFIED BY 'swcamp';
SELECT * FROM user;

CREATE DATABASE menudb;

GRANT ALL PRIVILEGES ON menudb.* TO 'swcamp'@'%';

SHOW GRANTS FOmenudbR 'swcamp'@'%';


CREATE user 'practice'@'%' IDENTIFIED BY 'practice';
SELECT * FROM user;

CREATE DATABASE employeedb;

GRANT ALL PRIVILEGES ON employeedb.* TO 'practice'@'%';

SHOW GRANTS FOR 'practice'@'%';