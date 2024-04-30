# Makefile for WordPress Development

# Default goal and help message for the Makefile
.DEFAULT_GOAL := help

# Variables for the WordPress CLI and the path to the WordPress installation
#wp_cli = /usr/local/bin/wp-cli
wp_cli := $(shell which wp-cli)
wp_path = ./../WP-Sources

# Clear all transient caches from the WordPress database
clear-transient:
	@echo "Clearing all transient caches from the WordPress database …"

	@$(wp_cli) transient delete \
		--all \
		--path=$(wp_path)

# Help message for the Makefile
help:
	@echo "WordPress Development Makefile"
	@echo ""
	@echo "Usage: make [command]"
	@echo ""
	@echo "Commands:"
	@echo "  clear-transient  Clear all transients from the WordPress database"
	@echo ""
