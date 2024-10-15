BASE_MAKE_IMPORT=$(PWD)

# Grab what we need
MK=$(BASE_MAKE_IMPORT)
include $(MK)/help.mk
include $(MK)/base.mk
# your overrides for Env
include $(MK)/base_dev.env

include $(MK)/caddy.mk
include $(MK)/gh.mk
include $(MK)/hugo.mk
include $(MK)/nats_cli.mk
include $(MK)/nats_server.mk
include $(MK)/proc.mk


BASE_SRC_NAME=conduit-mono
BASE_SRC_URL=https://github.com/gedw99/conduit-mono
BASE_SRC_VERSION=main

BASE_BIN_NAME=.
BASE_BIN_MOD=.
BASE_BIN_ENTRY=.

# STATUS: Builds and runs, but needs config setup and testing of conduit.

this-ssh-check:
	$(MAKE) base-src-sign-print


# git stuff ( for top level control )
this-git-print:
	$(MAKE) BASE_SRC=$(PWD) base-src-sign-print
	$(MAKE) BASE_SRC=$(PWD) base-src-status
this-git-pull:
	# pull latest using git
	$(MAKE) BASE_SRC=$(PWD) base-src-pull
this-git-push:
	# commit and push using git
	$(MAKE) BASE_SRC=$(PWD) base-src-push


this: this-dep this-src this-bin

this-dep: help-dep base-dep caddy-dep gh-dep hugo-dep nats-cli-dep nats-server-dep proc-dep

### src

SRC_CONDUIT=conduitio__conduit
SRC_CONDUIT_CONNECT_FILE=conduitio__conduit_connector_file
SRC_CONDUIT_CONNECT_S3=conduitio__conduit_connector_s3
SRC_CONDUIT_PROCESSOR_EXAMPLE=conduitio__conduit_processor_example
SRC_CONDUIT_SCHEMA_REGISTRY=conduitio__conduit_schema_registry
SRC_CONDUIT_LAB_CONNECT_GOOGLE_SHEET=conduitio-labs__conduit_connector_google_sheets

SRC_NICKCHOMNEY_CONNECT_SURREAL=nickchomey__conduit_connector_surrealdb


this-src: 
	cd $(SRC_CONDUIT) && $(MAKE) this-src
	cd $(SRC_CONDUIT_CONNECT_FILE) && $(MAKE) this-src
	cd $(SRC_CONDUIT_CONNECT_S3) && $(MAKE) this-src
	cd $(SRC_CONDUIT_PROCESSOR_EXAMPLE) && $(MAKE) this-src
	cd $(SRC_CONDUIT_SCHEMA_REGISTRY) && $(MAKE) this-src
	cd $(SRC_CONDUIT_LAB_CONNECT_GOOGLE_SHEET) && $(MAKE) this-src

	cd $(SRC_NICKCHOMNEY_CONNECT_SURREAL) && $(MAKE) this-src

### bin

this-bin: 
	cd $(SRC_CONDUIT) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_CONNECT_FILE) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_CONNECT_S3) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_PROCESSOR_EXAMPLE) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_SCHEMA_REGISTRY) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_LAB_CONNECT_GOOGLE_SHEET) && $(MAKE) this-bin

	cd $(SRC_NICKCHOMNEY_CONNECT_SURREAL) && $(MAKE) this-bin
### run

this-run: 
	cd $(SRC_CONDUIT) && $(MAKE) this-run

this-hugo:
	$(MAKE) hugo-print

