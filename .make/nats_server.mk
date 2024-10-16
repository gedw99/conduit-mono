### NATS Server



NATS_SERVER_DEP=nats_server
NATS_SERVER_DEP_BIN=nats-server
NATS_SERVER_DEP_REPO=nats-server
NATS_SERVER_DEP_REPO_DEEP=$(NATS_SERVER_DEP_REPO)

# https://github.com/nats-io/nats-server
NATS_SERVER_DEP_REPO_URL=https://github.com/nats-io/nats-server

# https://github.com/nats-io/nats-server/releases/tag/v2.10.21
NATS_SERVER_DEP_VERSION=v2.10.21

# https://github.com/nats-io/nats-server/blob/main/go.mod
NATS_SERVER_DEP_MOD=github.com/nats-io/nats-server/v2

NATS_SERVER_DEP_MOD_DEEP=$(NATS_SERVER_DEP_MOD)

NATS_SERVER_DEP_NATIVE=$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
NATS_SERVER_DEP_WHICH=$(shell command -v $(NATS_SERVER_DEP_NATIVE))

NATS_SERVER_GO_INSTALL_CMD=$(BASE_DEP_BIN_GO_NAME) install -tags osusergo,netgo -ldflags '-extldflags "-static"'
NATS_SERVER_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags osusergo,netgo -ldflags '-extldflags "-static"'

### meta

NATS_SERVER_DEP_META=nats_server_meta.json
NATS_SERVER_DEP_TEMPLATE=$(BASE_MAKE_IMPORT)/nats_server.mk

### run

NATS_SERVER_RUN_DATA_PATH=$(BASE_CWD_DATA)/nats_sever
NATS_SERVER_RUN_PATH=$(BASE_CWD_DEP)

# then values

# nats://127.0.0.1:4222
NATS_SERVER_RUN_VAR_LISTEN=127.0.0.1:4222
NATS_SERVER_RUN_VAR_CONFIG_NAME=nats_server_config
NATS_SERVER_RUN_VAR_CONFIG=$(NATS_SERVER_RUN_PATH)/$(NATS_SERVER_RUN_VAR_CONFIG_NAME)

NATS_SERVER_RUN_CMD=$(NATS_SERVER_DEP_NATIVE) --store_dir $(NATS_SERVER_RUN_DATA_PATH) 


nats-server-print:
	@echo ""
	@echo "-bin"
	@echo "NATS_SERVER_DEP:              $(NATS_SERVER_DEP)"
	@echo "NATS_SERVER_DEP_BIN:          $(NATS_SERVER_DEP_BIN)"
	@echo "NATS_SERVER_DEP_REPO:         $(NATS_SERVER_DEP_REPO)"
	@echo "NATS_SERVER_DEP_REPO_DEEP:    $(NATS_SERVER_DEP_REPO_DEEP)"
	@echo "NATS_SERVER_DEP_REPO_URL:     $(NATS_SERVER_DEP_REPO_URL)"
	@echo "NATS_SERVER_DEP_VERSION:      $(NATS_SERVER_DEP_VERSION)"
	
	
	@echo "NATS_SERVER_DEP_MOD:          $(NATS_SERVER_DEP_MOD)"
	@echo "NATS_SERVER_DEP_MOD_DEEP:     $(NATS_SERVER_DEP_MOD_DEEP)"
	
	@echo ""
	@echo "-meta"
	@echo "NATS_SERVER_DEP_META:         $(NATS_SERVER_DEP_META)"
	@echo "NATS_SERVER_DEP_TEMPLATE:     $(NATS_SERVER_DEP_TEMPLATE)"
	
	@echo "NATS_SERVER_DEP_NATIVE:       $(NATS_SERVER_DEP_NATIVE)"
	@echo "NATS_SERVER_DEP_WHICH:        $(NATS_SERVER_DEP_WHICH)"
	@echo ""
	@echo "-run"
	@echo "NATS_SERVER_RUN_VAR_LISTEN:        $(NATS_SERVER_RUN_VAR_LISTEN)"
	@echo "NATS_SERVER_RUN_VAR_CONFIG_NAME:   $(NATS_SERVER_RUN_VAR_CONFIG_NAME)"
	@echo "NATS_SERVER_RUN_DATA_PATH:         $(NATS_SERVER_RUN_DATA_PATH)"
	@echo "NATS_SERVER_RUN_PATH:              $(NATS_SERVER_RUN_PATH)"
	@echo "NATS_SERVER_RUN_CMD:               $(NATS_SERVER_RUN_CMD)"
	@echo ""

