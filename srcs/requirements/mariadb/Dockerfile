FROM debian:bullseye

# gettext is nodig voor envsubst
# sql kan geen omgevings variabelen vervangen
RUN apt-get update && apt-get install -y\
 mariadb-server\
 gettext\
 && apt-get clean

RUN mkdir -p /var/lib/mysql

# issues met Dit kan gebeuren wanneer de vereiste map voor de socket 
# iet bestaat of niet de juiste rechten heeft.
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql

COPY tools/init.sh /init.sh
COPY tools/mariadb_init.sql /tmp/mariadb_init.sql

RUN chmod +x /init.sh

# Environment variables for MariaDB configuration
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}

# Set default starting cmd
CMD ["bash", "/init.sh"]