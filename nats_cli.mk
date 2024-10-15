
### nats-cli

# https://github.com/nats-io/natscli
# github.com/nats-io/natscli
# /nats
# https://github.com/nats-io/natscli/releases/tag/v0.1.4

NATS_CLI_DEP=nats_cli

NATS_CLI_DEP_BIN=nats

NATS_CLI_DEP_REPO=natscli
NATS_CLI_DEP_REPO_URL=https://github.com/nats-io/natscli
NATS_CLI_DEP_REPO_DEEP=$(NATS_CLI_DEP_REPO)/$(NATS_CLI_DEP_BIN)

NATS_CLI_DEP_MOD=github.com/nats-io/natscli
NATS_CLI_DEP_MOD_DEEP=$(NATS_CLI_DEP_MOD)/$(NATS_CLI_DEP_BIN)

NATS_CLI_DEP_VERSION=v0.1.4

NATS_CLI_DEP_META=nats_cli_meta.json

NATS_CLI_DEP_NATIVE=$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
NATS_CLI_DEP_WHICH=$(shell command -v $(NATS_CLI_DEP_NATIVE))

NATS_CLI_GO_INSTALL_CMD=$(BASE_DEP_BIN_GO_NAME) install -tags osusergo,netgo -ldflags '-extldflags "-static"'
NATS_CLI_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags osusergo,netgo -ldflags '-extldflags "-static"'

NATS_CLI_RUN_CONTEXT_NAME:=default
NATS_CLI_RUN_PATH=$(BASE_CWD_DEP)
NATS_CLI_RUN_CMD=cd $(NATS_CLI_RUN_PATH) && $(NATS_CLI_DEP_NATIVE)


nats-cli-print:
	@echo ""
	@echo "NATS_CLI_DEP:              $(NATS_CLI_DEP)"

	@echo "NATS_CLI_DEP_BIN:          $(NATS_CLI_DEP_BIN)"
	
	@echo "NATS_CLI_DEP_REPO:         $(NATS_CLI_DEP_REPO)"
	@echo "NATS_CLI_DEP_REPO_URL:     $(NATS_CLI_DEP_REPO_URL)"
	@echo "NATS_CLI_DEP_REPO_DEEP:    $(NATS_CLI_DEP_REPO_DEEP)"
	
	@echo "NATS_CLI_DEP_MOD:          $(NATS_CLI_DEP_MOD)"
	@echo "NATS_CLI_DEP_MOD_DEEP:     $(NATS_CLI_DEP_MOD_DEEP)"
	@echo "NATS_CLI_DEP_VERSION:      $(NATS_CLI_DEP_VERSION)"

	@echo "NATS_CLI_DEP_META:         $(NATS_CLI_DEP_META)"
	
	@echo "NATS_CLI_DEP_NATIVE:       $(NATS_CLI_DEP_NATIVE)"
	@echo "NATS_CLI_DEP_WHICH:        $(NATS_CLI_DEP_WHICH)"
	@echo ""
	@echo "NATS_CLI_RUN_PATH:         $(NATS_CLI_RUN_PATH)"
	@echo "NATS_CLI_RUN_CMD:          $(NATS_CLI_RUN_CMD)"
	@echo ""

### dep

