# conduit-mono

https://github.com/gedw99/conduit-mono

Just to make it easier and quicker to work with conduit.


If you hit any problems, create an issue, with any debug info. 
This is tested mostly on Mac, and in CI on Mac, Linux and Windows.

NOTE: all files in the root of this repo are replicated in from global system. 

## Setup

Create a base_dev.env, based on base.dev.

Ensure your ssh keys are loaded in the .ssh config.

The system will then use your SSH keys and ensure they are used for git signing, deployment etc.

Check it with:

```sh
make base-src-sign-print


- bin
BASE_SRC_SIGNING_BIN_NAME:      smimesign
BASE_SRC_SIGNING_BIN_WHICH:     /opt/homebrew/bin/smimesign


- config
BASE_SRC_SIGNING_CONFIG:        /Users/apple/.gitconfig
BASE_SRC_SIGNING_CONFIG_LOCAL:  /Users/apple/workspace/go/src/github.com/gedw99/conduit-mono/.git/config


- var

BASE_SRC_SIGNING_USER_NAME:     gedw99
BASE_SRC_SIGNING_USER_EMAIL:    gedw99@gmail.com

BASE_SRC_SIGNING_KEY_CONFIG:    /Users/apple/.ssh/config
BASE_SRC_SIGNING_KEY_PRIV:      /Users/apple/.ssh/gedw99_github.com
BASE_SRC_SIGNING_KEY:           /Users/apple/.ssh/gedw99_github.com.pub
BASE_SRC_SIGNING_PROGRAM:       ssh
BASE_SRC_SIGNING_FORMAT:        ssh


```

## Build

You need make, golang and git. The system wil check you have this.

Then you need to pull the dependencies, src code from each repo, build it and run it.

It will not touch anything on your hard disk outside this repo itself.

This will do all of that. All Dependencies will only be build once.

```sh
make this
```


## CI

The generic Github CI workflow will be added. This calls Makefile, just like you do on your laptop. There is NO need to add anything else to the Github CI, as Make is perfectly.

## DIST

MAKE will use gh cli, to pump out binaries. It gives better control.

## Doc

MAKE will use Hugo to pump out docs to github pages.

## DEPLOY

MAKE, will use Cloud Flare to configure infra.
