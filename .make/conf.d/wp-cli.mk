# Variables for the WordPress CLI and the path to the WordPress installation
wp_cli := $(shell which wp-cli)
wp_path = ./../WP-Sources

# Clear all transient caches from the WordPress database
.PHONY: clear-transient
clear-transient:
	@echo "Clearing all transient caches from the WordPress database …"
	@$(wp_cli) transient delete \
		--all \
		--path=$(wp_path)

# Start the WP-CLI shell
.PHONY: wp-shell
wp-shell:
	@echo "Starting the WP-CLI shell …"
	@$(wp_cli) shell \
		--path=$(wp_path)

# Update WP-CLI
.PHONY: wp-cli-update
wp-cli-update:
	@echo "Updating WP-CLI …"
	@$(wp_cli) cli update

# Install WP-CLI
.PHONY: wp-cli-install
wp-cli-install:
	@echo "Installing WP-CLI …"
	@curl -o $(wp_dev_root_dir)/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	@chmod +x $(wp_dev_root_dir)/wp-cli.phar
	@sudo ln -sf $(wp_dev_root_dir)/wp-cli.phar /usr/local/bin/wp-cli

# Help message for the WP-CLI commands
.PHONY: help
help::
	@echo "  $(TEXT_UNDERLINE)WP-CLI:$(TEXT_UNDERLINE_END)"
	@echo "    clear-transient           Clear all transient caches from the WordPress database"
	@echo "    wp-cli-install            Install WP-CLI"
	@echo "    wp-cli-update             Update WP-CLI"
	@echo "    wp-shell                  Start the WP-CLI shell"
	@echo ""
