# Variables for the WordPress CLI and the path to the WordPress installation
wp_cli := $(shell which wp-cli)
wp_path = ./../WP-Sources

# Clear all transient caches from the WordPress database
.PHONY: wp-cli-clear-transient
wp-cli-clear-transient:
	@echo "Clearing all transient caches from the WordPress database …"
	@$(wp_cli) transient delete \
		--all \
		--path=$(wp_path)

# Start the WP-CLI shell
.PHONY: wp-cli-shell
wp-cli-shell:
	@echo "Starting the WP-CLI shell …"
	@$(wp_cli) shell \
		--path=$(wp_path)

# Update WP-CLI
.PHONY: wp-cli-update
wp-cli-update:
	@echo "Updating WP-CLI …"
	@$(wp_cli) cli update

# Help message for the WP-CLI commands
.PHONY: help
help::
	@echo "  $(TEXT_UNDERLINE)WP-CLI:$(TEXT_UNDERLINE_END)"
	@echo "    wp-cli-clear-transient    Clear all transient caches from the WordPress database"
	@echo "    wp-cli-shell              Start the WP-CLI shell"
	@echo "    wp-cli-update             Update WP-CLI"
	@echo ""
