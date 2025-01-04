#!/bin/bash

# Vul wp-config.php met de omgevingsvariabelen
sed -i "s/username_here/${WORDPRESS_DB_USER}/g" wp-config-sample.php
sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" wp-config-sample.php
sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" wp-config-sample.php
sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" wp-config-sample.php

# Dit is super duper belangrijk, anders kan je nginx niet met php communiceren.
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/g' /etc/php/7.4/fpm/pool.d/www.conf

cp wp-config-sample.php wp-config.php

if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Installeer WordPress..."
    wp core install \
        --url="https://ewehl.42.fr" \
        --title="Mijn WordPress Site" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --path=/var/www/html \
        --allow-root
fi

if ! wp user get $REGULAR_USER --path=/var/www/html --allow-root > /dev/null 2>&1; then
    echo "Voeg een tweede gebruiker toe..."
    wp user create $REGULAR_USER $REGULAR_EMAIL \
        --role=editor \
        --user_pass="$REGULAR_PASSWORD" \
        --path=/var/www/html \
        --allow-root
fi

exec "$@"