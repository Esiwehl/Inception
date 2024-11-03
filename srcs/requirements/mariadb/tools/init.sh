#!/bin/bash

# Start MariaDB als achtergrondproces
# waarom in safe mode? Hoe zit het met die socket?
mysqld_safe &

# Wait untill mysql is booted up in safe mode. then login
until mysqladmin ping -u root --password="${MYSQL_ROOT_PASSWORD}" --silent; do
    echo "Wachten op MariaDB-server om op te starten..."
done

# Vervang omgevingsvariabelen in het SQL-script
envsubst < /tmp/mariadb_init.sql > /tmp/mariadb_init_filled.sql

# Voer het aangepaste SQL-script uit
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /tmp/mariadb_init_filled.sql

# Sluit de MariaDB-server na initialisatie (optioneel)
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB opnieuw in de voorgrond
exec mysqld