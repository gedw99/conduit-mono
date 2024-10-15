### hugo

# We use the HUGO Extended version: https://gohugo.io/installation/macos/

HUGO_DEP=hugo
HUGO_DEP_BIN_DEEP=hugo

HUGO_DEP_REPO=hugo
HUGO_DEP_REPO_URL=https://github.com/gohugoio/hugo
HUGO_DEP_REPO_DEEP=$(HUGO_DEP_REPO)

HUGO_DEP_MOD=github.com/gohugoio/hugo
HUGO_DEP_MOD_DEEP=$(HUGO_DEP_MOD)

# https://github.com/gohugoio/hugo/releases/tag/v0.135.0
HUGO_DEP_VERSION=v0.135.0
#HUGO_DEP_VERSION=main

HUGO_DEP_NATIVE=$(HUGO_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
HUGO_DEP_WHICH=$(shell command -v $(HUGO_DEP_NATIVE))

# CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
# Extended Edition: CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
HUGO_GO_INSTALL_CMD=CGO_ENABLED=1 $(BASE_DEP_BIN_GO_NAME) install -tags extended
HUGO_GO_BUILD_CMD=CGO_ENABLED=1 $(BASE_DEP_BIN_GO_NAME) build -tags extended

### meta
HUGO_DEP_META=hugo_meta.json
HUGO_DEP_TEMPLATE=$(BASE_MAKE_IMPORT)/hugo.mk

### run

HUGO_RUN_SITE=hugo-site
HUGO_RUN_CONFIG=hugo.toml
# --baseURL=https://example.org/
HUGO_RUN_BASE_URL=http://localhost:1313

HUGO_RUN_PATH=$(PWD)
HUGO_RUN_CMD_NEW=$(HUGO_DEP_NATIVE)
HUGO_RUN_CMD=cd $(HUGO_RUN_PATH) && cd $(HUGO_RUN_SITE) && $(HUGO_DEP_NATIVE) --config $(HUGO_RUN_CONFIG)


hugo-print:
	@echo ""
	@echo "- dep"
	@echo "HUGO_DEP:              $(HUGO_DEP)"
	@echo "HUGO_DEP_BIN_DEEP:          $(HUGO_DEP_BIN_DEEP)"

	@echo "HUGO_DEP_REPO:         $(HUGO_DEP_REPO)"
	@echo "HUGO_DEP_REPO_URL:     $(HUGO_DEP_REPO_URL)"
	@echo "HUGO_DEP_REPO_DEEP:    $(HUGO_DEP_REPO_DEEP)"

	@echo "HUGO_DEP_MOD:          $(HUGO_DEP_MOD)"
	@echo "HUGO_DEP_MOD_DEEP:     $(HUGO_DEP_MOD_DEEP)"

	@echo "HUGO_DEP_VERSION:      $(HUGO_DEP_VERSION)"

	@echo "HUGO_DEP_NATIVE:       $(HUGO_DEP_NATIVE)"
	@echo "HUGO_DEP_WHICH:        $(HUGO_DEP_WHICH)"
	@echo ""
	@echo ""
	@echo "- meta"
	@echo "HUGO_DEP_META:         $(HUGO_DEP_META)"
	@echo "HUGO_DEP_TEMPLATE:     $(HUGO_DEP_TEMPLATE)"
	@echo ""
	@echo ""
	@echo "- run"
	@echo "HUGO_RUN_SITE:         $(HUGO_RUN_SITE)"
	@echo "HUGO_RUN_CONFIG:       $(HUGO_RUN_CONFIG)"
	@echo "HUGO_RUN_BASE_URL:     $(HUGO_RUN_BASE_URL)"
	@echo "HUGO_RUN_PATH:         $(HUGO_RUN_PATH)"

	@echo "HUGO_RUN_CMD_NEW:      $(HUGO_RUN_CMD_NEW)"
	@echo "HUGO_RUN_CMD:          $(HUGO_RUN_CMD)"
	@echo ""

### dep

hugo-dep-template: base-dep-init
	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(HUGO_DEP_META)
	echo $(HUGO_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(HUGO_DEP_META)

	@echo ""
	cp -r $(BASE_MAKE_IMPORT)/$(HUGO_DEP_META) $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/hugo.env $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/hugo.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/hugo.mk $(BASE_CWD_DEP)

hugo-dep-del:
	rm -f $(HUGO_DEP_WHICH)

hugo-dep:
	@echo ""
	@echo " checking $(HUGO_DEP) dep"
	@echo ""
	@echo "HUGO_DEP_WHICH: $(HUGO_DEP_WHICH)"

ifeq ($(HUGO_DEP_WHICH), )
	@echo ""
	@echo "$(HUGO_DEP_WHICH) check: failed"

	$(MAKE) hugo-dep-single
else
	@echo ""
	@echo "found $(HUGO_DEP): passed"
	@echo ""
endif

hugo-dep-single: hugo-dep-template
	@echo ""
	$(HUGO_GO_INSTALL_CMD) $(HUGO_DEP_MOD_DEEP)@$(HUGO_DEP_VERSION)
	@echo ""
	mv $(GOPATH)/bin/$(HUGO_DEP_BIN_DEEP) $(BASE_CWD_DEP)/$(HUGO_DEP_NATIVE)
	rm -f $(GOPATH)/bin/$(HUGO_DEP_BIN_DEEP)

hugo-dep-all: hugo-dep-template
	@echo ""
	rm -rf $(HUGO_DEP_REPO)
	$(BASE_DEP_BIN_GIT_NAME) clone $(HUGO_DEP_REPO_URL) -b $(HUGO_DEP_VERSION)
	@echo $(HUGO_DEP_REPO) >> .gitignore
	touch go.work
	go work use $(HUGO_DEP_REPO)

	@echo ""
	cd $(HUGO_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(HUGO_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(HUGO_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(HUGO_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(HUGO_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(HUGO_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	
	cd $(HUGO_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(HUGO_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(HUGO_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(HUGO_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(HUGO_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(HUGO_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
	
	cd $(HUGO_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(HUGO_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(HUGO_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(HUGO_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(HUGO_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(HUGO_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)

	rm -rf $(HUGO_DEP_REPO)
	rm -f go.work
	rm -f go.work.sum

	#touch go.work
	#go work use $(OS_MOD)

	


### run

hugo-run-h: hugo-dep
	$(HUGO_RUN_CMD) -h

hugo-run-version: hugo-dep
	$(HUGO_RUN_CMD) version

hugo-run-gen: hugo-dep
	# http://localhost:80
	$(HUGO_RUN_CMD)


## hugo-run-site-new
hugo-run-site-new: hugo-dep
	$(HUGO_RUN_CMD_NEW) new site $(HUGO_RUN_SITE)
	cd $(HUGO_RUN_SITE) && $(HUGO_RUN_CMD_NEW) new theme mytheme
	cd $(HUGO_RUN_SITE) && echo "theme = 'mytheme'" >> hugo.toml

## hugo-run-site-del
hugo-run-site-del: hugo-dep
	cd $(HUGO_RUN_PATH) && rm -rf $(HUGO_RUN_SITE)

# hugo commands from https://github.com/zeon-studio/hugoplate/blob/main/package.json#L8


## hugo-run-build
hugo-run-build: hugo-dep
	$(HUGO_RUN_CMD) --gc --minify --templateMetrics --templateMetricsHints --forceSyncStatic


hugo-run-server-h: hugo-dep
	$(HUGO_RUN_CMD) server -h

## hugo-run-server
hugo-run-server: hugo-dep
	@echo ""
	@echo "- file changes will cause the web gui to update in real time"
	@echo ""
	#$(HUGO_RUN_CMD) server
	# http://localhost:1313/
	$(HUGO_RUN_CMD) server --baseURL=$(HUGO_RUN_BASE_URL)  --disableBrowserError --enableGitInfo --disableFastRender --navigateToChanged --templateMetrics --templateMetricsHints --watch --forceSyncStatic -e production --minify


## LIST stuff is for seeing content. REALY useful.

## hugo-run-list-h
hugo-run-list-h: hugo-dep
	$(HUGO_RUN_CMD) list -h

## hugo-run-list-all
hugo-run-list-all: hugo-dep
	$(HUGO_RUN_CMD) list all 

## hugo-run-list-drafts
hugo-run-list-drafts: hugo-dep
	$(HUGO_RUN_CMD) list drafts



