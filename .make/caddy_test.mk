### CADDY tester

# this is so i can test all the functions inside caddy.mk and the plugin packages.

caddy-test-print:
	@echo ""
	@echo "caddy test"
	@echo ""
	
caddy-test-run: caddy-run-server

caddy-test-all: caddy-dep caddy-run-package-ls caddy-test-build-exec caddy-run-package-ls
	

### xtemplate
# https://github.com/infogulch/xtemplate-caddy
	# BUT does SQL get included 
	#$(CADDY_RUN_CMD) add-package github.com/infogulch/xtemplate-caddy

### scrapers
#$(CADDY_RUN_CMD) add-package github.com/Odyssey346/ListenCaddy

### exec

##caddy-test-build-exec
caddy-test-build-exec:
	# add it. Its NOT idempotent BTW
	$(MAKE) CADDY_RUN_VAR_PACKAGE=github.com/abiosoft/caddy-exec caddy-run-package-add
## caddy-test-build-exec-del
caddy-test-build-exec-del:
	$(MAKE) CADDY_RUN_VAR_PACKAGE=github.com/abiosoft/caddy-exec caddy-run-package-del
## caddy-test-run-exec
caddy-test-run-exec:
	# run it 
	$(MAKE) CADDY_RUN_VAR_CADDYFILE=caddy_config_caddyfile_exec caddy-run-server

### appd

##caddy-test-build-appd
caddy-test-build-appd:
	# add it. Its NOT idempotent BTW
	$(MAKE) CADDY_RUN_VAR_PACKAGE=github.com/greenpau/caddy-appd caddy-run-package-add
## caddy-test-build-appd-del
caddy-test-build-appd-del:
	$(MAKE) CADDY_RUN_VAR_PACKAGE=github.com/greenpau/caddy-appd caddy-run-package-del
## caddy-test-run-appd
caddy-test-run-appd:
	# run it 
	$(MAKE) CADDY_RUN_VAR_CADDYFILE=caddy_config_caddyfile_appd caddy-run-server

### git

## caddy-test-build-git
caddy-test-build-git:
	# add it. Its NOT idempotent BTW
	$(MAKE) CADDY_RUN_VAR_PACKAGE=github.com/greenpau/caddy-git caddy-run-package-add
caddy-test-build-git-del:
	$(MAKE) CADDY_RUN_VAR_PACKAGE=github.com/greenpau/caddy-git caddy-run-package-del
## caddy-test-run-git
caddy-test-run-git:
	# run it 
	$(MAKE) CADDY_RUN_VAR_CADDYFILE=caddy_config_caddyfile_git caddy-run-server
