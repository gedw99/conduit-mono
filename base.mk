# base.
#
# We use special folders for containment, so that we can fully control whats on the the disk.
# 
# Design for many binarioes from 1 single repo.

# Builder using https://github.com/wombatwisdom/wombat-builder
# I do a local git clone, and its time consumng.
# Wombat will do it remotly, put it in NATS Bucket, and i can get it from there FAST !!
# OR https://github.com/superfly/rchab


## TODOs
# Add version file that gets put into the .bin named "BIN_NAME_VERSION", with the git bits inside
 # We can use git because ALL file systsm are git file systems.
 # I dont care about ldflags. The file is enough for me. When it goes into NATS the Wildcards will be based on NAME, VERSION, OS, ARCH

### base 
#  BASE_MAKE_IMPORT must be used in the original Makefile ( no exceptions )

BASE_SHELL_OS_NAME := $(shell uname -s | tr A-Z a-z)
BASE_SHELL_OS_ARCH := $(shell uname -m | tr A-Z a-z)

# os
BASE_OS_NAME := $(shell go env GOOS)
BASE_OS_ARCH := $(shell go env GOARCH)

# makefile
BASE_MAKEFILE := $(abspath $(lastword $(MAKEFILE_LIST)))

# git 
BASE_GITROOT=$(shell git rev-parse --show-toplevel)
BASE_GITROOT_BIN := $(BASE_GITROOT)/.bin
BASE_GITROOT_DATA := $(BASE_GITROOT)/.data

# Check if inside Github Actions
export GITHUB_ACTIONS=true
ifeq ($(GITHUB_ACTIONS)),true)
	@echo " ! Detected inside Github CI !"
	BASE_GITROOT=${{ github.workspace }}
	BASE_GITROOT_BIN := ${{ github.workspace }}/.bin
	BASE_GITROOT_DATA := ${{ github.workspace }}/.data
endif

# pwd ( aka pub ) to install location for desktop OS )
BASE_PWD_NAME := kanka
BASE_PWD := $(HOME)/$(BASE_PWD_NAME)
BASE_PWD_BIN := $(BASE_PWD)/.bin
BASE_PWD_DATA := $(BASE_PWD)/.data
BASE_PWD_META := $(BASE_PWD)/.meta

# cdw ( aka dev ) to install next to src.
BASE_CWD:=$(PWD)
BASE_CWD_BIN:=$(PWD)/.bin
BASE_CWD_DATA:=$(PWD)/.data
BASE_CWD_DEP:=$(PWD)/.dep
BASE_CWD_DEPTMP:=$(PWD)/.deptmp
BASE_CWD_META:=$(PWD)/.meta
BASE_CWD_SRC:=$(PWD)/.src
BASE_CWD_PACK:=$(PWD)/.pack



# .mk files ( and maybe others later), that we reuse, and are copied ot the BASE_GITROOT_BIN
BASE_ARTIFACTS:=?

# so "local binaries" are loaded automagically. 
# EX BASE_CWD:               /Users/apple/workspace/go/src/github.com/gedw99/kanka-cloudflare/modules/fly-apps__docker-daemon
export PATH:=$(PATH):$(BASE_CWD_BIN)

# so "desktop shared binaries" are loaded automatically. These are yours and others. Like aqua, etc
# EX BASE_PWD:              /Users/apple/kanka
export PATH:=$(PATH):$(BASE_PWD_BIN)

# so "repo shared binaries" are load automatically. These are in my repo root.
# EX BASE_GITROOT:           /Users/apple/workspace/go/src/github.com/gedw99/kanka-cloudflare
export PATH:=$(PATH):$(BASE_GITROOT_BIN)

export PATH:=$(PATH):$(BASE_CWD_DEP)

# so that gobrew is loaded automagically from dep call.
export PATH:=$(PATH):$(HOME)/.gobrew/current/bin:$(HOME)/.gobrew/bin
#export GOROOT="$(HOME)/.gobrew/current/go"

### cwd
# ops that we need to clean a project.

base-cwd-bin-del:
	@echo ""
	@echo "BASE_CWD_BIN:   $(BASE_CWD_BIN)"
	@echo ""
	rm -rf $(BASE_CWD_BIN)
	@echo ""
base-cwd-data-del:
	@echo ""
	@echo "BASE_CWD_DATA:   $(BASE_CWD_DATA)"
	@echo ""
	rm -rf $(BASE_CWD_DATA)
	@echo ""
base-cwd-dep-del:
	@echo ""
	@echo "BASE_CWD_DEP:   $(BASE_CWD_DEP)"
	@echo ""
	rm -rf $(BASE_CWD_DEP)
	@echo ""
base-cwd-deptmp-del:
	@echo ""
	@echo "BASE_CWD_DEPTMP:   $(BASE_CWD_DEPTMP)"
	@echo ""
	rm -rf $(BASE_CWD_DEPTMP)
	@echo ""
base-cwd-src-del:
	@echo ""
	@echo "BASE_CWD_SRC:   $(BASE_CWD_SRC)"
	@echo ""
	rm -rf $(BASE_CWD_SRC)
	@echo ""
base-cwd-pack-del:
	@echo ""
	@echo "BASE_CWD_PACK:  $(BASE_CWD_PACK)"
	@echo ""
	rm -rf $(BASE_CWD_PACK)
	@echo ""



## deletes our generated binaries

### clean

base-clean-print:
	@echo ""
	@echo ""
	@echo "- This prints ther sizes only to get a feel for whats there."
	@echo ""
	@echo "- modules"
	# this is the root "modules" folder. Be VERY caereful...
	#du -shc $(BASE_MAKE_IMPORT)
	@echo ""

	@echo ""
	@echo "- natives"
	#du -shc $(BASE_MAKE_IMPORT)/*$(BASE_BIN_SUFFIX_DARWIN_AMD64)
	@echo ""

	@echo ""
	@echo "- BASE_CWD_BIN"
	du -shc $(BASE_CWD_BIN)	
	@echo ""

	@echo ""
	@echo "- BASE_CWD_DATA"
	du -shc $(BASE_CWD_DATA)
	@echo ""

	@echo ""
	@echo "- BASE_CWD_DEP"
	du -shc $(BASE_CWD_DEP)
	@echo ""

	@echo ""
	@echo "- BASE_CWD_DEPTMP"
	du -shc $(BASE_CWD_DEPTMP)
	@echo ""

	@echo ""
	@echo "- BASE_CWD_SRC"
	du -shc $(BASE_CWD_SRC)
	@echo ""

	@echo ""
	@echo "- BASE_CWD_PACK"
	du -shc $(BASE_CWD_PACK)
	@echo ""
	
base-clean-module:
	# for a single module, from that place.
	# leave all source.

	@echo ""
	@echo "- delting project things."
	@echo "- .bin"
	#rm -rf $(BASE_CWD_BIN)
	@echo "- .dep"
	#rm -rf $(BASE_CWD_DEP)
	@echo "- .deptmp"
	#rm -rf $(BASE_CWD_DEPTMP)
	@echo "- .pack"
	#rm -rf $(BASE_CWD_PACK)

base-clean-module-all:
	# reaches down into all modules ...

	@echo ""
	@echo "- del project things."
	@echo "- .bin"
	ls -al $(BASE_CWD_BIN)
	#rm -rf $(BASE_CWD_BIN)
	@echo ""
	
	@echo ""
	@echo "- .dep"
	#ls -al $(BASE_CWD_DEP)
	#rm -rf $(BASE_CWD_DEP)
	@echo ""

	@echo ""
	@echo "- .deptmp"
	#rm -rf $(BASE_CWD_DEPTMP)
	@echo ""
	
	@echo ""
	@echo "- .pack"
	#rm -rf $(BASE_CWD_PACK)
	@echo ""
	

