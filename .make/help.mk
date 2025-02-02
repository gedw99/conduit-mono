#SOURCE: https://gist.github.com/prwhite/8168133



# COLORS
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)


TARGET_MAX_CHAR_NUM=20
## Show help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk '/^[a-zA-Z\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${YELLOW}%-$(TARGET_MAX_CHAR_NUM)s${RESET} ${GREEN}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)


help-dep-init:
	mkdir -p $(BASE_CWD_DEP)
help-dep-del:
	rm -rf $(BASE_CWD_DEP)


help-dep-template: help-dep-init
	@echo ""

	# templates to dep.
	cp -r $(BASE_MAKE_IMPORT)/help.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/help.mk $(BASE_CWD_DEP)

help-dep: help-dep-template

HELP_H1_NAME=name
help-h1:
	@echo '${WHITE}# $(HELP_H1_NAME)${RESET}'

HELP_H2_NAME=name
help-h2:
	@echo '${YELLOW}## $(HELP_H2_NAME)${RESET}'

HELP_VAR_NAME=var-name
HELP_VAR_VALUE=var-value
help-var:
	@echo '  ${YELLOW}$(HELP_VAR_NAME)${RESET} ${GREEN}$(HELP_VAR_VALUE)${RESET}'
	