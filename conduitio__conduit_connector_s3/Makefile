# Compiles. 

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
#include $(MK)/hugo.mk
#include $(MK)/nats_cli.mk
#include $(MK)/nats_server.mk
#include $(MK)/proc.mk
#include $(MK)/template.mk

include $(PWD)/this.mk

BASE_SRC_NAME=conduit-connector-s3
BASE_SRC_URL=https://github.com/ConduitIO/conduit-connector-s3
# https://github.com/ConduitIO/conduit-connector-s3/releases/tag/v0.7.0
BASE_SRC_VERSION=v0.7.0
#BASE_SRC_VERSION=build-scripts

BASE_BIN_NAME=conduit_connector_s3
BASE_BIN_MOD=.
BASE_BIN_ENTRY=cmd/connector


this: this-dep this-src this-bin

### dep

this-dep: help-dep base-dep #caddy-dep hugo-dep nats-cli-dep nats-server-dep proc-dep template-dep

### src

this-src: base-src

### bin

this-bin: base-bin




