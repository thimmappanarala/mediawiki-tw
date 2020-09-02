FROM mariadb/server:10.3
ADD mariadb.sql  /root
ADD .my.cnf /root
RUN chmod 777 /root/mariadb.sql && chmod 600 /root/.my.cnf
ENV MYSQL_ROOT_PASSWORD=abcd1234
