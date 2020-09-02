mysql -h localhost <<EOF
CREATE USER 'wiki'@'localhost' IDENTIFIED BY 'abcd1234';
CREATE DATABASE wikidatabase;
GRANT ALL PRIVILEGES ON wikidatabase.* TO 'wiki'@'localhost';
SHOW DATABASES;
SHOW GRANTS FOR 'wiki'@'localhost';
exit
EOF
