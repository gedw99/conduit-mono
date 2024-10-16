# STATUS: compiles. Need to test in proejct.

# MUST use this name.

# Use Env to quickly flip Environment.
#include base.env

# when at Module.
#BASE_MAKE_IMPORT=$(PWD)/
# when inside a Module
BASE_MAKE_IMPORT=$(PWD)/../.make
# wnen inside .dep
#BASE_MAKE_IMPORT=$(PWD)/.dep

# Grab what we need
MK=$(BASE_MAKE_IMPORT)
include $(MK)/help.mk
include $(MK)/base.mk
# your overrides
#include $(MK)/base_dev.env

include $(MK)/caddy.mk
include $(MK)/hugo.mk
include $(MK)/nats_cli.mk
include $(MK)/nats_server.mk
include $(MK)/proc.mk
include $(MK)/template.mk

include $(PWD)/this.mk

BASE_SRC_NAME=conduit-connector-file
BASE_SRC_URL=https://github.com/ConduitIO/conduit-connector-file
# https://github.com/ConduitIO/conduit-connector-file/releases/tag/v0.8.0
BASE_SRC_VERSION=v0.8.0

BASE_BIN_NAME=conduit_connector_file
BASE_BIN_MOD=.
BASE_BIN_ENTRY=cmd/connector


this: this-src this-bin

### dep

this-dep: help-dep base-dep 

this-dep-all: nats-cli-dep-all template-dep-all

### src

this-src: base-src

### bin
this-bin: base-bin

### run
#this-run: base-run




