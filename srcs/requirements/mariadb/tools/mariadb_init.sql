-- CREATE DATABASE IF NOT EXISTS debug_db; 
-- ^ This was for testing purposes, I couldn't even find the script initially.
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Creating admin with ALL priviliges, not just white.
CREATE USER IF NOT EXISTS '${ADMIN_USER}'@'%' IDENTIFIED BY '${ADMIN_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${ADMIN_USER}'@'%';

-- Maak de reguliere gebruiker aan met beperkte rechten
CREATE USER IF NOT EXISTS '${REGULAR_USER}'@'%' IDENTIFIED BY '${REGULAR_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${MYSQL_DATABASE}.* TO '${REGULAR_USER}'@'%';

-- Laad de privileges opnieuw in
FLUSH PRIVILEGES;
