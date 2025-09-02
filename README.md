# WP Development<a name="wp-development"></a>

This is a setup for WordPress development using Git repositories for plugins and themes.

______________________________________________________________________

<!-- mdformat-toc start --slug=github --maxlevel=6 --minlevel=2 -->

- [Requirements](#requirements)
  - [Folder Structure](#folder-structure)
    - [Soft Links](#soft-links)
  - [Software](#software)
    - [Install Apache2](#install-apache2)
      - [Apache Configuration](#apache-configuration)
    - [Install PHP](#install-php)
    - [Install MariaDB](#install-mariadb)
    - [Install Git](#install-git)
    - [Install Composer](#install-composer)
    - [Install PHP Code Sniffer](#install-php-code-sniffer)
    - [Install WP-CLI](#install-wp-cli)
  - [PhpStorm](#phpstorm)
    - [Settings to Double-Check](#settings-to-double-check)
      - [Composer](#composer)
      - [PHP Code Sniffer](#php-code-sniffer)
      - [File Watchers (Optional)](#file-watchers-optional)
- [Makefile](#makefile)
  - [Clear Transient Caches](#clear-transient-caches)
  - [Install pre-commit Hook](#install-pre-commit-hook)
  - [Run pre-commit Checks](#run-pre-commit-checks)
  - [Update pre-commit Configuration](#update-pre-commit-configuration)
  - [Install WP-CLI](#install-wp-cli-1)
  - [Update WP-CLI](#update-wp-cli)

<!-- mdformat-toc end -->

______________________________________________________________________

> [!NOTE]
>
> This setup is optimized for Linux, with the shell commands to install packages
> targeted at Debian- or Ubuntu-based distributions.
> If you use a different distribution, you might have to adjust the commands
> and/or package names.
>
> If you use a different operating system, you might have to make some adjustments.\
> If you use Windows, you can use the Windows Subsystem for Linux (WSL) to run this setup.
> You can find more information about WSL [here](https://docs.microsoft.com/en-us/windows/wsl/).
>
> It is suggested to fork this repository and adjust the setup to your needs.
> This way, you can keep your setup in sync with your repository.
> You can find more information about forking a repository [here](https://docs.github.com/en/get-started/quickstart/fork-a-repo).

## Requirements<a name="requirements"></a>

### Folder Structure<a name="folder-structure"></a>

This setup expects the following folder structure:

```text
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

#### Soft Links<a name="soft-links"></a>

Now we have to create a couple of soft links to make this work.

First, we need to link the `plugins` and `themes` from the repositories to the
WordPress sources.

```shell
# First move the plugins and themes folders to the repositories
mv ~/Development/WordPress/WP-Sources/wp-content/plugins/ ~/Development/WordPress/Repositories/wp-content/
mv ~/Development/WordPress/WP-Sources/wp-content/themes/ ~/Development/WordPress/Repositories/wp-content/

# Now create the soft links
ln -s ~/Development/WordPress/Repositories/wp-content/plugins/ ~/Development/WordPress/WP-Sources/wp-content/plugins
ln -s ~/Development/WordPress/Repositories/wp-content/themes/ ~/Development/WordPress/WP-Sources/wp-content/themes
```

Then we need to link the `wp-content` folder from the repositories to
the `WP-Development` folder.

```shell
ln -s ~/Development/WordPress/Repositories/wp-content/ ~/Development/WordPress/WP-Development/wp-content
```

### Software<a name="software"></a>

This setup requires the following software installed on your machine:

- Apache2
- Composer
- Git
- MariaDB 10.11 or newer
- PHP 8.2 or newer
- PHP Code Sniffer
- WP-CLI

#### Install Apache2<a name="install-apache2"></a>

To install Apache2, run the following command:

```shell
sudo apt install apache2
```

Now enable the required Apache modules:

```shell
sudo a2enmod rewrite
sudo a2enmod vhost_alias
```

##### Apache Configuration<a name="apache-configuration"></a>

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

```text
127.0.0.1    wp-development.local
```

Now restart Apache.

```shell
sudo systemctl restart apache2.service
```

#### Install PHP<a name="install-php"></a>

To install PHP, run the following command:

```shell
sudo apt install php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php-zip php-gd php-imagick php-intl php-xmlrpc
```

Now restart Apache.

```shell
sudo systemctl restart apache2.service
```

#### Install MariaDB<a name="install-mariadb"></a>

To install MariaDB, run the following command:

```shell
sudo apt install mariadb-server
```

Now secure the MariaDB installation.

```shell
sudo mysql_secure_installation
```

Now restart MariaDB.

```shell
sudo systemctl restart mariadb.service
```

#### Install Git<a name="install-git"></a>

To install Git, run the following command:

```shell
sudo apt install git
```

#### Install Composer<a name="install-composer"></a>

Composer might be needed for some plugins or themes.
Not all distributions come with Composer pre-installed,
so you might have to install it yourself.

To install Composer, run the following command from the `~/Development/WordPress/WP-Development` folder.

```shell
make install-composer
```

This will download the Composer phar file and make it executable and create a
symlink to the `/usr/local/bin` folder as `composer`.

#### Install PHP Code Sniffer<a name="install-php-code-sniffer"></a>

PHP Code Sniffer is a tool to help you write clean code. It checks your code against a set of coding standards.

To install PHP Code Sniffer, run the following command from the `~/Development/WordPress/WP-Development` folder.

```shell
make install-phpcs
```

This will install PHP Code Sniffer globally and make it available as a global command under `/usr/local/bin/phpcs`.

#### Install WP-CLI<a name="install-wp-cli"></a>

WP-CLI is a command-line interface for WordPress. It allows you to do many tasks
without using the WordPress admin interface.

To install WP-CLI, run the following command from the `~/Development/WordPress/WP-Development` folder.

```shell
make install-wp-cli
```

This will download the WP-CLI phar file and make it executable and create a
symlink to the `/usr/local/bin` folder as `wp-cli`.

### PhpStorm<a name="phpstorm"></a>

This setup is optimized for JetBrains [PhpStorm](https://www.jetbrains.com/phpstorm/).
If you use another IDE, you might have to adjust the setup a bit.

> [!NOTE]
>
> The IDE settings are stored in the `.idea` folder in `~/Development/WordPress/WP-Development`.
>
> Due to the nature of PhpStorm, you might have to adjust the settings to your needs when
> forking this repository.
> Not all settings accept a relative path (e.g., `~/Development/WordPress/WP-Development`),
> so there is a good change some of them containing the absolute path to my home folder.
>
> You can find more information about PhpStorm settings [here](https://www.jetbrains.com/help/phpstorm/settings-preferences-dialog.html).

#### Settings to Double-Check<a name="settings-to-double-check"></a>

> [!NOTE]
>
> Some settings need node modules to be installed.\
> For this setup, the node modules are assumed to be installed in
> the `~/Development/node_modules/` folder.

##### Composer<a name="composer"></a>

See how to install composer [here](#install-composer).

- **Settings > PHP > Composer**
  - **Composer executable**: `/usr/local/bin/composer`
  - **Path to composer.json**: Leave empty

##### PHP Code Sniffer<a name="php-code-sniffer"></a>

See how to install PHP Code Sniffer [here](#install-php-code-sniffer).

- **Settings > PHP > Quality Tools > PHP Code Sniffer**
  - **PHP Code Sniffer (phpcs) path**: `/usr/local/bin/phpcs`
  - **PHP Code Beautifier and Fixer (phpcbf) path**: `/usr/local/bin/phpcbf`
  - **Coding standard**: `Custom`
  - **Configuration file**: `~/Development/WordPress/WP-Development/phpcs.xml`

##### File Watchers (Optional)<a name="file-watchers-optional"></a>

The file watchers are completely optional.
They are used to minify and optimize CSS and JavaScript files.

To use them, you need to have the following node modules installed:

- [csso-cli](https://www.npmjs.com/package/csso-cli)
- [terser](https://www.npmjs.com/package/terser)
- [sass](https://www.npmjs.com/package/sass)

For simplicities’ sake, it is assumed that node modules are installed in the `~/Development/node_modules/` folder.
You can install them by running the following command from the `~/Development` folder.

```shell
npm install csso-cli terser sass
```

To configure the file watchers, go to:

- **Settings > Tools > File Watchers**
  - **CSSO CSS Optimizer**
    - **Program**: `/home/your_user/Development/node_modules/csso-cli/bin/csso`
    - **File type**: `Cascade Style Sheets`
    - **Scope**: `Project Files`
    - **Arguments**: `-i $FileName$ -o $FileNameWithoutExtension$.min.css -s file`
    - **Output paths**: `$FileNameWithoutExtension$.min.css`
    - **Working directory**: `$FileDir$`
    - **Advanced options**: Nothing selected
  - **Terser**
    - **Program**: `/home/your_user/Development/node_modules/terser/bin/terser`
    - **File type**: `JavaScript`
    - **Scope**: `Project Files`
    - **Arguments**: `$FileName$ -o $FileNameWithoutExtension$.min.js --source-map "url='$FileNameWithoutExtension$.min.js.map'" --compress reduce_vars=false --mangle --format quote_style=1`
    - **Output paths**: `$FileNameWithoutExtension$.min.js`
    - **Working directory**: `$FileDir$`
    - **Advanced options**: Nothing selected
  - **SCSS**
    - **Program**: `/home/your_user/Development/node_modules/sass/sass.js`
    - **File type**: `SCSS Style Sheets`
    - **Scope**: `Project Files`
    - **Arguments**: `--style=compressed $FileName$:../assets/css/$FileNameWithoutExtension$.css`
    - **Output paths**: `$FileNameWithoutExtension$.css:$FileNameWithoutExtension$.css.map`
    - **Working directory**: `$FileDir$`
    - **Advanced options**: Nothing selected

## Makefile<a name="makefile"></a>

The Makefile contains a couple of useful commands.

All commands are run from the `~/Development/WordPress/WP-Development` folder.

### Clear Transient Caches<a name="clear-transient-caches"></a>

This will clear WordPress transient caches, which can be useful when developing.

```shell
make clear-transients
```

### Install pre-commit Hook<a name="install-pre-commit-hook"></a>

This will install the pre-commit hook for the project.

```shell
make pre-commit-install
```

### Run pre-commit Checks<a name="run-pre-commit-checks"></a>

This will run the pre-commit checks.

```shell
make pre-commit-checks
```

### Update pre-commit Configuration<a name="update-pre-commit-configuration"></a>

This will update the pre-commit configuration.

```shell
make update-pre-commit
```

### Install WP-CLI<a name="install-wp-cli-1"></a>

This will install WP-CLI and make it available as a global command under `/usr/local/bin/wp-cli`.

```shell
make install-wp-cli
```

### Update WP-CLI<a name="update-wp-cli"></a>

This will update WP-CLI to the latest version.

```shell
make update-wp-cli
```
