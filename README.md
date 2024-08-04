## Prerequisites

* Docker Desktop
* Ubuntu Linux running in WSL (windows). These operations are intended to be run from a linux shell.
* With Mac or Linux you just need Docker Desktop or the docker executable installed.

## Setup and Installation

### Before Data Import

1. Install Docker Desktop
1. Open a Linux terminal
1. Comment out the following three lines of `docker-compose.yml`
    * `./LocalSettings.php:/var/www/html/LocalSettings.php`
    * `./initialize_wikipedia.sh:/docker-entrypoint-initdb.d/initialize_wikipedia.sh`
    * `command: ["bash", "-c", "/docker-entrypoint-initdb.d/initialize_wikipedia.sh && apache2-foreground"]`
1. Run `docker-compose up --build`
1. Navigate to [http://localhost:8080/](http://localhost:8080/)
1. Complete the setup through the web UI.
1. Use the following settings in the MariaDB/SQL settings page, and click "Continue".
    > These values are configured in the `docker-compose.yml` file and can be modified in both places.
    * Database host: "db"
    * Database name (no hyphens): "mediawiki"
    * Database table prefix (no hyphens): ""
    * Database username: "mediawiki"
    * Database password: "mediawiki_password"
1. Keep "Use the same account as for installation" selected, and select "Continue"
1. Name your wikimedia instance, e.g. Wikipedia Clone
1. Complete the Administrator account section with values of your choosing. 
1. Select "I'm bored already, just install the wiki." and click "Continue"
1. Click "Continue" from the confirmation screen.
1. Click "Continue" from the Install page.
1. Store the `LocalSettings.php` file it creates right next to this file in the project root.
1. Stop the container by pressing `ctrl+c` or stopping from Docker Desktop.

### After Wikimedia Setup

1. With container stopped, uncomment the following three lines of `docker-compose.yml`
    * `./LocalSettings.php:/var/www/html/LocalSettings.php`
    * `./initialize_wikipedia.sh:/docker-entrypoint-initdb.d/initialize_wikipedia.sh`
    * `command: ["bash", "-c", "/docker-entrypoint-initdb.d/initialize_wikipedia.sh && apache2-foreground"]`
1. Run `docker-compose up --build`
1. Wait FOREVER because this can take a long time.
1. You'll know it's working because...
    * Docker Desktop will show you progress from downloading the dump file to importing articles 100 at a time.
    * Your RAM consumption by the container will shoot up.
