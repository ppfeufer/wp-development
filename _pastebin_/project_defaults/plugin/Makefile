# Makefile for the WordPress Plugin

# Default goal and help message for the Makefile
.DEFAULT_GOAL := help

# Plugin name and slug
plugin_name = Plugin Name
plugin_slug = plugin-slug
plugin_file = PluginFile.php
plugin_translation_template = l10n/$(plugin_slug).pot

# Git repository URLs
plugin_repo_url = https://github.com/ppfeufer/${plugin_slug}
plugin_issues_url = $(plugin_repo_url)/issues

# Help message for the Makefile
.PHONY: help
help::
	@echo "$(TEXT_BOLD)$(plugin_name)$(TEXT_BOLD_END) Makefile"
	@echo ""
	@echo "$(TEXT_BOLD)Usage:$(TEXT_BOLD_END)"
	@echo "  make [command]"
	@echo ""
	@echo "$(TEXT_BOLD)Commands:$(TEXT_BOLD_END)"

# Include the configurations
include .make/conf.d/*.mk
