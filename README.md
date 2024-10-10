# React + PHP Boilerplate with Vite and Docker

This boilerplate is designed specifically for developing React.js applications with a PHP API backend **(not for PHP template rendering)** in a modern environment using [Vite](https://vite.dev/) and [Docker](https://www.docker.com/). It simplifies running both React and PHP APIs on local machines with just a couple of steps.

# Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Getting Started](#getting-started)
  - [Initial Setup (First Time Only)](#initial-setup--first-time-only-)
  - [Starting the App (Subsequent Runs)](#starting-the-app--subsequent-runs-)
  - [Stopping the App](#stopping-the-app)
- [Deployment](#deployment)
  - [FTP Setup Notes](#ftp-setup-notes)
  - [.htaccess Configuration](#htaccess-configuration)
  - [Production Folder Structure](#production-folder-structure)
- [Notes](#notes)
- [Contributing](#contributing)

## Features

- **Vite and Docker-based Development:** Vite provides a fast, optimized build process, and Docker ensures easy local development.
- **Hot Module Reload (HMR):** Thanks to Vite, the React app supports HMR, though logs won't be printed in the terminal as Vite runs in the background in this setup.
- **Port Configuration:**
  - React app runs on **port 80** (default HTTP port).
  - PHP app runs on **port 81**.
  - This allows you to work on both React and PHP simultaneously in your local environment.
- **PHP as API Backend:** PHP is used only for developing APIs and **not for rendering PHP templates.**

## Requirements

Before starting, ensure you have the following installed:

- Docker & Docker Compose
- Node.js
- Bash (for running shell scripts)

## Getting Started

### Initial Setup (First Time Only)

To start the application for the first time:

1. Clone the repository.
2. Navigate to the project folder:

```sh
   cd react-php-docker-boilerplate
```

3. Run the startup script with the -build flag to install dependencies and start the app:

```sh
   ./start.sh -build
```

This will install necessary Node modules, Vite, and then start the app.
Visit [localhost](localhost) from your browser to see your app running.

### Starting the App (Subsequent Runs)

For subsequent runs, you can start the app without rebuilding:

```sh
./start.sh
```

### Stopping the App

To stop the running app:

```sh
./stop.sh
```

## Deployment

A basic FTP deployment script is included, but this method is not recommended for production environments using Docker. Ensure you configure the following variables in the ./deploy.sh script with your server and FTP credentials:

```
REMOTE_USER="username@domain.com"
REMOTE_HOST="host"
REMOTE_PORT="21" (default FTP port)
REMOTE_PATH="/" (path on the FTP server)
PASSWORD="password"
```

### FTP Setup Notes

- Your domain's **root directory** should be set to **/yourdomain.com/app**.
- Your FTP user must have access to /yourdomain.com for deployment.
- Ensure your FTP server is properly configured to handle the app deployment.

### .htaccess Configuration

Add the following .htaccess file to serve the React app on production, ensuring all requests are routed to index.html:

```
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteCond %{REQUEST_FILENAME} !-l
  RewriteRule . /index.html [L]
</IfModule>
```

### Production Folder Structure

`dist/` folder: Contains your React app (production build).
`api/` folder: Contains your PHP code for handling API requests.

## Notes

- This boilerplate is optimized for local development and testing, **not production**.
- The deployment script uses FTP, which is suitable for simple setups but may not be ideal for more complex environments.
- Be sure to review and customize the configuration to fit your needs.

## Contributing

Feel free to open issues or submit pull requests to improve the template or add features.
