# Variables for the PHP tooling and the path to the WordPress installation
composer := $(shell which composer)

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
	@composer self-update

# Help message for the WP-CLI commands
.PHONY: help
help::
	@echo "  $(TEXT_UNDERLINE)PHP (Composer):$(TEXT_UNDERLINE_END)"
	@echo "    install-composer          Install Composer"
	@echo "    uninstall-composer        Uninstall Composer"
	@echo "    update-composer           Update Composer"
	@echo ""
