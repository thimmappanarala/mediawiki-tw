FROM mariadb/server:10.3
ADD  https://github.com/thimmappanarala/mediawiki-tw/blob/master/dockerfiles/mariadb.sql  /root
RUN chmod 777 /root/mariadb.sql
ENV MYSQL_ROOT_PASSWORD=abcd1234
