### CLOUDFLARE

# https://github.com/cloudflare/cloudflare-go/

# https://developers.cloudflare.com/api


FLARE_CLI_DEP=flare-cli-cli
FLARE_CLI_DEP_BIN_DEEP=flarectl

FLARE_CLI_DEP_REPO=cloudflare-cli-go
FLARE_CLI_DEP_REPO_URL=https://github.com/cloudflare/cloudflare-go
FLARE_CLI_DEP_REPO_DEEP=$(FLARE_CLI_DEP_REPO)/cmd/flarectl

FLARE_CLI_DEP_MOD=github.com/cloudflare/cloudflare-go
FLARE_CLI_DEP_MOD_DEEP=$(FLARE_CLI_DEP_MOD)/cmd/flarectl

# https://github.com/cloudflare/cloudflare-go/releases/tag/v0.107.0
FLARE_CLI_DEP_VERSION=v0.107.0

FLARE_CLI_DEP_META=flare_cli_meta.json

FLARE_CLI_DEP_NATIVE=$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_NATIVE)
FLARE_CLI_DEP_WHICH=$(shell command -v $(FLARE_CLI_DEP_NATIVE))

# CGO_ENABLED=1 go install -tags extended github.com/gohugoio/hugo@latest
FLARE_CLI_GO_INSTALL_CMD=CGO_ENABLED=0 $(BASE_DEP_BIN_GO_NAME) install
FLARE_CLI_GO_BUILD_CMD=CGO_ENABLED=0 $(BASE_DEP_BIN_GO_NAME) build

## THIS IS Needed for each web site, i think ...
CF_DOMAIN=?
CF_SUBDOMAIN=?
CF_ZONE_ID=?
CF_ACCOUNT_ID=?



FLARE_CLI_RUN_PATH=$(PWD)
FLARE_CLI_RUN_CMD=$(FLARE_CLI_DEP_NATIVE)


flare-cli-print:
	@echo ""
	@echo "- bin"
	@echo "FLARE_CLI_DEP:             $(FLARE_CLI_DEP)"
	@echo "FLARE_CLI_DEP_VERSION:     $(FLARE_CLI_DEP_VERSION)"
	@echo "FLARE_CLI_DEP_WHICH:       $(FLARE_CLI_DEP_WHICH)"
	@echo "FLARE_CLI_DEP_NATIVE:      $(FLARE_CLI_DEP_NATIVE)"
	
	@echo ""
	
	@echo ""
	@echo "- env"
	@echo "CLOUDFLARE_CLI_API_KEY:    $(CLOUDFLARE_CLI_API_KEY)"
	@echo "CLOUDFLARE_CLI_API_EMAIL:  $(CLOUDFLARE_CLI_API_EMAIL)"
	@echo ""
	@echo "- more env"
	@echo "CF_DOMAIN:             $(CF_DOMAIN)"
	@echo "CF_DOMAIN:             $(CF_SUBDOMAIN)"
	@echo "CF_API_TOKEN:          $(CF_API_TOKEN)"
	@echo "CF_ZONE_ID:            $(CF_ZONE_ID)"
	@echo "CF_ACCOUNT_ID:         $(CF_ACCOUNT_ID)"
	@echo ""
	@echo ""
	@echo "- run"
	@echo "FLARE_CLI_RUN_ZONE:        $(FLARE_CLI_RUN_ZONE)"

	@echo "FLARE_CLI_RUN_PATH:        $(FLARE_CLI_RUN_PATH)"
	@echo "FLARE_CLI_RUN_CMD:         $(FLARE_CLI_RUN_CMD)"


### dep

