# Variables for the WordPress CLI and the path to the WordPress installation
wp_cli := $(shell which wp-cli)
wp_path = ./../WP-Sources

# Check WP path
.PHONY: check-wp-path
check-wp-path:
	@if [ ! -f $(wp_path)/wp-config.php ]; then \
		echo "The WordPress installation does not exist."; \
		exit 1; \
	fi

# Clear all transient caches from the WordPress database
.PHONY: clear-transient
clear-transient: check-wp-path
	@echo "Clearing all transient caches from the WordPress database …"
	@$(wp_cli) transient delete \
		--all \
		--path=$(wp_path)

# Start the WP-CLI shell
.PHONY: wp-shell
wp-shell: check-wp-path
	@echo "Starting the WP-CLI shell …"
	@$(wp_cli) shell \
		--path=$(wp_path)

# Update WP-CLI
.PHONY: update-wp-cli
update-wp-cli:
	@echo "Updating WP-CLI …"
	@$(wp_cli) cli update

# Install WP-CLI
.PHONY: install-wp-cli
install-wp-cli:
	@echo "Installing WP-CLI …"
	@curl -o $(wp_dev_root_dir)/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	@chmod +x $(wp_dev_root_dir)/wp-cli.phar
	@sudo ln -sf $(wp_dev_root_dir)/wp-cli.phar /usr/local/bin/wp-cli

# Uninstall WP-CLI
.PHONY: uninstall-wp-cli
uninstall-wp-cli:
	@echo "Uninstalling WP-CLI …"
	@sudo rm -f /usr/local/bin/wp-cli
	@rm -f $(wp_dev_root_dir)/wp-cli.phar

# Export Database
.PHONY: export-db
export-db: check-wp-path
	@echo "Exporting the database …"
	@$(wp_cli) db export \
		--path=$(wp_path) \
		--add-drop-table

# Import Database
.PHONY: import-db
import-db: check-wp-path
	@echo "Importing the database …"
	@if [ -n "$(Arguments)" ]; then \
		if [[ -f "$(Arguments)"  && "$(Arguments)" == *.sql ]]; then \
			echo "Importing the database from $(Arguments) …"; \
			$(wp_cli) db import \
				--path=$(wp_path) \
				$(Arguments); \
			exit 0; \
		else \
			echo "The specified database file is not valid."; \
		fi \
	else \
		echo "No database file specified, trying the default database file …"; \
		$(wp_cli) db import \
			--path=$(wp_path); \
	fi

# Help message for the WP-CLI commands
.PHONY: help
help::
	@echo "  $(TEXT_UNDERLINE)WP-CLI:$(TEXT_UNDERLINE_END)"
	@echo "    clear-transient           Clear all transient caches from the WordPress database"
	@echo "    export-db                 Export the database"
	@echo "    import-db                 Import the database"
	@echo "    install-wp-cli            Install WP-CLI"
	@echo "    uninstall-wp-cli          Uninstall WP-CLI"
	@echo "    update-wp-cli             Update WP-CLI"
	@echo "    wp-shell                  Start the WP-CLI shell"
	@echo ""