nats-cli-dep-template: base-dep-init
	@echo ""


	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(NATS_CLI_DEP_META)
	echo $(NATS_CLI_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(NATS_CLI_DEP_META)

	@echo ""
	cp -r $(BASE_MAKE_IMPORT)/$(NATS_CLI_DEP_META) $(BASE_CWD_DEP)
	
	cp -r $(BASE_MAKE_IMPORT)/nats_cli.go $(BASE_CWD_DEP)

	cp -r $(BASE_MAKE_IMPORT)/nats_cli.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/nats_cli.mk $(BASE_CWD_DEP)



nats-cli-dep-del:
	rm -f $(NATS_CLI_DEP_WHICH)

nats-cli-dep: 
	@echo ""
	@echo " $(NATS_CLI_DEP) dep check ... "
	@echo ""
	@echo "NATS_CLI_DEP_WHICH: $(NATS_CLI_DEP_WHICH)"

ifeq ($(NATS_CLI_DEP_WHICH), )
	@echo ""
	@echo "$(NATS_CLI_DEP) dep check: failed"
	$(MAKE) nats-cli-dep-single
else
	@echo ""
	@echo "$(NATS_CLI_DEP) dep check: passed"
endif

## nats-cli-dep
nats-cli-dep-single: nats-cli-dep-template
	@echo ""
	$(NATS_CLI_GO_INSTALL_CMD) $(NATS_CLI_DEP_MOD_DEEP)@$(NATS_CLI_DEP_VERSION)
	@echo ""
	mv $(GOPATH)/bin/$(NATS_CLI_DEP_BIN) $(BASE_CWD_DEP)/$(NATS_CLI_DEP_NATIVE)
	rm -f $(GOPATH)/bin/$(NATS_CLI_DEP)

## nats-cli-dep-all
nats-cli-dep-all: nats-cli-dep-template
	@echo ""
	rm -rf $(NATS_CLI_DEP_REPO)
	$(BASE_DEP_BIN_GIT_NAME) clone $(NATS_CLI_DEP_REPO_URL) -b $(NATS_CLI_DEP_VERSION)
	@echo $(NATS_CLI_DEP_REPO) >> .gitignore
	touch go.work
	go work use $(NATS_CLI_DEP_REPO)

	@echo ""
	cd $(NATS_CLI_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(NATS_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(NATS_CLI_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(NATS_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	
	cd $(NATS_CLI_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(NATS_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(NATS_CLI_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(NATS_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
	
	cd $(NATS_CLI_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(NATS_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(NATS_CLI_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(NATS_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(NATS_CLI_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)

	rm -rf $(NATS_CLI_DEP_REPO)
	rm -f go.work

	touch go.work
	go work use $(OS_MOD)


### run

nats-cli-run-h:
	$(NATS_CLI_RUN_CMD) -h
nats-cli-run:
	$(NATS_CLI_RUN_CMD) 
nats-cli-run-context:
	$(NATS_CLI_RUN_CMD) context create $(NATS_CLI_RUN_CONTEXT_NAME) --server nats://localhost:4222 --select
nats-cli-run-context-ls:
	$(NATS_CLI_RUN_CMD) context ls
nats-cli-run-context-del:
	$(NATS_CLI_RUN_CMD) context rm $(NATS_CLI_RUN_CONTEXT_NAME)

### object

nats-cli-run-object-h:
	$(NATS_CLI_RUN_CMD) object -h
nats-cli-run-object-ls:
	#$(NATS_CLI_RUN_CMD) object ls -h
	$(NATS_CLI_RUN_CMD) object ls $(ARGS)
nats-cli-run-object-ls-all:
	#$(NATS_CLI_RUN_CMD) object ls -h
	$(NATS_CLI_RUN_CMD) object ls
nats-cli-run-object-add:
	$(NATS_CLI_RUN_CMD) object add $(ARGS)
nats-cli-run-object-put:
	#$(NATS_CLI_RUN_CMD) object put -h
	#$(NATS_CLI_RUN_CMD) object put BUCKET FILE
	$(NATS_CLI_RUN_CMD) object put $(ARGS)
nats-cli-run-object-del:
	#$(NATS_CLI_RUN_CMD) object del -h
	#$(NATS_CLI_RUN_CMD) object del BUCKET FILE
	$(NATS_CLI_RUN_CMD) object del $(ARGS)

## kv

nats-cli-run-kv-ls:
	$(NATS_CLI_RUN_CMD) kv -h
	$(NATS_CLI_RUN_CMD) kv ls $(ARGS)
nats-cli-run-kv-add:
	$(NATS_CLI_RUN_CMD) kv add -h
	$(NATS_CLI_RUN_CMD) kv add $(ARGS)

### pub
nats-cli-run-pub:
	# nats pub "logs.test" "hello world"
	# EX: nats-cli-run-pub ARGS='"joe" "ggg"'
	#$(NATS_CLI_RUN_CMD) pub -h
	#$(NATS_CLI_RUN_CMD) pub subject bdoy
	$(NATS_CLI_RUN_CMD) pub $(ARGS)
nats-cli-run-pub-stdin:
	# listens to stdin. Neat for DeckSH, etc
	$(NATS_CLI_RUN_CMD) pub .h
