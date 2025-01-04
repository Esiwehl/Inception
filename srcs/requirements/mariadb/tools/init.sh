#!/bin/bash

# Start MariaDB als achtergrondproces
mysqld_safe &

# Wachten tot MariaDB volledig is opgestart
echo "Wachten op MariaDB-server om op te starten..."
timeout=45 # Maximaal 45 seconden wachten
elapsed=0

while ! mysqladmin ping -h localhost --silent; do
    if [ $elapsed -ge $timeout ]; then
        echo "Fout: MariaDB-server start niet binnen $timeout seconden."
        exit 1
    fi
    elapsed=$((elapsed + 1))
done

echo "MariaDB-server is actief!"

# Vervang omgevingsvariabelen in het SQL-script
envsubst < /tmp/mariadb_init.sql > /tmp/mariadb_init_filled.sql

# Voer het aangepaste SQL-script uit
echo "Voer initialisatie-SQL-script uit..."
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /tmp/mariadb_init_filled.sql

# Sluit de MariaDB-server na initialisatie (optioneel)
echo "Initialisatie voltooid, MariaDB afsluiten..."
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Start MariaDB opnieuw in de voorgrond
echo "MariaDB starten in voorgrondmodus..."
exec mysqld
