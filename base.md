# Base

Single make with everything needs to do ANY projects.

NOTE: This is 100% language independent and MUST stay that way.

Just put in the standard variables and your pumping.

## TODO

- DONE: copy dependencies into a .dep, seperate from the .bin

- DONE: copy the .mk files into the .dep, so they are versionined with your project

- packing. Needs to be done for Web, Desktop, Mobile and Server
  - Some need installers where a Service agent is installed along with a App.

- Adjust other .mk files to work with base.mk. This just requires a basic mapping.

- Extend to Runtime. What i mena is that many of these operations are needed at runtime by my projects
  - Keep the naming conventions of src, bin, pack, run !!
  - Decide is make or mage or benhtos or golang is best way to do this.
    - If i go for golang, make it a package. DONT use MAGE. Then anything can use it.

## dep

For working with dependencies.

## src

For working with source code.

## bin

For building binaries.

## run

For running the binaries.

## pack

For packing the binaries. See base-pack.md


