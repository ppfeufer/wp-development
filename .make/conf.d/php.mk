# Variables for the PHP tooling and the path to the WordPress installation
composer := $(shell which composer)
phpcs := $(shell which phpcs)
phpcbf := $(shell which phpcbf)

# Install composer
.PHONY: install-composer
install-composer:
	@echo "Installing Composer …"
	@curl -sS https://getcomposer.org/installer | php -- --install-dir=$(wp_dev_root_dir) --quiet
	@sudo ln -sf $(wp_dev_root_dir)/composer.phar /usr/local/bin/composer

# Uninstall composer
.PHONY: uninstall-composer
uninstall-composer:
	@echo "Uninstalling Composer …"
	@sudo rm -f /usr/local/bin/composer
	@rm -f $(wp_dev_root_dir)/composer.phar

# Update composer
.PHONY: update-composer
update-composer:
	@echo "Updating Composer …"
	@$(composer) self-update

# Install PHP Codesniffer
.PHONY: install-phpcs
install-phpcs:
	@echo "Installing PHP Codesniffer …"
	@curl -o $(wp_dev_root_dir)/phpcs.phar https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar
	@curl -o $(wp_dev_root_dir)/phpcbf.phar https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar
	@chmod +x $(wp_dev_root_dir)/phpcs.phar
	@chmod +x $(wp_dev_root_dir)/phpcbf.phar
	@sudo ln -sf $(wp_dev_root_dir)/phpcs.phar /usr/local/bin/phpcs
	@sudo ln -sf $(wp_dev_root_dir)/phpcbf.phar /usr/local/bin/phpcbf

# Uninstall PHP Codesniffer
.PHONY: uninstall-phpcs
uninstall-phpcs:
	@echo "Uninstalling PHP Codesniffer …"
	@sudo rm -f /usr/local/bin/phpcs
	@sudo rm -f /usr/local/bin/phpcbf
	@rm -f $(wp_dev_root_dir)/phpcs.phar
	@rm -f $(wp_dev_root_dir)/phpcbf.phar

# Update PHP Codesniffer
.PHONY: update-phpcs
update-phpcs: uninstall-phpcs install-phpcs

# Help message for the WP-CLI commands
.PHONY: help
help::
	@echo "  $(TEXT_UNDERLINE)PHP (Composer):$(TEXT_UNDERLINE_END)"
	@echo "    install-composer          Install Composer"
	@echo "    uninstall-composer        Uninstall Composer"
	@echo "    update-composer           Update Composer"
	@echo ""
	@echo "  $(TEXT_UNDERLINE)PHP (PHP Codesniffer):$(TEXT_UNDERLINE_END)"
	@echo "    install-phpcs             Install PHP Codesniffer"
	@echo "    uninstall-phpcs           Uninstall PHP Codesniffer"
	@echo "    update-phpcs              Update PHP Codesniffer"
	@echo ""
