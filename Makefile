# Makefile for WordPress Development

# Default goal and help message for the Makefile
.DEFAULT_GOAL := help

# Help message for the Makefile
.PHONY: help
help::
	@echo "$(FONT_BOLD)WordPress Development$(FONT_BOLD_END) make commands"
	@echo ""
	@echo "$(FONT_BOLD)Usage:$(FONT_BOLD_END)"
	@echo "  make [command]"
	@echo ""
	@echo "$(FONT_BOLD)Commands:$(FONT_BOLD_END)"
	@echo "  $(FONT_UNDERLINE)General:$(FONT_UNDERLINE_END)"
	@echo "    help                      Show this help message"
	@echo ""

# Include the configurations
include .make/conf.d/*.mk
