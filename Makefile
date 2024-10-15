BASE_MAKE_IMPORT=$(PWD)


# Grab what we need
MK=$(BASE_MAKE_IMPORT)
include $(MK)/help.mk
include $(MK)/base.mk
# your overrides
include $(MK)/base_dev.env


BASE_SRC_NAME=conduit-mono
BASE_SRC_URL=https://github.com/gedw99/conduit-mono
BASE_SRC_VERSION=main

BASE_BIN_NAME=.
BASE_BIN_MOD=.
BASE_BIN_ENTRY=.

# STATUS: Builds and runs, but needs config setup and testing.


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

### dep
this-dep-del:
	# just here for now to make sure base-dep works for everyone.
	# golang, etc etc

this-dep: help-dep base-dep

### src

SRC_CONDUIT=conduitio__conduit
SRC_CONDUIT_CONNECT_FILE=conduitio__conduit-connector-file
SRC_CONDUIT_SCHEMA_REGISTRY=conduitio__conduit-schema-registry

this-src: 
	cd $(SRC_CONDUIT) && $(MAKE) this-src
	cd $(SRC_CONDUIT_CONNECT_FILE) && $(MAKE) this-src
	cd $(SRC_CONDUIT_SCHEMA_REGISTRY) && $(MAKE) this-src

### bin

this-bin: 

	cd $(SRC_CONDUIT) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_CONNECT_FILE) && $(MAKE) this-bin
	cd $(SRC_CONDUIT_SCHEMA_REGISTRY) && $(MAKE) this-bin

### run

this-run: 
	cd $(SRC_CONDUIT) && $(MAKE) this-run

