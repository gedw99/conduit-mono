### Runner 

Everything needed to install, run, confgiure and update nats ...

Its all makefile, and you can use the same for Prod. 

Uses direct git exec calls, instead of importing a golang git thing. 
- This is good for me..

## binaries

nats server
nats cli
nats nex
nats nsc

## configs

configs for it all

good examples are:

https://github.com/ZEISS/typhoon/tree/main/example

## runner

runner proc file and env for it all.

## TODO

Get runner and config working for lcoal.

Same for Fly.

Then we have a proper system to play with.

---

We could use NATS KV to upgrade the ENV using the Remote Config pattern.
- You can see this with RUnner, in that each Inacne of the same thing has slightly different config.
- I