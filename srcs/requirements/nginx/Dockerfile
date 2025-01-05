# Base image
FROM debian:bullseye

# Install NGINX and OpenSSL for TLS/SSL
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && apt-get clean && \
    mkdir -p /etc/nginx/ssl /var/log/nginx

RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html
# Copy configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
# COPY tools/index.html /usr/share/nginx/html

# Generate SSL certificates
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/key.pem -out /etc/nginx/ssl/cert.pem \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Department/CN=$DOMAIN_NAME"

# Expose port 443 for HTTPS
EXPOSE 443

# Start NGINX as the default process
CMD ["nginx", "-g", "daemon off;"]
