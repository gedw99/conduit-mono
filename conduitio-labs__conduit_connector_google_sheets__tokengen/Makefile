

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

#include $(MK)/caddy.mk
#include $(MK)/hugo.mk
#include $(MK)/nats_cli.mk
#include $(MK)/nats_server.mk
#include $(MK)/proc.mk
#include $(MK)/template.mk

include $(PWD)/this.mk

include .env

BASE_SRC_NAME=conduit-connector-google-sheets
BASE_SRC_URL=https://github.com/conduitio-labs/conduit-connector-google-sheets
# https://github.com/conduitio-labs/conduit-connector-google-sheets/releases/tag/v0.3.0
#BASE_SRC_VERSION=v0.3.0
BASE_SRC_VERSION=main

BASE_BIN_NAME=conduit_google_tokengen
BASE_BIN_MOD=.
BASE_BIN_ENTRY=cmd/tokengen

# STATUS: builds but need to test with google. Takes time :)

this: this-dep this-src this-bin

### dep

this-dep: help-dep base-dep #proc-dep

this-dep-all: proc-dep-all

### src

this-src: base-src

### bin

this-bin: base-bin-del base-bin

### run

this-run: this-run-start






