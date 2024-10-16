
### GH

# https://github.com/cli/cli/

## TODO: If this is highly useful, we can use JSON for Args in and out
# Just use a a simple jq : https://github.com/itchyny/gojq
# With it you can send JSON in, and it can pluck out the values from the JSON.
# SO a nice simple API thing over HTTP or NATS.

# They has JSON out and also JQ parsing on some of the CLI commands.
# --jq expression     Filter JSON output using a jq expression
# --json fields       Output JSON with the specified fields


GH_DEP=gh

GH_DEP_REPO=cli

GH_DEP_REPO_DEEP=$(GH_DEP_REPO)/cmd/gh

GH_DEP_REPO_URL=https://github.com/cli/cli
# https://github.com/cli/cli/releases/tag/v2.55.0
GH_DEP_VERSION=v2.55.0

GH_DEP_NATIVE=$(GH_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
GH_DEP_WHICH=$(shell command -v $(GH_DEP_NATIVE))

GH_GO_INSTALL_CMD=$(BASE_DEP_BIN_GO_NAME) install -tags osusergo,netgo -ldflags '-extldflags "-static"'
GH_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags osusergo,netgo -ldflags '-extldflags "-static"'
GH_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build

GH_ERR_EXIT="no args. Exiting"

### meta

GH_DEP_META=gh_meta.json
GH_DEP_TEMPLATE=$(BASE_MAKE_IMPORT)/gh.mk

### run
GH_RUN_RELEASE_TAG=001
GH_RUN_PATH=$(BASE_CWD_DEP)
GH_CMD=cd $(GH_RUN_PATH) && $(GH_DEP_NATIVE)


gh-print:
	@echo ""
	@echo "- dep"
	@echo "GH_DEP:              $(GH_DEP)"
	@echo "GH_DEP_REPO_DEEP:    $(GH_DEP_REPO_DEEP)"
	@echo "GH_DEP_REPO:         $(GH_DEP_REPO)"
	@echo "GH_DEP_REPO_URL:     $(GH_DEP_REPO_URL)"
	
	@echo "GH_DEP_VERSION:      $(GH_DEP_VERSION)"
	@echo "GH_DEP_NATIVE:       $(GH_DEP_NATIVE)"
	@echo "GH_DEP_WHICH:        $(GH_DEP_WHICH)"
	@echo ""
	@echo "- meta"
	@echo "GH_DEP_META:         $(GH_DEP_META)"
	@echo "GH_DEP_TEMPLATE:     $(GH_DEP_TEMPLATE)"
	@echo ""
	@echo "- run"
	@echo "GITHUB_TOKEN (ENV):  $(GITHUB_TOKEN)"
	@echo "GH_RUN_RELEASE_TAG:  $(GH_RUN_RELEASE_TAG)"
	@echo "GH_RUN_PATH:         $(GH_RUN_PATH)"
	@echo "GH_CMD:              $(GH_CMD)"
	@echo ""


gh-dep-template: base-dep-init
	# templates to dep.

	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(GH_DEP_META)
	echo $(GH_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(GH_DEP_META)

	# templates to dep.
	cp -r $(BASE_MAKE_IMPORT)/gh_config_ghfile $(BASE_CWD_DEP)
	
	cp -r $(BASE_MAKE_IMPORT)/$(GH_DEP_META) $(BASE_CWD_DEP)
	
	cp -r $(BASE_MAKE_IMPORT)/gh.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/gh.mk $(BASE_CWD_DEP)

## gh-dep-del
gh-dep-del:
	rm -f $(GH_DEP_WHICH)

## gh-dep
gh-dep:
ifeq ($(GH_DEP_WHICH), )
	@echo ""
	@echo "$(GH_DEP) dep check: failed"
	$(MAKE) gh-dep-single
else
	@echo ""
	@echo "$(GH_DEP) dep check: passed"
endif

gh-dep-single: gh-dep-template
	$(GH_GO_INSTALL_CMD) github.com/cli/cli/v2/cmd/gh@$(GH_DEP_VERSION)
	mv $(GOPATH)/bin/$(GH_DEP) $(BASE_CWD_DEP)/$(GH_DEP_NATIVE)
	rm -f $(GOPATH)/bin/$(GH_DEP)

## gh-dep-all
gh-dep-all: gh-dep-template
	rm -rf $(BASE_CWD_DEPTMP)
	mkdir -p $(BASE_CWD_DEPTMP)

	cd $(BASE_CWD_DEPTMP) && $(BASE_DEP_BIN_GIT_NAME) clone $(GH_DEP_REPO_URL) -b $(GH_DEP_VERSION)
	cd $(BASE_CWD_DEPTMP) && echo $(GH_DEP_REPO) >> .gitignore
	cd $(BASE_CWD_DEPTMP) && touch go.work
	cd $(BASE_CWD_DEPTMP) && go work use $(GH_DEP_REPO)

	@echo ""
	cd $(BASE_CWD_DEPTMP) && cd $(GH_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(GH_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(GH_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(GH_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(GH_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(GH_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	
	cd $(BASE_CWD_DEPTMP) && cd $(GH_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(GH_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(GH_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(GH_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(GH_GO_BUILD_CMD) -o $(OS_DEP_ROOT)/$(GH_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
	
	cd $(BASE_CWD_DEPTMP) && cd $(GH_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(GH_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(GH_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(BASE_CWD_DEPTMP) && cd $(GH_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(GH_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(GH_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)

	rm -rf $(BASE_CWD_DEPTMP)

	
### util

gh-util-args:
# My crappy way to check args being passed in.
ifeq ($(ARGS), )
	@echo $(GH_ERR_EXIT)
	exit 1
endif


### run

gh-run-h:
	$(GH_CMD) -h

## gh-run-auth
gh-run-auth:
	@echo ""
	@echo "- authing"
	@echo ""
	$(GH_CMD) auth login
	# just follow the prompts.

## gh-run-auth-status
gh-run-auth-status:
	@echo ""
	@echo "- status"
	@echo ""
	$(GH_CMD) auth status --show-token

## gh-run-auth-help
gh-run-auth-refresh-h:
	$(GH_CMD) auth refresh -h

## gh-run-auth-refresh ( ARGS="--scopes write:packages,workflow" gh-run-auth-refresh )
gh-run-auth-refresh: gh-util-args
	# ex: gh auth refresh --scopes write:packages,workflow
	@echo ""
	@echo "- refreshing scopes"
	@echo ""

	$(GH_CMD) auth refresh $(ARGS)

	
	

## gh-run-repo-list
gh-run-repo-list:
	@echo ""
	@echo "- repo list"
	@echo ""
	$(GH_CMD) repo list

gh-run-repo-fork:
	$(GH_CMD) repo fork $(SRC_URL)

gh-run-repo-set-h:
	$(GH_CMD) repo set-default -h
gh-run-repo-set:
	@echo ""
    #  Set a repository explicitly:
    # $ gh repo set-default owner/repo
	#$(GH_CMD) repo set-default $(BASE_SRC_URL)
	#$(GH_CMD) repo set-default gedw99/chapar
	
gh-run-repo-set-prompt:
    #  Interactively select a default repository:
    # $ gh repo set-default
	$(GH_CMD) repo set-default
gh-run-repo-set-list:
    # View the current default repository:
    # $ gh repo set-default --view
	$(GH_CMD) repo set-default --view

gh-run-pr-check:
	@echo ""
	@echo "- pc check"
	@echo ""

	#  --jq expression      Filter JSON output using a jq expression
    #  --json fields        Output JSON with the specified fields

	$(GH_CMD) pr checks --json
	#$(GH_CMD) pr checks --json "bucket"


## Lists information about your work on GitHub across all the repositories you're subscribed to
gh-run-status:
	@echo ""
	@echo "- status"
	@echo ""
	$(GH_CMD) status

## List issues in a GitHub repository.
gh-run-issue-list:
	@echo ""
	@echo "- issue list"
	@echo ""
	$(GH_CMD) issue list

## Help for Exentions
gh-run-ext-h:
	# https://cli.github.com/manual/gh_extension
	$(GH_CMD) extension -h

## Search extensions to the GitHub CLI
gh-run-ext-search:
	$(GH_CMD) extension search

## List installed extension commands
gh-run-ext-list:
	@echo ""
	@echo "- ext list"
	@echo ""
	$(GH_CMD) extension list

## Install an extension ( ARGS=ariga/gh-atlas gh-run-ext-dep )
gh-run-ext-dep:
	@echo ""
	@echo "- installing ext "
	@echo ""
ifeq ($(ARGS), )
	@echo $(GH_ERR_EXIT)
	@exit
else
	$(GH_CMD) extension install $(ARGS)
endif
	

## Remove an extension ( ARGS=ariga/gh-atlas gh-run-ext-dep-del )
gh-run-ext-dep-del:
	@echo ""
	@echo "- deleting extension "
	@echo ""
ifeq ($(ARGS), )
	@echo $(GH_ERR_EXIT)
	@exit
else
	$(GH_CMD) extension remove $(ARGS)
endif
	

## Help to run an extension ( ARGS=atlas gh-run-ext-run-h )
gh-run-ext-run-h:
	$(GH_CMD) extension exec $(ARGS) -h

## Run an extension ( ARGS=atlas gh-run-ext-run )
gh-run-ext-run:
	@echo ""
	@echo "- running extension "
	@echo ""
ifeq ($(ARGS), )
	@echo $(GH_ERR_EXIT)
	@exit
else
	$(GH_CMD) extension exec $(ARGS)
endif
	


## Release Help
gh-run-release-h:
	# https://cli.github.com/manual/gh_release
	$(GH_CMD) release -h

## List relesases
gh-run-release-list:
	$(GH_CMD) release list

gh-run-release-create-h:
	$(GH_CMD) release create -h

## Create releaes
gh-run-release-create:
	$(GH_CMD) release create $(GH_RUN_RELEASE_TAG) --generate-notes
	
	# https://github.com/gedw99/datastar/tags/
	#https://github.com/gedw99/datastar/releases

# Uplaod release ( done after "Create release" )
gh-run-release-upload:
	#$(GH_CMD) release upload -h 
	$(GH_CMD) release upload $(GH_RUN_RELEASE_TAG) $(BASE_CWD_BIN)/* --clobber

## Delete a release
gh-run-release-delete:
	$(GH_CMD) release delete $(GH_RUN_RELEASE_TAG)


	