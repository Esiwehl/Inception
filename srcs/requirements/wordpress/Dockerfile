# Basis image
FROM debian:bullseye

# Werkdirectory instellen
WORKDIR /var/www/html

# Update en installeer benodigde pakketten
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    wget \
    unzip \
    && apt-get clean

# Download WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xvzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

# Download en installeer WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
    
# Zorg ervoor dat de juiste permissies zijn ingesteld
RUN mkdir -p /run/php &&\ 
    chown -R www-data:www-data /var/www/html /run/php && \
    chmod -R 755 /var/www/html /run/php

# Kopieer aangepaste configuratiebestanden
COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh

# Maak het script uitvoerbaar
RUN chmod +x /usr/local/bin/entrypoint.sh

# Stel het script in als entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]


# Zorg dat php-fpm wordt uitgevoerd
CMD ["php-fpm7.4", "--nodaemonize"]
