# conduit-mono

https://github.com/gedw99/conduit-mono

Just to make it easier and quicker to work with conduit.


If you hit any problems, create an issue, with any debug info. 
This is tested mostly on Mac, and in CI on Mac, Linux and Windows.

## Make system

NOTE: all files in the root of this repo are replicated in from a global system. 
So so not  change them :)  Make an Issue and we work it out.

## Setup

We first need to ensue you are using ssh keys, so that:

- all git commits are verified commits
- all deployments are verified

Its pretty easy..


1. Ensure your ssh keys are setup on your laptop and in github. If you already have ssh keys setup, just move on to step 2.

```sh
# 1. Make a new key
ssh-keygen -t ed25519 -C "gedw99_github.com" -f ~/.ssh/gedw99_github.com

# 2. Add the private key to the ssh agent
ssh-add ~/.ssh/gedw99_github.com

# 3. List added ssh ( if in doubt )
ssh-add -l 

# 4. Delete ssh key ( if you screw it up )
ssh-add -d ~/.ssh/gedw99_github.com


# 5. Add the public key to github on the web site
# a. Copy the content of your public key like: "gedw99_github.com.pub"
# b. Go to https://github.com/settings/keys and click "New SSH key"
# Paste in the key contents 

```

2. Create a base_dev.env

```sh
cp ./base.env ./base_dev.env
```

The base_dev.env is gitignored. Its your own .env

Edit your ``` ./base_dev.env ``` to match your ssh key and email.

```sh
BASE_SRC_SIGNING_USER_NAME=gedw99
BASE_SRC_SIGNING_USER_EMAIL=gedw99@gmail.com

BASE_SRC_SIGNING_KEY_PRIV=$(HOME)/.ssh/gedw99_github.com
BASE_SRC_SIGNING_KEY=$(HOME)/.ssh/gedw99_github.com.pub
```

Then, check it works wit :

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

The system will then use your SSH keys and ensure they are used for git signing, deployment etc.


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

MAKE will use Hugo to pump out docs to github pages with binary download links to the github releases.

## DEPLOY

MAKE, will use Cloud Flare to configure infra.
