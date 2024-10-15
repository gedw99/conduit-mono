

# MUST use this name.

# Use Env to quickly flip Environment.
#include base.env

# when at Module.
#BASE_MAKE_IMPORT=$(PWD)/
# when inside a Module
BASE_MAKE_IMPORT=$(PWD)/..
# wnen inside .dep
#BASE_MAKE_IMPORT=$(PWD)/.dep

# Grab what we need
MK=$(BASE_MAKE_IMPORT)
include $(MK)/help.mk
include $(MK)/base.mk

#include $(MK)/caddy.mk
#include $(MK)/cue.mk
#include $(MK)/hugo.mk
#include $(MK)/nats_cli.mk
#include $(MK)/nats_server.mk
#include $(MK)/proc.mk
#include $(MK)/template.mk

#include $(PWD)/this.mk


BASE_SRC_NAME=conduit-connector-surrealdb
BASE_SRC_URL=https://github.com/nickchomey/conduit-connector-surrealdb
BASE_SRC_VERSION=main
#BASE_SRC_URL=https://github.com/gedw99/conduit-connector-surrealdb
#BASE_SRC_VERSION=main

BASE_BIN_NAME=conduit_connector_surrealdb
BASE_BIN_MOD=.
BASE_BIN_ENTRY=cmd/connector

# STATUS: ?

this: this-dep this-src this-bin

### dep

this-dep: help-dep base-dep #cue-dep proc-dep

### src

this-src: base-src

### bin

this-bin: base-bin

### run

this-run: 
	# Needs CONDUIT_CONNECTOR_TOKEN
	$(BASE_BIN_TARGET) -h

docker:
	cd $(BASE_SRC) && $(MAKE) 






