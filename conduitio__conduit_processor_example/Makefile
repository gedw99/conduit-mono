# NOTE working due to go-work needing more.. come back later.

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

BASE_SRC_NAME=conduit-processor-example
BASE_SRC_URL=https://github.com/ConduitIO/conduit-processor-example
# https://github.com/ConduitIO/conduit-processor-example/tags
# Its NOT tagged at all.
BASE_SRC_VERSION=main

BASE_BIN_NAME=conduit_processor_example
BASE_BIN_MOD=.
BASE_BIN_ENTRY=simple/cmd/processor


all: this-dep this-src this-bin

### dep

this-dep: help-dep base-dep #caddy-dep hugo-dep nats-cli-dep nats-server-dep proc-dep template-dep

### src

this-src: base-src

### bin

this-bin-pre:
	$(BASE_SRC_CMD) make install-tools
this-bin: this-bin-pre base-bin base-bin-wasm

### run 

this-run-h:
	$(BASE_RUN) -h
this-run-version:
	$(BASE_RUN) -version




