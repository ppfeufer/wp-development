# Makefile for WordPress Development

# Default goal and help message for the Makefile
.DEFAULT_GOAL := help

# Define the font styles for the help message
include .make/formatting.mk

# Variables for the WordPress CLI and the path to the WordPress installation
wp_cli := $(shell which wp-cli)
wp_path = ./../WP-Sources

# Clear all transient caches from the WordPress database
clear-transient:
	@echo "Clearing all transient caches from the WordPress database …"
	@$(wp_cli) transient delete \
		--all \
		--path=$(wp_path)

# Run pre-commit checks
pre-commit-checks:
	@echo "Running pre-commit checks …"
	@pre-commit run --all-files

# Update pre-commit configuration
pre-commit-update:
	@echo "Updating pre-commit configuration …"
	@pre-commit autoupdate

# Help message for the Makefile
help:
	@echo "$(FONT_BOLD)WordPress Development$(FONT_BOLD_END) make commands"
	@echo ""
	@echo "$(FONT_UNDERLINE)Usage:$(FONT_UNDERLINE_END)"
	@echo "  make [command]"
	@echo ""
	@echo "$(FONT_UNDERLINE)Commands:$(FONT_UNDERLINE_END)"
	@echo "  clear-transient      Clear all transient caches from the WordPress database"
	@echo "  help                 Show this help message"
	@echo "  pre-commit-checks    Run pre-commit checks"
	@echo "  pre-commit-update    Update pre-commit configuration"
	@echo ""
