# WP Development<a name="wp-development"></a>

This is a setup for WordPress development using Git repositories for plugins and themes.

______________________________________________________________________

<!-- mdformat-toc start --slug=github --maxlevel=6 --minlevel=1 -->

- [WP Development](#wp-development)
  - [Requirements](#requirements)
    - [IDE](#ide)
    - [Software](#software)
  - [Folder Structure](#folder-structure)
    - [Soft Links](#soft-links)

<!-- mdformat-toc end -->

______________________________________________________________________

## Requirements<a name="requirements"></a>

### IDE<a name="ide"></a>

- PhpStorm

This setup is optimized for PhpStorm.
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