flare-cli-dep-template: base-dep-init
	@echo ""

	@echo ""
	@echo "-version"
	rm -rf $(BASE_MAKE_IMPORT)/$(FLARE_CLI_DEP_META)
	echo $(FLARE_CLI_DEP_VERSION) >> $(BASE_MAKE_IMPORT)/$(FLARE_CLI_DEP_META)

	@echo ""
	cp -r $(BASE_MAKE_IMPORT)/$(FLARE_CLI_DEP_META) $(BASE_CWD_DEP)
	
	#cp -r $(BASE_MAKE_IMPORT)/flare_cli.go $(BASE_CWD_DEP)

	cp -r $(BASE_MAKE_IMPORT)/flare_cli.md $(BASE_CWD_DEP)
	cp -r $(BASE_MAKE_IMPORT)/flare_cli.mk $(BASE_CWD_DEP)

flare-cli-dep-del:
	rm -f $(FLARE_CLI_DEP_WHICH)

flare-cli-dep: 
	@echo ""
	@echo " $(FLARE_CLI_DEP) dep check ... "
	@echo ""
	@echo "FLARE_CLI_DEP_WHICH: $(FLARE_CLI_DEP_WHICH)"

ifeq ($(FLARE_CLI_DEP_WHICH), )
	@echo ""
	@echo "$(FLARE_CLI_DEP) dep check: failed"
	$(MAKE) flare-cli-dep-single
else
	@echo ""
	@echo "$(FLARE_CLI_DEP) dep check: passed"
endif

flare-cli-dep-single: flare-cli-dep-template
	@echo ""
	$(FLARE_CLI_GO_INSTALL_CMD) $(FLARE_CLI_DEP_MOD_DEEP)@$(FLARE_CLI_DEP_VERSION)
	@echo ""
	mv $(GOPATH)/bin/$(FLARE_CLI_DEP_BIN_DEEP) $(BASE_CWD_DEP)/$(FLARE_CLI_DEP_NATIVE)
	rm -f $(GOPATH)/bin/$(FLARE_CLI_DEP)