### dep

nats-server-dep-template: base-dep-init
	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(NATS_SERVER_DEP_META)
	echo $(NATS_SERVER_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(NATS_SERVER_DEP_META)

	@echo ""
	cp -r $(BASE_MAKE_IMPORT)/nats_server_config $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/$(NATS_SERVER_DEP_META) $(BASE_CWD_DEP)

	cp -r $(BASE_MAKE_IMPORT)/nats_server.go $(BASE_CWD_DEP)
	
	cp -r $(BASE_MAKE_IMPORT)/nats_server.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/nats_server.mk $(BASE_CWD_DEP)


nats-server-dep-del:
	rm -f $(NATS_SERVER_DEP_WHICH)

nats-server-dep: 
	@echo ""
	@echo " $(NATS_SERVER_DEP) dep check ... "
	@echo ""
	@echo "NATS_SERVER_DEP_WHICH: $(NATS_SERVER_DEP_WHICH)"

ifeq ($(NATS_SERVER_DEP_WHICH), )
	@echo ""
	@echo "$(NATS_SERVER_DEP) dep check: failed"
	$(MAKE) nats-server-dep-single
else
	@echo ""
	@echo "$(NATS_SERVER_DEP) dep check: passed"
endif

nats-server-dep-start:
	rm -rf $(BASE_CWD_DEPTMP)
	mkdir -p $(BASE_CWD_DEPTMP)

	cd $(BASE_CWD_DEPTMP) && $(BASE_DEP_BIN_GIT_NAME) clone $(NATS_SERVER_DEP_REPO_URL) -b $(NATS_SERVER_DEP_VERSION)
	cd $(BASE_CWD_DEPTMP) && echo $(NATS_SERVER_DEP_REPO) >> .gitignore
	cd $(BASE_CWD_DEPTMP) && touch go.work
	cd $(BASE_CWD_DEPTMP) && go work use $(NATS_SERVER_DEP_REPO)
nats-server-dep-end:
	rm -rf $(BASE_CWD_DEPTMP)

## nats-server-dep
nats-server-dep-single: nats-server-dep-template

	$(MAKE) nats-server-dep-start

ifeq ($(BASE_OS_NAME),darwin)
	@echo "--- darwin ---"
	$(MAKE) nats-server-dep-darwin
endif
ifeq ($(BASE_OS_NAME),linux)
	@echo "--- linux ---"
	$(MAKE) nats-server-dep-linux
endif
ifeq ($(BASE_OS_NAME),windows)
	@echo "--- windows ---"
	$(MAKE) nats-server-dep-windows
endif

	$(MAKE) nats-server-dep-end


## nats-server-dep-all
nats-server-dep-all: nats-server-dep-template
	
	$(MAKE) nats-server-dep-start

	$(MAKE) nats-server-dep-darwin
	$(MAKE) nats-server-dep-linux
	$(MAKE) nats-server-dep-windows

	$(MAKE) nats-server-dep-end
	
nats-server-dep-darwin:
	cd $(BASE_CWD_DEPTMP) && cd $(NATS_SERVER_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(NATS_SERVER_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(NATS_SERVER_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(NATS_SERVER_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
nats-server-dep-linux:
	cd $(BASE_CWD_DEPTMP) && cd $(NATS_SERVER_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(NATS_SERVER_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(NATS_SERVER_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(NATS_SERVER_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
nats-server-dep-windows:
	cd $(BASE_CWD_DEPTMP) && cd $(NATS_SERVER_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(NATS_SERVER_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(NATS_SERVER_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(NATS_SERVER_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_SERVER_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)



### run

nats-server-run-h:
	$(NATS_SERVER_RUN_CMD) -h
nats-server-run-server:
	# http://localhost:80
	$(NATS_SERVER_RUN_CMD) --config $(NATS_SERVER_RUN_VAR_CONFIG)
nats-server-run-clean:
	rm -rf $(NATS_SERVER_RUN_DATA_PATH)





	