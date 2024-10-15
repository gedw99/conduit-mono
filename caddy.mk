### CADDY

# https://github.com/caddyserver/caddy
# 
# github.com/caddyserver/caddy/v2

# We dont use xcaddy, because its so flakey.


CADDY_DEP=caddy

CADDY_DEP_BIN=caddy

CADDY_DEP_REPO=caddy
CADDY_DEP_REPO_URL=https://github.com/caddyserver/caddy
#CADDY_DEP_REPO_URL=https://github.com/gedw99/caddy
CADDY_DEP_REPO_DEEP=$(CADDY_DEP_REPO)/cmd/caddy

CADDY_DEP_MOD=github.com/caddyserver/caddy/v2
CADDY_DEP_MOD_DEEP=$(CADDY_DEP_MOD)/cmd/caddy

#https://github.com/caddyserver/caddy/releases/tag/v2.8.4
# try it...
# https://github.com/caddyserver/caddy/releases/tag/v2.9.0-beta.2
CADDY_DEP_VERSION=v2.8.4

CADDY_DEP_NATIVE=$(CADDY_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
CADDY_DEP_WHICH=$(shell command -v $(CADDY_DEP_NATIVE))

# CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
CADDY_GO_INSTALL_CMD=$(BASE_DEP_BIN_GO_NAME) install -tags extended,osusergo,netgo
CADDY_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags extended,osusergo,netgo

### meta

CADDY_DEP_META=caddy_meta.json
CADDY_DEP_TEMPLATE=$(BASE_MAKE_IMPORT)/caddy.mk


# run

CADDY_RUN_VAR_CONFIG_NAME=caddy_config_caddyfile
CADDY_RUN_VAR_PACKAGE=???
# path to src html
CADDY_RUN_VAR_BROWSE_PATH=$(BASE_SRC)
# port for reverse proxy to backend.
CADDY_RUN_VAR_PROXY_PATH_PORT=:3000

# run cmd
CADDY_RUN_PATH=$(BASE_CWD_DEP)
CADDY_RUN_DATA_PATH=$(BASE_CWD_DATA)/$(CADDY_DEP)
CADDY_RUN_CMD=cd $(CADDY_RUN_PATH) && $(CADDY_DEP_NATIVE)


caddy-print:
	@echo ""
	@echo "- dep"
	@echo "CADDY_DEP:              $(CADDY_DEP)"
	@echo "CADDY_DEP_BIN:          $(CADDY_DEP_BIN)"

	@echo "CADDY_DEP_REPO:         $(CADDY_DEP_REPO)"
	@echo "CADDY_DEP_REPO_URL:     $(CADDY_DEP_REPO_URL)"
	@echo "CADDY_DEP_REPO_DEEP:    $(CADDY_DEP_REPO_DEEP)"

	@echo "CADDY_DEP_MOD:          $(CADDY_DEP_MOD)"
	@echo "CADDY_DEP_MOD_DEEP:     $(CADDY_DEP_MOD_DEEP)"

	@echo "CADDY_DEP_VERSION:      $(CADDY_DEP_VERSION)"

	@echo "CADDY_DEP_NATIVE:       $(CADDY_DEP_NATIVE)"
	@echo "CADDY_DEP_WHICH:        $(CADDY_DEP_WHICH)"
	@echo ""

	@echo ""
	@echo "- meta"
	@echo "CADDY_DEP_META:         $(CADDY_DEP_META)"
	@echo "CADDY_DEP_TEMPLATE:     $(CADDY_DEP_TEMPLATE)"
	@echo ""

	@echo ""
	@echo "- run"
	@echo "CADDY_RUN_VAR_CONFIG_NAME:       $(CADDY_RUN_VAR_CONFIG_NAME)"
	@echo "CADDY_RUN_VAR_PACKAGE:           $(CADDY_RUN_VAR_PACKAGE)"
	@echo "CADDY_RUN_VAR_BROWSE_PATH:       $(CADDY_RUN_VAR_BROWSE_PATH)"
	@echo "CADDY_RUN_VAR_PROXY_PATH_PORT:   $(CADDY_RUN_VAR_PROXY_PATH_PORT)"
	@echo ""
	
	@echo ""
	@echo "- run cmd"
	@echo "CADDY_RUN_PATH:                  $(CADDY_RUN_PATH)"
	@echo "CADDY_RUN_DATA_PATH:             $(CADDY_RUN_DATA_PATH)"
	@echo "CADDY_RUN_CMD:                   $(CADDY_RUN_CMD)"
	@echo ""

### dep

caddy-dep-template: base-dep-init
	
	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(CADDY_DEP_META)
	echo $(CADDY_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(CADDY_DEP_META)

	# templates to dep.
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_browse.html $(BASE_CWD_DEP)
	
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_caddyfile $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_caddyfile_02 $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_caddyfile_03 $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_caddyfile_appd $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_caddyfile_git $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy_config_caddyfile_hugo $(BASE_CWD_DEP)

	cp -r $(BASE_MAKE_IMPORT)/$(CADDY_DEP_META) $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy_test.mk $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy.go $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/caddy.mk $(BASE_CWD_DEP)

caddy-dep-del:
	rm -f $(CADDY_DEP_WHICH)
	


caddy-dep: 
	@echo ""
	@echo " $(CADDY_DEP) dep check ... "
	@echo ""
	@echo "CADDY_DEP_WHICH: $(CADDY_DEP_WHICH)"

ifeq ($(CADDY_DEP_WHICH), )
	@echo ""
	@echo "$(CADDY_DEP) dep check: failed"
	$(MAKE) caddy-dep-single
else
	@echo ""
	@echo "$(CADDY_DEP) dep check: passed"
endif

caddy-dep-single: caddy-dep-template
	@echo ""
	$(CADDY_GO_INSTALL_CMD) $(CADDY_DEP_MOD_DEEP)@$(CADDY_DEP_VERSION)
	@echo ""
	mv $(GOPATH)/bin/$(CADDY_DEP_BIN) $(BASE_CWD_DEP)/$(CADDY_DEP_NATIVE)
	rm -f $(GOPATH)/bin/$(CADDY_DEP_BIN_DEEP)

caddy-dep-all: caddy-dep-template
	@echo ""

	rm -rf $(BASE_CWD_DEPTMP)
	mkdir -p $(BASE_CWD_DEPTMP)

	
	cd $(BASE_CWD_DEPTMP) && $(BASE_DEP_BIN_GIT_NAME) clone $(CADDY_DEP_REPO_URL) -b $(CADDY_DEP_VERSION)
	cd $(BASE_CWD_DEPTMP) && echo $(CADDY_DEP_REPO) >> .gitignore
	cd $(BASE_CWD_DEPTMP) && touch go.work
	cd $(BASE_CWD_DEPTMP) && go work use $(CADDY_DEP_REPO)

	@echo ""
	cd $(BASE_CWD_DEPTMP) && cd $(CADDY_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(CADDY_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(CADDY_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(CADDY_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(CADDY_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(CADDY_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	
	cd $(BASE_CWD_DEPTMP) && cd $(CADDY_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(CADDY_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(CADDY_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(CADDY_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(CADDY_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(CADDY_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
	
	cd $(BASE_CWD_DEPTMP) && cd $(CADDY_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(CADDY_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(CADDY_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(CADDY_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(CADDY_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(CADDY_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)

	rm -rf $(BASE_CWD_DEPTMP)

### run 
# every command does a dep check.

caddy-run-h: caddy-dep
	$(CADDY_RUN_CMD) -h
caddy-run-gen: caddy-dep
	# http://localhost:80
	$(CADDY_RUN_CMD)
caddy-run-version: caddy-dep
	$(CADDY_RUN_CMD) version
caddy-run-build-info: caddy-dep
	$(CADDY_RUN_CMD) build-info
caddy-run-fmt: caddy-dep
	@echo ""
	@echo "- Checking with Caddy file: $(CADDY_RUN_VAR_CONFIG_NAME)"
	@echo ""
	$(CADDY_RUN_CMD) fmt --overwrite $(CADDY_RUN_VAR_CONFIG_NAME)
caddy-run-env-print:
	# https://caddyserver.com/docs/caddyfile-tutorial#environment-variables
	# Print out the ENV ARGS that the caddyfile expects.
	# Not sure its possible
caddy-run-vars-print:
	# https://caddyserver.com/docs/caddyfile/matchers#vars
	# not sure i can.

caddy-run-server: caddy-run-fmt caddy-dep
	@echo ""
	@echo "- Running with Caddy file: $(CADDY_RUN_VAR_CONFIG_NAME)"
	@echo ""
	@echo "- Watching: $(CADDY_RUN_VAR_CONFIG_NAME)"
	@echo ""
	$(CADDY_RUN_CMD) run --config $(CADDY_RUN_VAR_CONFIG_NAME) --adapter caddyfile --watch
caddy-start-server: caddy-run-fmt caddy-dep
	@echo ""
	@echo "- Starting with Caddy file: $(CADDY_RUN_VAR_CONFIG_NAME)"
	@echo ""
	@echo "- Watching: $(CADDY_RUN_VAR_CONFIG_NAME)"
	@echo ""
	$(CADDY_RUN_CMD) start --config $(CADDY_RUN_VAR_CONFIG_NAME) --adapter caddyfile --watch

caddy-run-package-add: caddy-dep
	$(CADDY_RUN_CMD) add-package -h
	#$(CADDY_RUN_CMD) add-package $(CADDY_RUN_VAR_PACKAGE)
caddy-run-package-del: caddy-dep
	# NOTE: you cant delete a packahge that is already deleted
	#$(CADDY_RUN_CMD) remove-package -h
	$(CADDY_RUN_CMD) remove-package $(CADDY_RUN_VAR_PACKAGE)
caddy-run-package-ls: caddy-dep
	#$(CADDY_RUN_CMD) list-modules -h
	# does NOT has JSON output.
	$(CADDY_RUN_CMD) list-modules --packages --versions