flare-cli-dep-all: flare-cli-dep-template
	@echo ""
	rm -rf $(FLARE_CLI_DEP_REPO)
	$(BASE_DEP_BIN_GIT_NAME) clone $(FLARE_CLI_DEP_REPO_URL) -b $(FLARE_CLI_DEP_VERSION)
	@echo $(FLARE_CLI_DEP_REPO) >> .gitignore
	touch go.work
	go work use $(FLARE_CLI_DEP_REPO)

	@echo ""
	cd $(FLARE_CLI_DEP_REPO_DEEP) && GOOS=darwin GOARCH=amd64 $(FLARE_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	cd $(FLARE_CLI_DEP_REPO_DEEP) && GOOS=darwin GOARCH=arm64 $(FLARE_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	
	cd $(FLARE_CLI_DEP_REPO_DEEP) && GOOS=linux GOARCH=amd64 $(FLARE_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_LINUX_AMD64)
	cd $(FLARE_CLI_DEP_REPO_DEEP) && GOOS=linux GOARCH=arm64 $(FLARE_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_LINUX_ARM64)
	
	cd $(FLARE_CLI_DEP_REPO_DEEP) && GOOS=windows GOARCH=amd64 $(FLARE_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	cd $(FLARE_CLI_DEP_REPO_DEEP) && GOOS=windows GOARCH=arm64 $(FLARE_CLI_GO_BUILD_CMD) -o $(BASE_CWD_DEP)/$(FLARE_CLI_DEP)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64)

	rm -rf $(FLARE_CLI_DEP_REPO)
	rm -f go.work
	rm -f go.work.sum

	#touch go.work
	#go work use $(OS_MOD)


flare-cli-run-h: flare-cli-dep
	$(FLARE_CLI_RUN_CMD) -h

flare-cli-run-dns-h:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns -h
flare-cli-run-dns-list:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns list -h
	# --id value       record id
	# --zone value     zone name
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns list --zone="$(FLARE_CLI_RUN_ZONE)""
flare-cli-run-dns-create:
    # I use Create or Update so its idempotent
    # https://www.thegeekdiary.com/flarectl-official-cli-for-cloudflare/
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns create-or-update -h
    # --zone value      zone name
    # --name value      record name
    # --content value   record content
    #$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns create-or-update --zone="$(FLARE_CLI_RUN_ZONE)" --name="app" --type="CNAME" --content="myapp.herokuapp.com" --proxy
flare-cli-run-dns-delete:
	#  Delete a DNS record
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns delete -h
    # --zone value  zone name
    # --id value    record id
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) dns delete --zone="$(FLARE_CLI_RUN_ZONE)" --id="?"


flare-cli-run-firewall-rules-list:
	# 
	$(FLARE_CLI_RUN_CMD) firewall rules list -h
	#$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) firewall rules list
flare-cli-run-firewall-rules-create:
	# Block a specific IP
	# https://www.thegeekdiary.com/flarectl-official-cli-for-cloudflare/
	#$(FLARE_CLI_RUN_CMD) firewall rules create -h
	$(FLARE_CLI_RUN_CMD) firewall rules create --zone="example.com"  --account="gedw99" --value="8.8.8.8" --mode="block" --notes="Block bad actor"
	

flare-cli-run-ip:
	# Works
	# Print Cloudflare IP ranges
	#$(FLARE_CLI_RUN_CMD) ips -h
	$(FLARE_CLI_RUN_CMD) ips --ip-type all


flare-cli-run-ocrc:
	# WORKS- NO AUTH needed
	# Print Origin CA Root Certificate (in PEM format)
	$(FLARE_CLI_RUN_CMD) ocrc -h
	# --algorithm value  certificate algorithm ( ecc | rsa )
	$(FLARE_CLI_RUN_CMD) ocrc --algorithm=ecc


flare-cli-run-pagerules-list:
	#$(FLARE_CLI_RUN_CMD) pagerules -h
	$(FLARE_CLI_RUN_CMD) pagerules list --zone=$(FLARE_CLI_RUN_ZONE)
	

flare-cli-run-railgun-list:
	# THEY ARE DEPRECATED THIS. CF TUNNEL replaced it
	# https://blog.cloudflare.com/deprecating-railgun/
	$(FLARE_CLI_RUN_CMD) railgun -h
	$(FLARE_CLI_RUN_CMD) railgun --zone=$(FLARE_CLI_RUN_ZONE)
	

flare-cli-run-user-info:
	# Works - not yet
	# Print  User details
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user info
flare-cli-run-user-update:
	# Update user details
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user update -h


flare-cli-run-user-agents-list:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents list -h
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents list --zone=$(FLARE_CLI_RUN_ZONE)
flare-cli-run-user-agents-create:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents create -h
	# --mode value         the blocking mode: block, challenge, js_challenge, whitelist
	# --value value        the exact User-Agent to block
	# --paused             whether the rule should be paused (default: false) (default: false)
	# --description value  a description for the rule
	# $(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents create --zone=$(FLARE_CLI_RUN_ZONE) --mode=block --value=?? --description="your blocked dude"
flare-cli-run-user-agents-update:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents update -h
	#  --id value           User-Agent blocking rule ID
	# $(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents update --zone=$(FLARE_CLI_RUN_ZONE) --id=1 
flare-cli-run-user-agents-delete:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents delete -h
	# --id value    User-Agent blocking rule ID
	# $(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) user-agents delete --zone=$(FLARE_CLI_RUN_ZONE) --id=1



flare-cli-run-zone-list:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone list
flare-cli-run-zone-info:
	# Create many new Cloudflare zones automatically with names from domains.txt...
	# Information on one zone
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone info -h
	#$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone info --zone=$(FLARE_CLI_RUN_ZONE)
flare-cli-run-zone-create:
	# Create many new Cloudflare zones automatically with names from domains.txt...
	# Information on one zone
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone create -h
	#$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone create --zone=$(FLARE_CLI_RUN_ZONE)
flare-cli-run-zone-delete:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone delete -h
	#$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone delete --zone=$(FLARE_CLI_RUN_ZONE)
flare-cli-run-zone-check:
	$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone check -h
	#$(FLARE_CLI_RUN_CMD) --account-id $(CF_ACCOUNT_ID) zone check --zone=$(FLARE_CLI_RUN_ZONE)







	