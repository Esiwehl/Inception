#is this allowed?
FROM wordpress:latest

WORKDIR /var/wwww/html

# Optioneel: Kopieer eventuele configuratiebestanden naar de container
# Bijvoorbeeld: COPY conf/wp-config.php /var/www/html/wp-config.php

# Kopieer WordPress-bestanden expliciet vanuit de standaardlocatie in het WordPress-image
RUN cp -r /usr/src/wordpress/* /var/www/html/

# Zorg ervoor dat de juiste permissies zijn ingesteld
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Stel omgevingsvariabelen in voor de databaseverbinding
ENV WORDPRESS_DB_HOST=mariadb:3306
ENV WORDPRESS_DB_NAME=${MYSQL_DATABASE}
ENV WORDPRESS_DB_USER=${MYSQL_USER}
ENV WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}


Om ervoor te zorgen dat WordPress consistent en correct wordt geïnstalleerd bij het opstarten van de container, kun je enkele aanpassingen aan je Dockerfile en configuratie toevoegen om te voorkomen dat je handmatig een schone installatie hoeft te doen. Hier zijn enkele belangrijke stappen en configuraties die je kunt opnemen:

1. Kopieer WordPress-bestanden Expliciet tijdens de Build
In plaats van te vertrouwen op de standaard WordPress Docker-image om de bestanden automatisch te kopiëren, kun je expliciet de WordPress-bestanden kopiëren naar de juiste map tijdens de build. Dit zorgt ervoor dat je altijd een volledige en schone set WordPress-bestanden hebt in /var/www/html.

Dockerfile voor WordPress:

Dockerfile
Copy code
# Gebruik een officiële WordPress image als basis
FROM wordpress:latest

# Stel de werkdirectory in
WORKDIR /var/www/html

# Kopieer WordPress-bestanden expliciet vanuit de standaardlocatie in het WordPress-image
RUN cp -r /usr/src/wordpress/* /var/www/html/

# Zorg ervoor dat de juiste permissies zijn ingesteld
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

# Optioneel: Stel omgevingsvariabelen in voor de databaseverbinding
ENV WORDPRESS_DB_HOST=mariadb:3306
ENV WORDPRESS_DB_NAME=${MYSQL_DATABASE}
ENV WORDPRESS_DB_USER=${MYSQL_USER}
ENV WORDPRESS_DB_PASSWORD=${MYSQL_PASSWORD}

# Het standaard startcommando voor WordPress
CMD ["apache2-foreground"]
