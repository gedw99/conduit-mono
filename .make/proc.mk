# RUNNER

### bin

PROC_DEP=proc
PROC_DEP_BIN=runner
PROC_DEP_REPO=runner
PROC_DEP_REPO_DEEP=$(PROC_DEP_REPO)

# https://github.com/cirello-io/runner
PROC_DEP_REPO_URL=https://github.com/cirello-io/runner
#PROC_DEP_REPO_URL=https://github.com/gedw99/runner

# https://github.com/cirello-io/runner/releases/tag/v2.4.0
PROC_DEP_VERSION=v2.4.0
# has windows fix :)
#PROC_DEP_VERSION=v2

# https://github.com/cirello-io/runner/blob/v2/go.mod
PROC_DEP_MOD=cirello.io/runner/v2

PROC_DEP_MOD_DEEP=$(PROC_DEP_MOD)

PROC_DEP_NATIVE=$(PROC_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
PROC_DEP_WHICH=$(shell command -v $(PROC_DEP_NATIVE))

# CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
PROC_GO_INSTALL_CMD=CGO_ENABLED=0 $(BASE_DEP_BIN_GO_NAME) install -tags osusergo,netgo
PROC_GO_BUILD_CMD=CGO_ENABLED=0 $(BASE_DEP_BIN_GO_NAME) build -tags osusergo,netgo

### meta

PROC_DEP_META=proc_meta.json
PROC_DEP_TEMPLATE=$(BASE_MAKE_IMPORT)/proc.mk

### run


PROC_RUN_VAR_ENVFILE:=proc_config_env
PROC_RUN_VAR_PROCFILE:=proc_config_procfile
# -service-discovery string          service discovery address (default "localhost:64000")
PROC_RUN_VAR_DISCO:=localhost:64000

PROC_RUN_CONFIG_PATH=$(BASE_CWD_DEP)
#PROC_RUN_PATH=$(PWD)
PROC_RUN_CMD=$(PROC_DEP_NATIVE) --env $(PROC_RUN_CONFIG_PATH)/$(PROC_RUN_VAR_ENVFILE) -service-discovery=$(PROC_RUN_VAR_DISCO) $(PROC_RUN_CONFIG_PATH)/$(PROC_RUN_VAR_PROCFILE) 


proc-print:
	@echo ""
	@echo "- bin"
	@echo "PROC_DEP:              $(PROC_DEP)"
	@echo "PROC_DEP_BIN:          $(PROC_DEP_BIN)"
	@echo "PROC_DEP_REPO:         $(PROC_DEP_REPO)"
	@echo "PROC_DEP_REPO_DEEP:    $(PROC_DEP_REPO_DEEP)"
	@echo "PROC_DEP_REPO_URL:     $(PROC_DEP_REPO_URL)"
	@echo "PROC_DEP_VERSION:      $(PROC_DEP_VERSION)"
	
	@echo "PROC_DEP_MOD:          $(PROC_DEP_MOD)"
	@echo "PROC_DEP_MOD_DEEP:     $(PROC_DEP_MOD_DEEP)"

	@echo "PROC_DEP_NATIVE:       $(PROC_DEP_NATIVE)"
	@echo "PROC_DEP_WHICH:        $(PROC_DEP_WHICH)"
	@echo ""
	@echo "- meta"
	@echo "PROC_DEP_TEMPLATE:     $(PROC_DEP_TEMPLATE)"
	@echo "PROC_DEP_META:         $(PROC_DEP_META)"
	@echo ""
	@echo "- run"
	@echo "PROC_RUN_VAR_ENVFILE:  $(PROC_RUN_VAR_ENVFILE)"
	@echo "PROC_RUN_VAR_PROCFILE: $(PROC_RUN_VAR_PROCFILE)"
	@echo "PROC_RUN_VAR_DISCO:    $(PROC_RUN_VAR_DISCO)"
	
	@echo "PROC_RUN_CONFIG_PATH:  $(PROC_RUN_CONFIG_PATH)"
	@echo "PROC_RUN_CMD:          $(PROC_RUN_CMD)"
	@echo ""

### dep

proc-dep-template: base-dep-init

	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(PROC_DEP_META)
	echo $(PROC_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(PROC_DEP_META)
	
	# templates to dep.
	cp -r $(BASE_MAKE_IMPORT)/proc_config_env $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/proc_config_env_nats_cluster $(BASE_CWD_DEP)
	
	cp -r $(BASE_MAKE_IMPORT)/proc_config_procfile $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/proc_config_procfile_caddy $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/proc_config_procfile_complex $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/proc_config_procfile_nats $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/proc_config_procfile_nats_cluster $(BASE_CWD_DEP)

	cp -r $(BASE_MAKE_IMPORT)/proc.go $(BASE_CWD_DEP)

	cp -r $(BASE_MAKE_IMPORT)/proc.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/proc.mk $(BASE_CWD_DEP)

proc-dep-del:
	rm -f $(PROC_DEP_WHICH)
	
proc-dep:
ifeq ($(PROC_DEP_WHICH), )
	@echo ""
	@echo "$(PROC_DEP) dep check: failed"
	$(MAKE) proc-dep-single
else
	@echo ""
	@echo "$(PROC_DEP) dep check: passed"
endif


proc-dep-start:
	rm -rf $(BASE_CWD_DEPTMP)
	mkdir -p $(BASE_CWD_DEPTMP)

	cd $(BASE_CWD_DEPTMP) && $(BASE_DEP_BIN_GIT_NAME) clone $(PROC_DEP_REPO_URL) -b $(PROC_DEP_VERSION)
	cd $(BASE_CWD_DEPTMP) && echo $(PROC_DEP_REPO) >> .gitignore
	cd $(BASE_CWD_DEPTMP) && touch go.work
	cd $(BASE_CWD_DEPTMP) && go work use $(PROC_DEP_REPO)
proc-dep-end:
	rm -rf $(BASE_CWD_DEPTMP)

proc-dep-single: proc-dep-template
	$(MAKE) proc-dep-start

ifeq ($(BASE_OS_NAME),darwin)
	@echo "--- darwin ---"
	$(MAKE) proc-dep-darwin
endif
ifeq ($(BASE_OS_NAME),linux)
	@echo "--- linux ---"
	$(MAKE) proc-dep-linux
endif
ifeq ($(BASE_OS_NAME),windows)
	@echo "--- windows ---"
	$(MAKE) proc-dep-windows
endif

	$(MAKE) proc-dep-end

proc-dep-all: proc-dep-template
	$(MAKE) proc-dep-start

	$(MAKE) proc-dep-darwin
	$(MAKE) proc-dep-linux
	$(MAKE) proc-dep-windows

	$(MAKE) proc-dep-end	
	
proc-dep-darwin:
	cd $(BASE_CWD_DEPTMP) && cd $(PROC_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(PROC_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(PROC_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(PROC_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(PROC_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(PROC_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
proc-dep-linux:
	cd $(BASE_CWD_DEPTMP) && cd $(PROC_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(PROC_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(PROC_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(PROC_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(PROC_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(PROC_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
proc-dep-windows:
	cd $(BASE_CWD_DEPTMP) && cd $(PROC_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(PROC_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(PROC_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(PROC_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(PROC_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(PROC_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)


### run

proc-run-h: proc-dep
	$(PROC_DEP_NATIVE) -h
proc-run-version: proc-dep
	@echo ""
	@echo "proc-run-version called ..."
	@echo ""
	$(PROC_DEP_NATIVE) -v
proc-run-server: proc-dep
	@echo ""
	@echo "proc-run-server called ..."
	@echo ""
	@echo "web admin:     http://localhost:64000"
	$(PROC_RUN_CMD) server

proc-run-admin-open: proc-dep
	open http://$(PROC_RUN_VAR_DISCO)
