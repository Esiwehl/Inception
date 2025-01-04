# **Inception Of Things**

## **Project Overview**
This is an introduction to containerization and Docker. The goal is to build a secure, scalable, and modular Docker-based infrastructure to deploy a WordPress site, complete with a MariaDB database and served through an NGINX web server.

The project adheres to best practices for containerization, including isolated services, volume persistence, and secure communication using TLS. By the end of this project, you'll have a fully functional WordPress deployment running in Docker containers, accessible via a custom domain.

---

## **Key Features**
1. **NGINX (Reverse Proxy):**
   - Serves as the entry point to the infrastructure.
   - Configured to support **TLSv1.2** and **TLSv1.3**, ensuring secure HTTPS communication.
   - Acts as a load balancer and handles HTTP/HTTPS traffic to WordPress.

2. **WordPress (PHP-FPM):**
   - Runs the WordPress application using PHP-FPM.
   - Automatically installs and configures WordPress upon deployment.
   - Fully isolated from the web server (NGINX).

3. **MariaDB (Database):**
   - Provides persistent storage for WordPress data.
   - Configured with robust authentication and isolated from external access.

4. **Volumes and Persistence:**
   - **WordPress Files**: Stored on the host for persistence (`/home/<user>/data/wordpress`).
   - **Database Files**: Stored on the host for persistence (`/home/<user>/data/mariadb`).

5. **Custom Docker Network:**
   - All containers are connected via a private Docker bridge network for secure and efficient communication.

6. **Security Best Practices:**
   - No hardcoded credentials in the codebase.
   - Environment variables stored securely in a `.env` file.
   - Admin user does not use "admin" as a username.

---

## **How It Works**
1. **Build and Deployment:**
   - All services (NGINX, WordPress, MariaDB) are containerized and built from Dockerfiles.
   - `docker-compose.yml` manages multi-container orchestration.

2. **Automated Configuration:**
   - WordPress is pre-configured with an admin user and database connection during the container startup process.
   - NGINX handles all incoming traffic over HTTPS and routes requests to the appropriate service.

3. **Custom Domain:**
   - The site is accessible via a custom domain (`<user>.42.fr`) with SSL encryption.

---

## **Project Requirements**
- **Services:**
  - **NGINX:** Acts as the reverse proxy and serves static files.
  - **WordPress:** Manages dynamic content and connects to MariaDB.
  - **MariaDB:** Stores all WordPress data, including posts and user accounts.

- **Volumes:**
  - Database and WordPress files are stored persistently on the host machine.

- **TLS Security:**
  - Only TLSv1.2 and TLSv1.3 are supported for HTTPS.

- **Custom Domain:**
  - The domain `<user>.42.fr` is used for accessing the WordPress site.

--