base-temp:
	exit
	rm -rf $(BASE_MAKE_IMPORT)/*$(BASE_BIN_SUFFIX_DARWIN_AMD64)

	rm -rf $(OS_DEP_ROOT)/*$(BASE_BIN_SUFFIX_DARWIN_ARM64)
	rm -rf $(OS_DEP_ROOT)/*$(BASE_BIN_SUFFIX_LINXU_AMD64)
	rm -rf $(OS_DEP_ROOT)/*$(BASE_BIN_SUFFIX_LINUX_ARM64)
	rm -rf $(OS_DEP_ROOT)/*$(BASE_BIN_SUFFIX_WINDOWS_AMD64)
	rm -rf $(OS_DEP_ROOT)/*$(BASE_BIN_SUFFIX_WINDOWS_ARM64)
	rm -rf $(OS_DEP_ROOT)/*$(BASE_BIN_SUFFIX_WASM)
	
	@echo ""
	@echo "ls..."
	ls -al $(BASE_MAKE_IMPORT)

	@echo ""
	@echo "size..."
	du -shc $(BASE_MAKE_IMPORT)


base-clean-os:
	# clean all go
	$(BASE_DEP_BIN_GO_NAME) clean -cache -testcache -modcache -fuzzcache

	# clean all docker
	docker buildx prune --all
	docker system prune --all --volumes

### pre

base-print-pre:
	@echo ""
	
	@echo "--- base : make ---"
	@echo "BASE_MAKE_IMPORT:       $(BASE_MAKE_IMPORT)"
	@echo "BASE_MAKEFILE:          $(BASE_MAKEFILE)"
	@echo "BASE_ARTIFACTS:         $(BASE_ARTIFACTS)"
	@echo ""
	@echo "--- base : shell ---"
	@echo "BASE_SHELL_OS_NAME:     $(BASE_SHELL_OS_NAME)"
	@echo "BASE_SHELL_OS_ARCH:     $(BASE_SHELL_OS_ARCH)"
	@echo "--- base : os ---"
	@echo "BASE_OS_NAME:           $(BASE_OS_NAME)"
	@echo "BASE_OS_ARCH:           $(BASE_OS_ARCH)"
	@echo ""
	@echo "--- base : Git Working folders---"
	@echo "BASE_GITROOT:           $(BASE_GITROOT)"
	@echo "BASE_GITROOT_BIN:       $(BASE_GITROOT_BIN)"
	@echo "BASE_GITROOT_DATA:      $(BASE_GITROOT_DATA)"
	@echo ""
	@echo "--- base : Personal Working folders ---"
	@echo "Personal Working directory:"
	@echo "BASE_PWD:              $(BASE_PWD)"
	@echo "BASE_PWD_BIN:          $(BASE_PWD_BIN)"
	@echo "BASE_PWD_DATA:         $(BASE_PWD_DATA)"
	@echo "BASE_PWD_META:         $(BASE_PWD_META)"
	@echo ""
	@echo "--- base : Current Working folders ---"
	@echo ":"
	@echo "BASE_CWD:               $(BASE_CWD)"
	@echo "BASE_CWD_BIN:           $(BASE_CWD_BIN)"
	@echo "BASE_CWD_DATA:          $(BASE_CWD_DATA)"
	@echo "BASE_CWD_DEP:           $(BASE_CWD_DEP)"
	@echo "BASE_CWD_DEPTMP:        $(BASE_CWD_DEPTMP)"
	@echo "BASE_CWD_META:          $(BASE_CWD_META)"
	@echo "BASE_CWD_SRC:           $(BASE_CWD_SRC)"
	@echo "BASE_CWD_PACK:          $(BASE_CWD_PACK)"
	@echo ""

## base-print
base-print: base-print-pre base-dep-print base-src-print base-bin-print base-run-print

### dep 

# load base stuff we need for CI / CD. These are identical to what will happen inside Github acrtions, so that we can just use a Makefile to bootstrap.


# git 
# Have not done a "dep" step for it yet. Not sure i need it.
BASE_DEP_BIN_GIT_NAME=git
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_GIT_NAME=git.exe
endif
BASE_DEP_BIN_GIT_WHICH=$(shell command -v $(BASE_DEP_BIN_GIT_NAME))


# gobrew ( via nothing !! )
# https://github.com/kevincobain2000/gobrew/releases/tag/v1.10.10
BASE_DEP_BIN_GOBREW_NAME=gobrew
BASE_DEP_BIN_GOBREW_VERSION=v1.10.10
# gobrew version
BASE_DEP_BIN_GOBREW_VERSION_ACTUAL=$(shell $(BASE_DEP_BIN_GOBREW_NAME) version)
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_GOBREW_NAME=gobrew.exe
endif
BASE_DEP_BIN_GOBREW_WHICH=$(shell command -v $(BASE_DEP_BIN_GOBREW_NAME))

# go ( via gobrew )
# versions dynamically managed with gobrew.
BASE_DEP_BIN_GO_NAME=go
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_GO_NAME=go.exe
endif
BASE_DEP_BIN_GO_WHICH=$(shell command -v $(BASE_DEP_BIN_GO_NAME))

# wgot ( via go )
# https://github.com/melbahja/got/releases/tag/v0.7.0
#or
# https://github.com/bitrise-io/got/blob/master/go.mod

BASE_DEP_BIN_WGOT_NAME=wgot
BASE_DEP_BIN_WGOT_VERSION=v0.7.0
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_WGOT_NAME=wgot.exe
endif
BASE_DEP_BIN_WGOT_WHICH=$(shell command -v $(BASE_DEP_BIN_WGOT_NAME))

# tree ( via go )
BASE_DEP_BIN_TREE_NAME=tree
BASE_DEP_BIN_TREE_VERSION=v0.7.0
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_TREE_NAME=tree.exe
endif
BASE_DEP_BIN_TREE_WHICH=$(shell command -v $(BASE_DEP_BIN_TREE_NAME))


# garble

BASE_DEP_BIN_GARBLE_NAME=garble
# https://github.com/burrowers/garble/releases/tag/v0.13.0
BASE_DEP_BIN_GARBLE_VERSION=v0.13.0
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_GARBLE_NAME=garble.exe
endif
BASE_DEP_BIN_GARBLE_WHICH=$(shell command -v $(BASE_DEP_BIN_GARBLE_NAME))

# redress

BASE_DEP_BIN_REDRESS_NAME=redress
# https://github.com/goretk/redress/releases/tag/v1.2.0
BASE_DEP_BIN_REDRESS_VERSION=v1.2.0
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_REDRESS_NAME=redress.exe
endif
BASE_DEP_BIN_REDRESS_WHICH=$(shell command -v $(BASE_DEP_BIN_REDRESS_NAME))

# tinygo
# https://github.com/tinygo-org/tinygo/releases/tag/v0.33.0
BASE_DEP_BIN_TINYGO_NAME=tinygo
BASE_DEP_BIN_TINYGO_VERSION=v0.33.0
ifeq ($(BASE_OS_NAME),windows)
	BASE_DEP_BIN_TINYGO_NAME=tinygo.exe
endif
BASE_DEP_BIN_TINYGO_WHICH=$(shell command -v $(BASE_DEP_BIN_TINYGO_NAME))


## base-dep-print
base-dep-print:
	@echo ""
	@echo "BASE_CWD_DEP:                 $(BASE_CWD_DEP)"
	@echo ""
	@echo "--- dep git ---"
	@echo "BASE_DEP_BIN_GIT_NAME:         $(BASE_DEP_BIN_GIT_NAME)"
	@echo "BASE_DEP_BIN_GIT_WHICH:        $(BASE_DEP_BIN_GIT_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep gobrew ---"
	@echo "BASE_DEP_BIN_GOBREW_NAME:            $(BASE_DEP_BIN_GOBREW_NAME)"
	@echo "BASE_DEP_BIN_GOBREW_VERSION:         $(BASE_DEP_BIN_GOBREW_VERSION)"
	@echo "BASE_DEP_BIN_GOBREW_VERSION_ACTUAL:  $(BASE_DEP_BIN_GOBREW_VERSION_ACTUAL)"
	@echo "BASE_DEP_BIN_GOBREW_WHICH:           $(BASE_DEP_BIN_GOBREW_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep golang ---"
	@echo "BASE_DEP_BIN_GO_NAME:         $(BASE_DEP_BIN_GO_NAME)"
	@echo "BASE_DEP_BIN_GO_WHICH:        $(BASE_DEP_BIN_GO_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep wgot ---"
	@echo "BASE_DEP_BIN_WGOT_NAME:       $(BASE_DEP_BIN_WGOT_NAME)"
	@echo "BASE_DEP_BIN_WGOT_VERSION:    $(BASE_DEP_BIN_WGOT_VERSION)"
	@echo "BASE_DEP_BIN_WGOT_WHICH:      $(BASE_DEP_BIN_WGOT_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep tree ---"
	@echo "BASE_DEP_BIN_TREE_NAME:       $(BASE_DEP_BIN_TREE_NAME)"
	@echo "BASE_DEP_BIN_TREE_VERSION:    $(BASE_DEP_BIN_TREE_VERSION)"
	@echo "BASE_DEP_BIN_TREE_WHICH:      $(BASE_DEP_BIN_TREE_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep garble ---"
	@echo "BASE_DEP_BIN_GARBLE_NAME:     $(BASE_DEP_BIN_GARBLE_NAME)"
	@echo "BASE_DEP_BIN_GARBLE_VERSION:  $(BASE_DEP_BIN_GARBLE_VERSION)"
	@echo "BASE_DEP_BIN_GARBLE_WHICH:    $(BASE_DEP_BIN_GARBLE_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep redress ---"
	@echo "BASE_DEP_BIN_REDRESS_NAME:    $(BASE_DEP_BIN_REDRESS_NAME)"
	@echo "BASE_DEP_BIN_REDRESS_VERSION: $(BASE_DEP_BIN_REDRESS_VERSION)"
	@echo "BASE_DEP_BIN_REDRESS_WHICH:   $(BASE_DEP_BIN_REDRESS_WHICH)"
	@echo ""
	@echo ""
	@echo "--- dep tinygo ---"
	@echo "BASE_DEP_BIN_TINYGO_NAME:     $(BASE_DEP_BIN_TINYGO_NAME)"
	@echo "BASE_DEP_BIN_TINYGO_VERSION:  $(BASE_DEP_BIN_TINYGO_VERSION)"
	@echo "BASE_DEP_BIN_TINYGO_WHICH:    $(BASE_DEP_BIN_TINYGO_WHICH)"
	@echo ""

base-dep-init:
	# called by all other makefiles !!!
	mkdir -p $(BASE_CWD_DEP)
base-dep-init-del:
	rm -rf $(BASE_CWD_DEP)


base-dep-template: base-dep-init
	@echo ""
	
	# templates to dep.
	cp -r $(BASE_MAKE_IMPORT)/base* $(BASE_CWD_DEP)


## Comments off for now, until we work out things a bit more, to not break developer existing setup of Make, git, go, etc
base-dep-del: #base-dep-git-del base-dep-gobrew-del base-dep-wgot-del base-dep-tree-del base-dep-garble-del base-dep-redress-del

base-dep: base-dep-template
	@echo ""
	@echo " checking base deps"
	@echo ""
	@echo "BASE_DEP_BIN_GIT_WHICH:         $(BASE_DEP_BIN_GIT_WHICH)"
	@echo "BASE_DEP_BIN_GIT_VERSION:       $(shell $(BASE_DEP_BIN_GIT_WHICH) -v)"
	@echo ""
	@echo "BASE_DEP_BIN_GOBREW_WHICH:      $(BASE_DEP_BIN_GOBREW_WHICH)"
	@echo "BASE_DEP_BIN_GOBREW_VERSION:    $(shell $(BASE_DEP_BIN_GOBREW_WHICH) version)"
	@echo ""
	@echo "BASE_DEP_BIN_WGOT_WHICH:        $(BASE_DEP_BIN_WGOT_WHICH)"
	@echo "BASE_DEP_BIN_TREE_WHICH:        $(BASE_DEP_BIN_TREE_WHICH)"
	@echo "BASE_DEP_BIN_GARBLE_WHICH:      $(BASE_DEP_BIN_GARBLE_WHICH)"
	@echo "BASE_DEP_BIN_REDRESS_WHICH:     $(BASE_DEP_BIN_REDRESS_WHICH)"
	@echo "BASE_DEP_BIN_TINYGO_WHICH:      $(BASE_DEP_BIN_TINYGO_WHICH)"
	

ifeq ($(BASE_DEP_BIN_GIT_WHICH), )
	@echo ""
	@echo " GIT check: failed"
	$(MAKE) base-dep-git
else
	@echo ""
	@echo "GIT check: passed"
endif

ifeq ($(BASE_DEP_BIN_GOBREW_WHICH), )
	@echo ""
	@echo " GOBREW check: failed"
	$(MAKE) base-dep-gobrew
else
	@echo ""
	@echo "GOBREW check: passed"
endif

	
ifeq ($(BASE_DEP_BIN_WGOT_WHICH), )
	@echo ""
	@echo " WGOT check: failed"
	$(MAKE) base-dep-wgot
else
	@echo ""
	@echo "WGOT check: passed"
endif

ifeq ($(BASE_DEP_BIN_TREE_WHICH), )
	@echo ""
	@echo " TREE check: failed"
	$(MAKE) base-dep-tree
else
	@echo ""
	@echo "TREE check: passed"
endif


ifeq ($(BASE_DEP_BIN_GARBLE_WHICH), )
	@echo ""
	@echo " GARBLE check: failed"
	$(MAKE) base-dep-garble
else
	@echo ""
	@echo "GARBLE check: passed"
endif

ifeq ($(BASE_DEP_BIN_REDRESS_WHICH), )
	@echo ""
	@echo " REDRESS check: failed"
	$(MAKE) base-dep-redress
else
	@echo ""
	@echo "REDRESS check: passed"
endif

ifeq ($(BASE_DEP_BIN_TINYGO_WHICH), )
	@echo ""
	@echo " TINYGO check: failed"
	#$(MAKE) base-dep-redress
else
	@echo ""
	@echo "TINYGO check: passed"
endif
	
# TODO: we can start to use winget soon for Windows.

base-dep-git-del:
    # Commented off for now, until we have a git install method, that does not break developer existing git install.
	#rm -rf $(BASE_DEP_BIN_GIT_WHICH)
base-dep-git:
    # For Devs, we can assume they have it.
    # For windows, winget is best.
    # For Mac ?
    # For Linux ?
   
	@echo ""
	@echo "git dep"
	@echo ""

base-dep-gobrew-del:
	rm -rf $(BASE_DEP_BIN_GOBREW_WHICH)
base-dep-gobrew:
	# Keep as it is. 
	# I have no use case for Users needeing this yet.
	# I might need to make it be installed using wgot later for github CI.

# gobrew
# # https://raw.githubusercontent.com/kevincobain2000/gobrew/v1.10.10/git.io.sh
# curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
	@echo ""
	@echo "gobrew dep :"
	@echo ""
ifeq ($(BASE_OS_NAME),darwin)
	@echo "--- gobrew: darwin ---"
	curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/$(BASE_DEP_BIN_GOBREW_VERSION)/git.io.sh | sh
endif
ifeq ($(BASE_OS_NAME),linux)
	@echo "--- gobrew: linux ---"
	curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/$(BASE_DEP_BIN_GOBREW_VERSION)/git.io.sh | sh
endif
ifeq ($(BASE_OS_NAME),windows)
	@echo "--- gobrew: windows ---"
	curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/$(BASE_DEP_BIN_GOBREW_VERSION)/git.io.sh | sh
	# Below uses Powershell and we dont use powersehll because bash works fine.
	#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.ps1'))
endif



base-dep-wgot-del:
	rm -rf $(BASE_DEP_BIN_WGOT_WHICH)
base-dep-wgot:
	@echo ""
	@echo "wgot dep"
	@echo ""

    # https://github.com/bitrise-io/got
	$(BASE_DEP_BIN_GO_NAME) install github.com/bitrise-io/got/cmd/got@latest
	$(BASE_DEP_BIN_GO_NAME) install github.com/bitrise-io/got/cmd/wgot@latest

	# almsot ready
	#go install github.com/bitrise-io/got/cmd/wgot@chunk-interrupt

base-dep-tree-del:
	rm -rf $(BASE_DEP_BIN_TREE_WHICH)
base-dep-tree:
	@echo ""
	@echo "tree dep"
	@echo ""

# https://github.com/a8m/tree
	$(BASE_DEP_BIN_GO_NAME) install github.com/a8m/tree/cmd/tree@latest
	

base-dep-garble-del:
	rm -rf $(BASE_DEP_BIN_GARBLE_WHICH)
base-dep-garble:
	@echo ""
	@echo "garble dep"
	@echo ""

	$(BASE_DEP_BIN_GO_NAME) install mvdan.cc/garble@$(BASE_DEP_BIN_GARBLE_VERSION)


base-dep-redress-del:
	rm -rf $(BASE_DEP_BIN_REDRESS_WHICH)
base-dep-redress:
	@echo ""
	@echo "redress dep"
	@echo ""

# redress
# https://github.com/goretk/redress
# https://github.com/goretk/redress/releases/tag/v1.2.0
	$(BASE_DEP_BIN_GO_NAME) install github.com/goretk/redress@$(BASE_DEP_BIN_REDRESS_VERSION)

	


base-dep-tinygo:

	# Maybe later move this to a tinygo.mk, and use wgot.

	# I dont really have a stromg use case for users t need this yet.
	# I might be to do Server side compilation of GO to WASM, but tinygo is hardly even worth it now.


	@echo ""
	@echo "tinygo dep"
	@echo ""

# Tinygo
# https://github.com/tinygo-org/tinygo/releases/tag/v0.33.0


ifeq ($(BASE_OS_NAME),darwin)
	@echo "--- tinygo: darwin ---"
	#curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
endif
ifeq ($(BASE_OS_NAME),linux)
	@echo "--- tinygo: linux ---"
	#curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
endif
ifeq ($(BASE_OS_NAME),windows)
	@echo "--- tinygo: windows ---"
	#curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
	# Below uses Powershell and we dont use powersehll because bash works fine.
	#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.ps1'))
endif


## base-dep
base-dep-tools:
	# THESE ARE SPECIAL and NOT for Users, and so called Tools:

	# Pinned for now...

	# github cli
	# https://github.com/cli/cli
	# https://github.com/cli/cli/releases/tag/v2.55.0
	$(BASE_DEP_BIN_GO_NAME) install github.com/cli/cli/v2/cmd/gh@v2.55.0

	
base-dep-gio:
	# GIO CMD
	# https://github.com/gioui/gio-cmd/releases/tag/v0.7.0
	# GIO code
	# https://github.com/gioui/gio/releases/tag/v0.7.0
	# GIO-X code
	# https://github.com/gioui/gio-x/releases/tag/v0.7.0

	@echo ""
	@echo "gio deps:"
ifeq ($(BASE_OS_NAME),darwin)
	@echo "--- gio: darwin ---"
	#curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
endif
ifeq ($(BASE_OS_NAME),linux)
	@echo "--- gio: linux ---"
	#https://gioui.org/doc/install/linux
	#sudo apt install gcc pkg-config libwayland-dev libx11-dev libx11-xcb-dev libxkbcommon-x11-dev libgles2-mesa-dev libegl1-mesa-dev libffi-dev libxcursor-dev libvulkan-dev
endif
ifeq ($(BASE_OS_NAME),windows)
	@echo "--- gio: windows ---"
	#curl -sLk https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.sh | sh
	# Below uses Powershell and we dont use powersehll because bash works fine.
	#Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/kevincobain2000/gobrew/master/git.io.ps1'))
endif










### src

BASE_SRC_NAME=main
BASE_SRC_URL=???
BASE_SRC_VERSION=latest
BASE_SRC=$(BASE_CWD_SRC)/$(BASE_SRC_NAME)


#BASE_SRC_NAME=go-brew
#BASE_SRC_URL=https://github.com/kevincobain2000/gobrew
#BASE_SRC_VERSION=v1.2
#BASE_SRC=$(BASE_CWD_SRC)/$(BASE_SRC_NAME)

BASE_SRC_CMD=cd $(BASE_SRC) &&

## base-src-print
base-src-print:
	@echo ""
	@echo "--- src inouts ---"
	@echo "BASE_SRC_NAME:        $(BASE_SRC_NAME)"
	@echo "BASE_SRC_URL:         $(BASE_SRC_URL)"
	@echo "BASE_SRC_VERSION:     $(BASE_SRC_VERSION)"
	@echo ""
	@echo "--- src calculated ---"
	@echo "BASE_SRC:             $(BASE_SRC)"
	@echo "BASE_SRC_CMD:         $(BASE_SRC_CMD)"
	@echo ""

## base-src
base-src: base-src-del
	mkdir -p $(BASE_CWD_SRC)
	cd $(BASE_CWD_SRC) && $(BASE_DEP_BIN_GIT_NAME) clone $(BASE_SRC_URL) -b $(BASE_SRC_VERSION)
	cd $(BASE_CWD_SRC) && echo $(BASE_SRC_NAME) >> .gitignore
	

## base-src-del
base-src-del:
	rm -rf $(BASE_CWD_SRC)

## base-src-ls
base-src-ls:
	cd $(BASE_SRC) && ls -al

## base-src-status
base-src-status:
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) status

## base-src-pull
base-src-pull:
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) pull

SRC_PUSH_MESSAGE:=

## base-src-push
base-src-push: base-src-sign-set
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) add .
ifeq ($(SRC_PUSH_MESSAGE), )
	@echo ""
	@echo ""
	@echo "you need a commit message. Like this:"
	@echo "make SRC_PUSH_MESSAGE='im a duffus' base-src-push"
	@echo ""
	@echo ""
else
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) commit -S -am '$(SRC_PUSH_MESSAGE)'
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) push
endif
	

### signing of src code	

BASE_SRC_SIGNING_CONFIG=$(HOME)/.gitconfig
BASE_SRC_SIGNING_CONFIG_LOCAL=$(BASE_SRC)/.git/config

BASE_SRC_SIGNING_USER_NAME=gedw99
BASE_SRC_SIGNING_USER_EMAIL=gedw99@gmail.com

# Thre is ssh and smime options. Pick one

# ssh based
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-ssh-key

BASE_SRC_SIGNING_KEY_PRIV=$(HOME)/.ssh/gedw99_github.com
BASE_SRC_SIGNING_KEY=$(HOME)/.ssh/gedw99_github.com.pub
BASE_SRC_SIGNING_PROGRAM=ssh
BASE_SRC_SIGNING_FORMAT=ssh

# PKI based using smime
# https://docs.github.com/en/authentication/managing-commit-signature-verification/telling-git-about-your-signing-key#telling-git-about-your-x509-key-1
#BASE_SRC_SIGNING_PATH=""
#BASE_SRC_SIGNING_KEY=e9abcabcef55053ead1dda7c297c6efd6c146a86
#BASE_SRC_SIGNING_PROGRAM=smimesign
#BASE_SRC_SIGNING_FORMAT=x509

BASE_SRC_SIGNING_BIN_NAME=smimesign
ifeq ($(BASE_OS_NAME),windows)
	BASE_SRC_SIGNING_BIN_NAME=smimesign.exe
endif
BASE_SRC_SIGNING_BIN_WHICH=$(shell command -v $(BASE_SRC_SIGNING_BIN_NAME))


base-src-sign-print:
	
	@echo "" 
	@echo "- bin" 
	@echo "BASE_SRC_SIGNING_BIN_NAME:      $(BASE_SRC_SIGNING_BIN_NAME)"
	@echo "BASE_SRC_SIGNING_BIN_WHICH:     $(BASE_SRC_SIGNING_BIN_WHICH)"
	@echo "" 
	@echo "" 
	@echo "- config" 
	@echo "BASE_SRC_SIGNING_CONFIG:        $(BASE_SRC_SIGNING_CONFIG)"
	@echo "BASE_SRC_SIGNING_CONFIG_LOCAL:  $(BASE_SRC_SIGNING_CONFIG_LOCAL)"
	@echo "" 
	@echo "" 
	@echo "- var" 
	@echo "" 
	@echo "BASE_SRC_SIGNING_USER_NAME:     $(BASE_SRC_SIGNING_USER_NAME)"
	@echo "BASE_SRC_SIGNING_USER_EMAIL:    $(BASE_SRC_SIGNING_USER_EMAIL)"
	@echo "" 

	@echo "BASE_SRC_SIGNING_KEY_CONFIG:    $(HOME)/.ssh/config"
	@echo "BASE_SRC_SIGNING_KEY_PRIV:      $(BASE_SRC_SIGNING_KEY_PRIV)"
	@echo "BASE_SRC_SIGNING_KEY:           $(BASE_SRC_SIGNING_KEY)"
	@echo "BASE_SRC_SIGNING_PROGRAM:       $(BASE_SRC_SIGNING_PROGRAM)"
	@echo "BASE_SRC_SIGNING_FORMAT:        $(BASE_SRC_SIGNING_FORMAT)"
	@echo ""

base-src-sign-print-scope:
	@echo ""
	@echo "- git config scope"
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --list --show-scope --show-origin
	@echo ""

base-src-sign-dep:
	@echo ""
	@echo " $(BASE_SRC_SIGNING_BIN_NAME) dep check ... "


ifeq ($(BASE_SRC_SIGNING_BIN_WHICH), )
	@echo ""
	@echo "$(BASE_SRC_SIGNING_BIN_NAME) dep check: failed"
	$(MAKE) base-src-sign-dep-single
else
	@echo ""
	@echo "$(BASE_SRC_SIGNING_BIN_NAME) dep check: passed"
endif

base-src-sign-dep-single:
	# https://github.com/github/smimesign
	#go install github.com/github/smimesign@latest
	brew install smimesign

base-src-sign-run-h: base-src-sign-dep
	$(BASE_SRC_SIGNING_BIN_NAME) -h
	$(BASE_SRC_SIGNING_BIN_NAME) -v
base-src-sign-run-list: base-src-sign-dep
	$(BASE_SRC_SIGNING_BIN_NAME) --list-keys
base-src-sign-run-sign: base-src-sign-dep
	#$(BASE_SRC_SIGNING_BIN_NAME) --sign -h
	$(BASE_SRC_SIGNING_BIN_NAME) --sign USER-ID=$(BASE_SRC_SIGNING_USER_NAME)
	

base-src-sign-set:
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.name $(BASE_SRC_SIGNING_USER_NAME)
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.email  $(BASE_SRC_SIGNING_USER_EMAIL)
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.signingkey $(BASE_SRC_SIGNING_KEY)
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local gpg.program $(BASE_SRC_SIGNING_PROGRAM)
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local gpg.format $(BASE_SRC_SIGNING_FORMAT)
base-src-sign-get:
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --get user.name
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --get user.email
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.signingkey
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local gpg.program
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local gpg.format
base-src-sign-del:
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.name ""
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.email ""
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local user.signingkey ""
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local gpg.program ""
	cd $(BASE_SRC) && $(BASE_DEP_BIN_GIT_NAME) config --local gpg.format ""




### mod

base-mod-tidy:
	cd $(BASE_CWD_SRC)/$(BASE_SRC_NAME) && $(BASE_DEP_BIN_GO_NAME) mod tidy
base-mod-upgrade:
	$(BASE_DEP_BIN_GO_NAME) install github.com/oligot/go-mod-upgrade@latest
	cd $(BASE_CWD_SRC)/$(BASE_SRC_NAME) && go-mod-upgrade

### bin 



BASE_BIN_NAME=$(BASE_SRC_NAME)

# name with BASE_OS_ARCH
BASE_BIN_TARGET=$(BASE_BIN_NAME)_bin_$(BASE_OS_NAME)_$(BASE_OS_ARCH)
ifeq ($(BASE_OS_NAME),windows)
	BASE_BIN_TARGET=$(BASE_BIN_NAME)_bin_$(BASE_OS_NAME)_$(BASE_OS_ARCH).exe
endif


# suffix to the go.mod of the src, used by the go.work file
BASE_BIN_MOD := .

# suffix to the main.go of the src
BASE_BIN_ENTRY := .


# used for naming all binaries suffix.
BASE_BIN_SUFFIX_NATIVE=bin_$(BASE_OS_NAME)_$(BASE_OS_ARCH)
ifeq ($(BASE_OS_NAME),windows)
	BASE_BIN_SUFFIX_NATIVE=bin_$(BASE_OS_NAME)_$(BASE_OS_ARCH).exe
endif

# constants for bin targets
BASE_BIN_SUFFIX_DARWIN_AMD64=bin_darwin_amd64
BASE_BIN_SUFFIX_DARWIN_ARM64=bin_darwin_arm64
BASE_BIN_SUFFIX_LINUX_AMD64=bin_linux_amd64
BASE_BIN_SUFFIX_LINUX_ARM64=bin_linux_arm64
BASE_BIN_SUFFIX_WINDOWS_AMD64=bin_windows_amd64.exe
BASE_BIN_SUFFIX_WINDOWS_ARM64=bin_windows_arm64.exe
BASE_BIN_SUFFIX_WASM=bin_js_wasm


BASE_BIN_GO_INSTALL_CMD=$(BASE_DEP_BIN_GO_NAME) install -tags osusergo,netgo -ldflags '-extldflags "-static"'
# commented off for now. We can get more specific later.
#BASE_BIN_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -tags osusergo,netgo -ldflags '-extldflags "-static"'
BASE_BIN_GO_BUILD_CMD=$(BASE_DEP_BIN_GO_NAME) build -buildvcs=false
BASE_BIN_GO_GARBLE_BUILD_CMD=$(BASE_DEP_BIN_GARBLE_NAME) build
BASE_BIN_GO_WASM_CMD=$(BASE_DEP_BIN_GO_NAME) build


# run time..
BASE_BIN_MOD_FSPATH=$(BASE_SRC_NAME)/$(BASE_BIN_MOD)
BASE_BIN_ENTRY_FSPATH=$(BASE_CWD_SRC)/$(BASE_SRC_NAME)/$(BASE_BIN_ENTRY)

## base-bin-print
base-bin-print:
	@echo ""
	@echo "--- bin inputs ---"
	@echo "BASE_BIN_MOD:            $(BASE_BIN_MOD)"
	@echo "BASE_BIN_MOD_FSPATH:     $(BASE_BIN_MOD_FSPATH)"
	@echo ""
	@echo "BASE_BIN_ENTRY:          $(BASE_BIN_ENTRY)"
	@echo ""
	@echo "BASE_BIN_NAME:           $(BASE_BIN_NAME)"
	
	@echo ""
	@echo ""
	@echo "--- bin calculated ---"
	@echo ""
	@echo "BASE_CWD_SRC:            $(BASE_CWD_SRC)"
	@echo "BASE_SRC_CMD:            $(BASE_SRC_CMD)"
	@echo ""
	@echo "BASE_CWD_BIN:            $(BASE_CWD_BIN)"
	@echo ""
	@echo "BASE_BIN_ENTRY_FSPATH:   $(BASE_BIN_ENTRY_FSPATH)"
	@echo ""
	@echo "BASE_BIN_SUFFIX_NATIVE:  $(BASE_BIN_SUFFIX_NATIVE)"
	@echo "BASE_BIN_TARGET:         $(BASE_BIN_TARGET)"
	@echo ""
	@echo "BASE_BIN_GO_INSTALL_CMD:        $(BASE_BIN_GO_INSTALL_CMD)"
	@echo "BASE_BIN_GO_BUILD_CMD:          $(BASE_BIN_GO_BUILD_CMD)"
	@echo "BASE_BIN_GO_GARBLE_BUILD_CMD:   $(BASE_BIN_GO_GARBLE_BUILD_CMD)"
	@echo "BASE_BIN_GO_WASM_CMD:           $(BASE_BIN_GO_WASM_CMD)"
	@echo ""

## base-bin-ls
base-bin-ls:
	# can see size, which helps. when obf, is about 30% smaller.
	@echo ""
	ls -lh $(BASE_CWD_BIN)
	@echo ""

base-bin-init:
	@echo ""
	@echo "- install go"
	#cd $(BASE_CWD_SRC)/$(BASE_SRC_NAME) && gobrew use mod
	cd $(BASE_CWD_SRC)/$(BASE_BIN_MOD_FSPATH) && gobrew use mod
	
	@echo ""
	@echo "- config go work"
	cd $(BASE_CWD_SRC) && touch go.work
	#cd $(BASE_CWD_SRC) && $(BASE_DEP_BIN_GO_NAME) work use $(BASE_SRC_NAME)/$(BASE_BIN_ENTRY)
	cd $(BASE_CWD_SRC) && $(BASE_DEP_BIN_GO_NAME) work use $(BASE_BIN_MOD_FSPATH)

	@echo ""
	@echo "-bin mod and gen"

	cd $(BASE_BIN_ENTRY_FSPATH) && $(BASE_DEP_BIN_GO_NAME) mod tidy
	cd $(BASE_BIN_ENTRY_FSPATH) && $(BASE_DEP_BIN_GO_NAME) generate .


## base-bin-del:
base-bin-del:
	rm -rf $(BASE_CWD_BIN)

## base-bin builds your local bin
base-bin: base-bin-init
	@echo ""
	
	
ifeq ($(BASE_OS_NAME),darwin)
	$(MAKE) base-bin-darwin
endif
ifeq ($(BASE_OS_NAME),linux)
	$(MAKE) base-bin-linux
endif
ifeq ($(BASE_OS_NAME),windows)
	$(MAKE) base-bin-windows
endif
	
	$(MAKE) base-bin-ls

## base-bin-all builds for Darin, Linux and Windows for amd64 and arm64
base-bin-all: base-bin-init base-bin-darwin base-bin-linux base-bin-windows

base-bin-darwin: #base-bin-init
	@echo ""
	@echo "-bin darwin"
	@echo ""

	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_AMD64) .
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_ARM64) .

base-bin-linux: #base-bin-init
	@echo ""
	@echo "-bin linux"
	@echo ""
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_AMD64) .
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_ARM64) .
base-bin-windows: #base-bin-init
	@echo ""
	@echo "-bin windows"
	@echo ""
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64) .
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=windows GOARCH=arm64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64) .

## base-bin-obf
base-bin-obf: base-bin-init
	# same as base-bin, but built using garble.
	@echo ""
	@echo "-bin with garble"
	@echo ""

ifeq ($(BASE_OS_NAME),darwin)
	$(MAKE) base-bin-darwin-obf
endif
ifeq ($(BASE_OS_NAME),linux)
	$(MAKE) base-bin-linux-obf
endif
ifeq ($(BASE_OS_NAME),windows)
	$(MAKE) base-bin-windows-obf
endif

	$(MAKE) base-bin-ls

base-bin-all-obf: base-bin-init base-bin-darwin-obf base-bin-linux-obf base-bin-windows-obf

base-bin-darwin-obf: #base-bin-init
	@echo ""
	@echo "-bin darwin obf"
	@echo ""
	
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_ARM64) *.go
base-bin-linux-obf: #base-bin-init
	@echo ""
	@echo "-bin linux obf"
	@echo ""
	
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_ARM64) *.go
base-bin-windows-obf: #base-bin-init
	@echo ""
	@echo "-bin windows obf"
	@echo ""
	
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=windows GOARCH=amd64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=0 GOOS=windows GOARCH=arm64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64) *.go
base-bin-wasm-obf:
	# garble and standard wasm build.
	@echo ""
	@echo "-bin wasm obf"
	@echo ""
	
	cd $(BASE_BIN_ENTRY_FSPATH) && GOOS=js GOARCH=wasm $(BASE_BIN_GO_GARBLE_BUILD_CMD) build -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM)


## base-bin-cgo
base-bin-cgo: base-bin-init
	# for gio stuff
	@echo ""
	@echo "-bin with cgo"
	@echo ""

ifeq ($(BASE_OS_NAME),darwin)
	$(MAKE) base-bin-darwin-cgo
endif
ifeq ($(BASE_OS_NAME),linux)
	$(MAKE) base-bin-linux-cgo
endif
ifeq ($(BASE_OS_NAME),windows)
	$(MAKE) base-bin-windows-cgo
endif
	
	$(MAKE) base-bin-ls

## base-bin-all-cgo build all GOOS, GOARCH with CGO. Needed for GIO and SQLite, etc
base-bin-all-cgo: base-bin-init base-bin-darwin-cgo base-bin-linux-cgo base-bin-windows-cgo
	# for gio stuff ...

base-bin-darwin-cgo:
	@echo ""
	@echo "-bin darwin cgo"
	@echo ""
	
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_ARM64) *.go
base-bin-linux-cgo:
	@echo ""
	@echo "-bin dafwin cgo"
	@echo ""
	
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=linux GOARCH=amd64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=linux GOARCH=arm64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_ARM64) *.go
base-bin-windows-cgo:
	@echo ""
	@echo "-bin windows cgo"
	@echo ""
	cd $(BASE_BIN_ENTRY_FSPATH) && $(BASE_DEP_BIN_GO_NAME) mod tidy
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=windows GOARCH=amd64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=windows GOARCH=arm64 $(BASE_BIN_GO_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64) *.go


## base-bin-cgo-obf
base-bin-cgo-obf: base-bin-init 
	# cgo and garbled
	# for gio stuff ...
	@echo ""
	@echo "-bin with cgo and garble"
	@echo ""

ifeq ($(BASE_OS_NAME),darwin)
	$(MAKE) base-bin-darwin-cgo-obf
endif
ifeq ($(BASE_OS_NAME),linux)
	$(MAKE) base-bin-linux-cgo-obf
endif
ifeq ($(BASE_OS_NAME),windows)
	$(MAKE) base-bin-windows-cgo-obf
endif

	$(MAKE) base-bin-ls

## base-bin-all-cgo-obf
base-bin-all-cgo-obf: base-bin-init base-bin-darwin-cgo-obf base-bin-linux-cgo-obf base-bin-windows-cgo-obf

base-bin-darwin-cgo-obf:
	@echo ""
	@echo "-bin darwin cgo obf"
	@echo ""
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=darwin GOARCH=amd64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=darwin GOARCH=arm64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_DARWIN_ARM64) *.go
base-bin-linux-cgo-obf:
	@echo ""
	@echo "-bin linux cgo obf"
	@echo ""
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=linux GOARCH=amd64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=linux GOARCH=arm64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_LINUX_ARM64) *.go
base-bin-windows-cgo-obf:
	@echo ""
	@echo "-bin windows cgo obf"
	@echo ""
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=windows GOARCH=amd64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_AMD64) *.go
	cd $(BASE_BIN_ENTRY_FSPATH) && CGO_ENABLED=1 GOOS=windows GOARCH=arm64 $(BASE_BIN_GO_GARBLE_BUILD_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WINDOWS_ARM64) *.go


## base-bin-inspect is a basic decompiler
base-bin-inspect: base-bin-init base-dep-tools
	# using redress to see how well its obfuscates ..
	@echo ""
	@echo "-- info ---"
	@echo ""
	$(BASE_DEP_BIN_REDRESS_NAME) info $(BASE_RUN)
	@echo ""
	@echo "-- packages  --std --vendor ---"
	@echo ""
	$(BASE_DEP_BIN_REDRESS_NAME) packages $(BASE_RUN) --std --vendor
	@echo ""
	@echo "-- moduledata ---"
	@echo ""
	$(BASE_DEP_BIN_REDRESS_NAME) moduledata $(BASE_RUN)


base-test:
	# TODO: Get golang tests outputting to JSON....
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && $(BASE_DEP_BIN_GO_NAME) tool test2json


base-bin-pub:
	# This copies the binaries to the Root git repo.
	# Its kind is useful locally...
	@echo ""
	@echo "publishing bin to:"
	@echo "BASE_GITROOT_BIN:   $(BASE_GITROOT_BIN)"
	@echo ""
	mkdir -p $(BASE_GITROOT_BIN)
	cp -r $(BASE_CWD_BIN)/* $(BASE_GITROOT_BIN)

	@echo ""
	@echo "publishing .mk's to:"
	@echo "BASE_GITROOT_BIN:   $(BASE_GITROOT_BIN)"
	cp $(BASE_MAKEFILE) $(BASE_GITROOT_BIN)/base.mk
	cp ./$(BASE_ARTIFACTS) $(BASE_GITROOT_BIN)/

	@echo ""
	@echo "listing BASE_GITROOT_BIN"
	ls -al $(BASE_GITROOT_BIN)
	@echo ""

base-bin-pub-nats:
	# TODO: Github CI sucks. Try sending to Syndia nats obj store...
	@echo ""
	@echo "publishing bin to:"

base-bin-web:
	# 1. Build using standard golang wasm
	$(BASE_BIN_GO_BUILD_CMD)
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && GOOS=js GOARCH=wasm $(BASE_BIN_GO_WASM_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM)

	# 2: Build using gio.
	# https://gioui.org/doc/install/wasm
	$(BASE_DEP_BIN_GO_NAME) install gioui.org/cmd/gogio@latest
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && gogio -target js -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web . 

	# 3. Copy normal wasm inside the GIO packging as main.wasm
	cp $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM) $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web/main.wasm

## base-bin-web-ofs
base-bin-web-ofs:
	# All works

	# 1. Build using garble 
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && GOOS=js GOARCH=wasm garble build -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM)

	# 2: Build using gio.
	# https://gioui.org/doc/install/wasm
	$(BASE_DEP_BIN_GO_NAME) install gioui.org/cmd/gogio@latest
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && gogio -target js -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web . 

	# 3. Copy garbled wasm inside the GIO packging as main.wasm
	cp $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM) $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web/main.wasm
	
## base-bin-web-ofs
base-bin-web-tiny:
	# use tinygo ...
	# TO garble we need to copy first and then build... FUCK.

	# 1. Build using tinygo 
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && tinygo build -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_js_tinywasm.wasm -target wasm .

	# 2: Build using gio.
	# https://gioui.org/doc/install/wasm
	$(BASE_DEP_BIN_GO_NAME) install gioui.org/cmd/gogio@latest
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && gogio -target js -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web . 

	# 3. Copy garbled wasm inside the GIO packging as main.wasm
	cp $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_js_tinywasm.wasm $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web/main.wasm
	
## base-bin-wasm
base-bin-wasm:
	# golang
	@echo ""
	@echo "--- golang wasm ---"
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && GOOS=js GOARCH=wasm $(BASE_BIN_GO_WASM_CMD) -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM)

base-bin-wasm-tiny:
	## TODO: needs to be part of dep, so its available.
	# We need a "tinygo_brew", so we can flip to the right version based on the go.mod.
	# ALWAYS fails with: pkg/mod/github.com/go-text/typesetting@v0.0.0-20230803102845-24e03d8b5372/fontscan/fontmap.go:155:23: undefined: os.UserCacheDir
	   # Maybe we need fonts for web ?
	# https://github.com/tinygo-org/tinygo
	# https://github.com/tinygo-org/tinygo/releases/tag/v0.31.2
	# https://tinygo.org/docs/guides/webassembly/
	# tinygo wasm
	@echo ""
	@echo "--- tinygo wasm ---"
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && tinygo build -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_js_tinywasm.wasm -target wasm .

	# tinygo wasi
	@echo ""
	@echo "--- tinygo wasi ---"
	$(BASE_SRC_CMD) cd $(BASE_BIN_ENTRY) && tinygo build -o $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_js_tinywasi.wasm -target wasi .

base-bin-wasm-inspect: base-dep-tools
	# NOTE: Does not work. Gets Unsupported file.

	# using redress to see how well its obfuscates ..
	@echo ""
	@echo "-- info ---"
	@echo ""
	$(BASE_DEP_BIN_REDRESS_NAME) info $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM)
	@echo ""
	@echo "-- packages  --std --vendor ---"
	@echo ""
	$(BASE_DEP_BIN_REDRESS_NAME) packages $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM) --std --vendor
	@echo ""
	@echo "-- moduledata ---"
	@echo ""
	$(BASE_DEP_BIN_REDRESS_NAME) moduledata $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_$(BASE_BIN_SUFFIX_WASM)




### run

BASE_RUN=$(BASE_CWD_BIN)/$(BASE_BIN_TARGET)

BASE_RUN_NAME := ?
BASE_RUN_ENTRY := ?

## base-run-print:
base-run-print:
	@echo ""
	@echo "--- run ---"
	@echo "BASE_RUN:             $(BASE_RUN)"
	@echo "BASE_RUN_NAME:        $(BASE_RUN_NAME)"
	@echo "BASE_RUN_ENTRY:       $(BASE_RUN_ENTRY)"
	@echo ""

## base-run:
base-run:
	$(BASE_BIN_TARGET)
base-run-args:

## base-run-web
base-run-web:
	#https://github.com/eliben/static-server
	#go run github.com/eliben/static-server@latest
	#static-server  $(BASE_CWD_BIN)

	# https://github.com/caddyserver/caddy/releases/tag/v2.8.4
	$(BASE_DEP_BIN_GO_NAME) install github.com/caddyserver/caddy/v2/cmd/caddy@v2.8.4


	#cd $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_web && caddy file-server --browse

	# https://localhost
	# http://localhost will auto redirect to https :)

	#cd $(BASE_CWD_BIN) && caddy file-server --domain localhost --browse --templates
	caddy file-server --domain localhost --browse --reveal-symlinks --templates

	



## base-run-wasm:
base-run-wasm:
	@echo "TODO: Need wazero"
	## wasm
	Need wazero to run the wasm, and not the OS.

ifeq ($(BASE_OS_NAME),linux)
ifeq ($(BASE_OS_ARCH),amd64)
	@echo "linux_amd64"
	$(BASE_CWD_BIN)/$(BASE_SRC_NAME)_linux_amd64
endif
ifeq ($(BASE_OS_ARCH),arm64)
	@echo "linux_arm64"
endif
endif


### deplpy

# so we can share binaries. Maybe a better name is activate ?
# then deploy is when NATS and File Watcher scoops then
# will involve goreman and psutil and gops...

# TASK File global: https://taskfile.dev/usage/#running-a-global-taskfile

## base-pwd-print
base-pwd-print:
	@echo ""
	@echo "--- base : pwd ---"
	@echo "BASE_PWD:       $(BASE_PWD)"
	@echo ""
	@echo ""
## base-pwd-init
base-pwd-init:
	mkdir -p $(BASE_PWD)
	mkdir -p $(BASE_PWD_BIN)
	mkdir -p $(BASE_PWD_DATA)
	mkdir -p $(BASE_PWD_META)

## base-pwd-init-del
base-pwd-init-del:
	rm -rf $(BASE_PWD)

## base-pwd-open
base-pwd-open:
	open $(BASE_HOME)

base-pwd-list:
	ls -al $(BASE_HOME)

## base-pwd-bin-deploy
base-pwd-bin-deploy:
	# copies up to root of git repo
	cp -r $(BASE_CWD_BIN) $(BASE_PWD_BIN)



### pack ( packaging )

# This is hardcoded to use the BASE_CWD_DEP and BASE_CWD_PACK for a very good reason.
# SO that we can comppose a Proejct out of other proejcts. the .bin and .dep concept with NATS makign it work.
# DONT change this Gerard - its simple and keeps me out of writing tons of golang.
# ITS ALL ABOUT reusing open sorrce code without coding all the way up the chain.


BASE_CWD_PACK_REVERSE=$(BASE_CWD_PACK)-reverse

base-pack-print:
	@echo  ""
	@echo  "--- pack print"
	@echo "takes .dep and copies into .pack"
	@echo  ""
	@echo  "-- sources"
	@echo  "BASE_CWD_DEP:            $(BASE_CWD_DEP)"
	@echo  "BASE_CWD_BIN:            $(BASE_CWD_BIN)"
	@echo  ""
	@echo  "-- target"
	@echo  "BASE_CWD_PACK:           $(BASE_CWD_PACK)"
	@echo  ""
	@echo  "-- target-test"
	@echo  "BASE_CWD_PACK_REVERSE:   $(BASE_CWD_PACK_REVERSE)"
	
base-pack-darwin:
	# DONT DO THIS - it ust makes build hard and gives us nothign.
	# this takes the 2 darwins bins and turns it into 1 via lipo
	@echo  ""
	@echo  "--- pack amd and arm into 1: ":  $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_darwin
	@echo  ""

	@lipo -create -output $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_darwin $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_darwin_amd64 $(BASE_CWD_BIN)/$(BASE_BIN_NAME)_darwin_arm64

	# copied from: https://github.com/rwilgaard/alfred-github-search/blob/main/Makefile#L23
	# takes the many binareis and packs them. Can them put into a .app, egc
	#@lipo -create -output workflow/$(PROJECT_NAME) workflow/$(PROJECT_NAME)-amd64 workflow/$(PROJECT_NAME)-arm64
	#@rm -f workflow/$(PROJECT_NAME)-amd64 workflow/$(PROJECT_NAME)-arm64

base-pack-init:
	# So as not to destroy our dev environment, we package to the ".pack" folder
	mkdir -p $(BASE_CWD_PACK)
base-pack-init-del:
	rm -rf $(BASE_CWD_PACK)

base-pack: base-pack-init
	# This is a general Packer for ANYTHING.

	# SOURCE and TARGET is all it needs:
	# $(BASE_CWD_PACK) is the target 
	# $(BASE_CWD_BIN) and $(BASE_CWD_DEP) are currently used.

	# Why ?
	# To make it easy to deploy, and never miss a file, we zip everything in each folder.
	# We can then inject that zip a Docker, or NATS Stream, or S3. 
	# The point is it an immutable copy !!

	# copied from: https://github.com/mynaparrot/plugNmeet-server/blob/main/Makefile#L18


	# deps
	#zip -r $(BASE_CWD_PACK)/dep.zip $(BASE_CWD_DEP)/*
	#zip -r $(BASE_CWD_PACK)/dep.zip $(BASE_CWD_DEP)/*
	cd $(BASE_CWD_DEP) && zip -FSr $(BASE_CWD_PACK)/dep.zip *

	# bins
	#zip -r $(BASE_CWD_PACK)/bin.zip $(BASE_CWD_BIN)/*
	#zip -FSr $(BASE_CWD_PACK)/bin.zip $(BASE_CWD_BIN)/*
	cd $(BASE_CWD_BIN) && zip -FSr $(BASE_CWD_PACK)/bin.zip *

	# Lastly the Makefile and base.mk, so that it can unpack and run itself
	cp Makefile $(BASE_CWD_PACK)
	cp $(BASE_MAKE_IMPORT)/base*.* $(BASE_CWD_PACK)

base-pack-reverse-init:
	mkdir -p $(BASE_CWD_PACK_REVERSE)
base-pack-reverse-init-del:
	# We dont do this normally
	rm -rf $(BASE_CWD_PACK_REVERSE)
base-pack-reverse: base-pack-reverse-init
	# unzip the same things.

	# The Server or Client will run this eventually.

	# We want it to put the files in the same folder that the zips files live,
	# so that no paths are needed at runtime. The Folder is our single dependency.

	# Where to put it?
	@echo ""
	@echo "- unpack "
	@echo "to $(BASE_CWD_PACK_REVERSE)"
	@echo ""

	cd $(BASE_CWD_PACK) && unzip bin.zip -d $(BASE_CWD_PACK_REVERSE)
	cd $(BASE_CWD_PACK) && unzip dep.zip -d $(BASE_CWD_PACK_REVERSE)

	# Run it ( just for now )
	#cd $(BASE_CWD_PACK) && $(MAKE) 


base-pack-gui:
	# TODO: GUI needs different shit
base-pack-service:
	# Servcies need different shit.
	
	


