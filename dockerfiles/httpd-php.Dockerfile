FROM oraclelinux:8.2
RUN  yum -y install httpd php php-mysqlnd php-gd php-xml php-mbstring php-json php-fpm tar firewalld
WORKDIR /var/www
ADD https://releases.wikimedia.org/mediawiki/1.34/mediawiki-1.34.2.tar.gz .
RUN tar -zxf mediawiki-1.34.2.tar.gz && ln -s mediawiki-1.34.2/ mediawiki && chown -R apache:apache /var/www/mediawiki-1.34.2 && systemctl enable httpd
#RUN firewall-cmd --permanent --zone=public --add-service=http && firewall-cmd --permanent --zone=public --add-service=https && systemctl restart firewalld
RUN restorecon -FR /var/www/mediawiki-1.34.2/ && restorecon -FR /var/www/mediawiki
RUN sed -i 's,/var/www/html,/var/www/mediawiki,g' /etc/httpd/conf/httpd.conf && sed -i 's,index.html,index.html index.html.var index.php,g' /etc/httpd/conf/httpd.conf && mkdir -p /run/php-fpm/
ENTRYPOINT ["/usr/sbin/httpd", "-DFOREGROUND"]

