# conduit-mono

https://github.com/gedw99/conduit-mono

Just to make it easier and quicker to work with conduit.

## Setup

https://github.com/gedw99/conduit-mono/blob/main/Makefile#L9

Create a base_dev.env, based on base.dev

This will then use your SSH keys and ensure they are using for git, deployment etc.

## Build

You need make, golang and git.

The following will pull all repos, build them.

```sh
make this
```

If you hit any problems, create an issue, with any debug info. 
This is tested mostly on Mac, and in CI on Mac, Linux and Windows.

## CI

The generic Github CI workflow will be added. This calls Makefile, just like you do on your laptop. There is NO need to add anything else to the Github CI, as Make is perfectly.

## DIST

MAKE will use gh cli, to pump out binaries. It gives better control.

## Doc

MAKE will use Hugo to pump out docs to github pages.

## DEPLOY

MAKE, will use Cloud Flare to configure infra.

