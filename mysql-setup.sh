#!/bin/sh

mysql -uadmin -p${MYSQL_PASS} <<EOF
CREATE DATABASE busplan CHARACTER SET utf8;
GRANT ALL ON busplan.* TO busman@localhost IDENTIFIED BY 'southparks2e17';

EOF

mysql -ubusman -psouthparks2e17 <<EOF
SHOW DATABASES;
USE busplan;
CREATE TABLE plans (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(1024));
DESCRIBE plans;
INSERT INTO plans(name) VALUES ("Step one");
INSERT INTO plans(name) VALUES ("Step two");
INSERT INTO plans(name) VALUES ("????");
INSERT INTO plans(name) VALUES ("PROFIT!!!");
SELECT * FROM plans;

EOF

