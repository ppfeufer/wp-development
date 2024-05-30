# Makefile for WordPress Development

# Default goal and help message for the Makefile
.DEFAULT_GOAL := help

# Global variables
wp_dev_root_dir := $(shell dirname $(shell cd -P -- '$(shell dirname -- "$0")' && pwd -P)) # The root directory of the WordPress development environment (e.g., ~/Development/WordPress)

# Help message for the Makefile
.PHONY: help
help::
	@echo "$(TEXT_BOLD)WordPress Development$(TEXT_BOLD_END) make commands"
	@echo ""
	@echo "$(TEXT_BOLD)Usage:$(TEXT_BOLD_END)"
	@echo "  make [command]"
	@echo ""
	@echo "$(TEXT_BOLD)Commands:$(TEXT_BOLD_END)"
	@echo "  $(TEXT_UNDERLINE)General:$(TEXT_UNDERLINE_END)"
	@echo "    help                      Show this help message"
	@echo ""

# Include the configurations
include .make/conf.d/*.mk
