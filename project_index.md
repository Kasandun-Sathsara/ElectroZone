# ElectroZone Project Index

## Overview
ElectroZone is a Java-based web application. It uses Maven for dependency management and is built to be deployed as a WAR file. The project utilizes Jakarta EE technologies, including JAX-RS (Jersey) for RESTful APIs, Hibernate for ORM, and JSP for the frontend presentation layer.

## Architecture

*   **Backend:** Java 11, Jakarta EE 10 (Servlets, JAX-RS), Hibernate ORM 6.4.
*   **Frontend:** JSP (JavaServer Pages), JSTL, HTML, CSS, JavaScript (with jQuery and other vendor libraries like Bootstrap).
*   **Database:** MySQL (using `mysql-connector-j`).
*   **Build Tool:** Maven (`pom.xml`, Maven Wrapper `mvnw`).

## Project Structure

### Backend Source (`src/main/java`)
*   Contains the core Java source code.
*   Includes JPA entities (Hibernate), REST controllers/resources (Jersey), service layer, and utility classes.

### Resources (`src/main/resources`)
*   Contains configuration files like `hibernate.cfg.xml` and email templates.

### Web Application (`src/main/webapp`)
*   `WEB-INF/web.xml`: The web application deployment descriptor.
*   `*.jsp`: JSP pages for the UI (e.g., `index.jsp`, `login.jsp`, `cart.jsp`, `checkout.jsp`, `admin-dashboard.jsp`).
*   `assets/`: Contains static web resources.
    *   `css/`: Stylesheets.
    *   `js/`: JavaScript files, including custom scripts (`main.js`, `cart.js`, etc.) and vendor libraries (`jquery.js`, `bootstrap.min.js`, etc.).
    *   `images/`: Image assets.

### Test Source (`src/test`)
*   `src/test/java/`: Unit tests (JUnit 5).
*   `src/test/resources/`: Test configuration resources.

## Key Dependencies
*   `jakarta.jakartaee-web-api` (v10.0.0)
*   `jersey-container-servlet-core` & `jersey-hk2` (v3.1.2) for REST APIs.
*   `hibernate-core` (v6.4.4.Final) for ORM.
*   `mysql-connector-j` (v8.3.0) for database connectivity.
*   `gson` (v2.10.1) for JSON processing.
*   `jbcrypt` for password hashing.
*   `jakarta.mail` for email services.

## Scripts & Utilities
*   `fix.py`: Python script in the root directory (purpose unknown).
*   `query.ps1`, `test_api.ps1`: PowerShell utility scripts for testing.
*   `TestDB.java`: A standalone Java class likely used for database connection testing.
