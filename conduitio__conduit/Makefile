
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
include $(MK)/base_dev.env

#include $(MK)/caddy.mk
#include $(MK)/hugo.mk
#include $(MK)/nats_cli.mk
#include $(MK)/nats_server.mk
#include $(MK)/proc.mk
#include $(MK)/template.mk

include $(PWD)/this.mk


BASE_SRC_NAME=conduit
BASE_SRC_URL=https://github.com/ConduitIO/conduit
# https://github.com/ConduitIO/conduit/releases/tag/v0.12.1
BASE_SRC_VERSION=v0.12.1
#BASE_SRC_VERSION=build-scripts

BASE_BIN_NAME=conduit
BASE_BIN_MOD=.
BASE_BIN_ENTRY=cmd/conduit

# STATUS: Builds and runs, but needs config setup and testing.

this: this-dep this-src this-bin

### dep

this-dep: help-dep base-dep #proc-dep

### src

this-src: base-src

### bin and run are custom

this-bin: this-bin-pre base-bin

### run

this-run: this-run-start






