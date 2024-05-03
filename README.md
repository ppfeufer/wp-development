# WP Development<a name="wp-development"></a>

This is a setup for WordPress development using Git repositories for plugins and themes.

______________________________________________________________________

<!-- mdformat-toc start --slug=github --maxlevel=6 --minlevel=1 -->

- [WP Development](#wp-development)
  - [Requirements](#requirements)
    - [IDE](#ide)
      - [PhpStorm](#phpstorm)
    - [Software](#software)
  - [Folder Structure](#folder-structure)
    - [Soft Links](#soft-links)
  - [Apache Configuration](#apache-configuration)
  - [WP-Cli](#wp-cli)
  - [Makefile](#makefile)
    - [Clear transient caches](#clear-transient-caches)
    - [Run pre-commit checks](#run-pre-commit-checks)

<!-- mdformat-toc end -->

______________________________________________________________________

## Requirements<a name="requirements"></a>

### IDE<a name="ide"></a>

#### PhpStorm<a name="phpstorm"></a>

This setup is optimized for JetBrains [PhpStorm](https://www.jetbrains.com/phpstorm/).
If you use another IDE, you might have to adjust the setup a bit.

### Software<a name="software"></a>

- Apache2
- MariaDB 10.11 or newer
- PHP 8.2 or newer

## Folder Structure<a name="folder-structure"></a>

This setup expects the following folder structure:

```
~/Development/
│-- WordPress/
│   │-- Repositories/ # «-- This is where the plugin and theme Git repositories are located
│   │   │-- wp-content/
│   │   │   │-- plugins/ # «-- This is where the plugins are located
│   │   │   │-- themes/ # «-- This is where the themes are located
│   │-- WP-Development/ # «-- This git repository and the project root folder
│   │   │-- wp-content/ # «-- This is a soft link to the `wp-content` folder in the Repositories folder
│   │-- WP-Sources/ # «-- This is where the WordPress sources are located and where we will run our WordPress instance (Apache vhost configuration points to this folder)
│   │   │-- …
│   │   │-- wp-content/
│   │   │   │-- plugins/ # «-- This is a soft link to the `plugins` folder in the Repositories folder
│   │   │   │-- themes/ # «-- This is a soft link to the `themes` folder in the Repositories folder
│   │   │-- …
```

### Soft Links<a name="soft-links"></a>

Now we have to create a couple of soft links to make this work.

First, we need to link the `plugins` and `themes` from the repositories to the
WordPress sources.

```bash
# First move the plugins and themes folders to the repositories
mv ~/Development/WordPress/WP-Sources/wp-content/plugins/ ~/Development/WordPress/Repositories/wp-content/
mv ~/Development/WordPress/WP-Sources/wp-content/themes/ ~/Development/WordPress/Repositories/wp-content/

# Now create the soft links
ln -s ~/Development/WordPress/Repositories/wp-content/plugins/ ~/Development/WordPress/WP-Sources/wp-content/plugins
ln -s ~/Development/WordPress/Repositories/wp-content/themes/ ~/Development/WordPress/WP-Sources/wp-content/themes
```

Then we need to link the `wp-content` folder from the repositories to
the `WP-Development` folder.

```bash
ln -s ~/Development/WordPress/Repositories/wp-content/ ~/Development/WordPress/WP-Development/wp-content
```

## Apache Configuration<a name="apache-configuration"></a>

The Apache configuration for the WordPress instance should look like this:

```apache
<VirtualHost *:80>
    ServerName wp-development.local
    DocumentRoot "/home/username/Development/WordPress/WP-Sources"

    SetEnv APPLICATION_ENV "development"

    ErrorLog ${APACHE_LOG_DIR}/wp-development-error.log
    CustomLog ${APACHE_LOG_DIR}/wp-development-access.log combined

    <Directory "/home/username/Development/WordPress/WP-Sources">
        Options FollowSymLinks
        DirectoryIndex index.php
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
```

Remember to add the domain to your `/etc/hosts` file.

```bash
127.0.0.1    wp-development.local
```

Now restart Apache.

```bash
sudo systemctl restart apache2.service
```

## WP-Cli<a name="wp-cli"></a>

To make the setup complete, we need to install WP-CLI.

Run the following commands from the `Development/WordPress` folder.

```bash
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo ln -s wp-cli.phar /usr/local/bin/wp-cli
```

## Makefile<a name="makefile"></a>

The Makefile contains a couple of useful commands.

All commands are run from the `WP-Development` folder.

### Clear transient caches<a name="clear-transient-caches"></a>

```bash
make clear-transients
```

### Run pre-commit checks<a name="run-pre-commit-checks"></a>

```bash
make pre-commit-checks
```
