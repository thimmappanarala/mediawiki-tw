FROM mariadb/server:10.3
ADD mariadb.sql  /root
ADD .my.cnf
RUN chmod 777 /root/mariadb.sql
ENV MYSQL_ROOT_PASSWORD=abcd1234
