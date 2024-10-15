
### template

## Make the templates a list
# https://github.com/apenella/simple-go-helloworld
# https://github.com/apenella/simple-go-helloworld/releases/tag/v0.1.0

# my fork:https://github.com/gedw99/simple-go-helloworld

TEMPLATE_DEP=template1
TEMPLATE_DEP_BIN=simple-go-helloworld

TEMPLATE_DEP_REPO=simple-go-helloworld
TEMPLATE_DEP_REPO_URL=https://github.com/apenella/simple-go-helloworld
TEMPLATE_DEP_REPO_DEEP=$(TEMPLATE_DEP_REPO)

TEMPLATE_DEP_MOD=github.com/apenella/simple-go-helloworld
TEMPLATE_DEP_MOD_DEEP=$(TEMPLATE_DEP_MOD)

TEMPLATE_DEP_VERSION=v0.1.0

TEMPLATE_DEP_TEMPLATE=$(BASE_MAKE_IMPORT)/template.md $(BASE_MAKE_IMPORT)/template.mk

TEMPLATE_DEP_NATIVE=$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
TEMPLATE_DEP_WHICH=$(shell command -v $(TEMPLATE_DEP_NATIVE))

TEMPLATE_GO_INSTALL_CMD=$(BASE_DEP_BIN_GO_NAME) install -tags osusergo,netgo -ldflags '-extldflags "-static"'
TEMPLATE_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags osusergo,netgo -ldflags '-extldflags "-static"'

TEMPLATE_RUN_CMD=$(TEMPLATE_DEP_NATIVE)


template-print:
	@echo ""
	@echo "TEMPLATE_DEP:              $(TEMPLATE_DEP)"
	@echo "TEMPLATE_DEP_BIN:          $(TEMPLATE_DEP_BIN)"

	@echo "TEMPLATE_DEP_REPO:         $(TEMPLATE_DEP_REPO)"
	@echo "TEMPLATE_DEP_REPO_URL:     $(TEMPLATE_DEP_REPO_URL)"
	@echo "TEMPLATE_DEP_REPO_DEEP:    $(TEMPLATE_DEP_REPO_DEEP)"

	@echo "TEMPLATE_DEP_MOD:          $(TEMPLATE_DEP_MOD)"
	@echo "TEMPLATE_DEP_MOD_DEEP:     $(TEMPLATE_DEP_MOD_DEEP)"

	@echo "TEMPLATE_DEP_VERSION:      $(TEMPLATE_DEP_VERSION)"

	@echo "TEMPLATE_DEP_TEMPLATE:     $(TEMPLATE_DEP_TEMPLATE)"
	
	@echo "TEMPLATE_DEP_NATIVE:       $(TEMPLATE_DEP_NATIVE)"
	@echo "TEMPLATE_DEP_WHICH:        $(TEMPLATE_DEP_WHICH)"
	@echo ""
	@echo "TEMPLATE_RUN_CMD:          $(TEMPLATE_RUN_CMD)"
	@echo ""

### dep

template-dep-template: base-dep-init
	@echo ""
	$(foreach tool,$(TEMPLATE_DEP_TEMPLATE),$(call BASE_DEP_TEMPLATE_COPY,$(tool)))

template-dep: template-dep-template
	@echo ""
	$(TEMPLATE_GO_INSTALL_CMD) $(TEMPLATE_DEP_MOD_DEEP)@$(TEMPLATE_DEP_VERSION)
	@echo ""
	mv $(GOPATH)/bin/$(TEMPLATE_DEP_BIN) $(BASE_CWD_DEP)/$(TEMPLATE_DEP_NATIVE)
	rm -f $(GOPATH)/bin/$(TEMPLATE_DEP_BIN)

template-dep-all: template-dep-template
	@echo ""
	rm -rf $(TEMPLATE_DEP_REPO)
	git clone $(TEMPLATE_DEP_REPO_URL) -b $(TEMPLATE_DEP_VERSION)
	@echo $(TEMPLATE_DEP_REPO) >> .gitignore
	touch go.work
	go work use $(TEMPLATE_DEP_REPO)

	@echo ""

	cd $(TEMPLATE_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(TEMPLATE_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(TEMPLATE_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(TEMPLATE_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	
	cd $(TEMPLATE_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(TEMPLATE_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(TEMPLATE_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(TEMPLATE_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
	
	cd $(TEMPLATE_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(TEMPLATE_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(TEMPLATE_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(TEMPLATE_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(TEMPLATE_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)

	rm -rf $(TEMPLATE_DEP_REPO)
	rm -f go.work

	touch go.work
	go work use $(OS_MOD)


### run

template-run-h:
	$(TEMPLATE_RUN_CMD) -h
template-run:
	# http://localhost:80
	$(TEMPLATE_RUN_CMD) 




	