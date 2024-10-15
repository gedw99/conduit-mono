

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
#include $(MK)/hugo.mk
#include $(MK)/nats_cli.mk
#include $(MK)/nats_server.mk
#include $(MK)/proc.mk
#include $(MK)/template.mk

BASE_SRC_NAME=conduit-schema-registry
BASE_SRC_URL=https://github.com/ConduitIO/conduit-schema-registry
# https://github.com/ConduitIO/conduit-schema-registry/releases/tag/v0.2.0
BASE_SRC_VERSION=v0.2.0

BASE_BIN_NAME=conduit_schema_registry
BASE_BIN_MOD=.
BASE_BIN_ENTRY=.
# simple/cmd/processor

this: this-dep this-src this-bin

### dep

this-dep: help-dep base-dep #caddy-dep hugo-dep nats-cli-dep nats-server-dep proc-dep template-dep

#this-dep-all: nats-cli-dep-all template-dep-all

### src

this-src: base-src

### bin

this-bin-pre:
	$(BASE_SRC_CMD) make install-tools

this-bin: this-bin-pre base-bin base-bin-wasm

### run 

this-run-h:
	$(BASE_BIN_TARGET) -h
this-run-version:
	$(BASE_BIN_TARGET) -version




