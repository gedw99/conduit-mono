# conduit-mono

https://github.com/gedw99/conduit-mono

Just to make it easier and quicker to work with conduit.

## Build

You need make, golang and git.

```sh
make this
```

This is new, so if you hit any problems, create an issue, with any debug info, and we will fix the make system. Its been tested mostly on Mac, and in CI on Mac, Linux and Windows.

## CI

The generic Github CI workflow will be added. This calls Makefile.
There is NO need to add anything else to the github actions. Make is perfectly fine.

## DIST

MAKE wil use gh, to pump out binaries 

## Doc

MAKE will use Hugo to pump out docs to github pages

## DEPLOY

MAKE, will use Cloud FLare
