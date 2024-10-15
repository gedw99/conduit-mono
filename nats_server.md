# NATS Server

## Global Cluster

https://www.synadia.com/blog/multi-cluster-consistency-models

Nice a simple working code for this is here:
https://github.com/synadia-labs/eventually-consistent-virtual-global-stream.git

Plan is to Germany with 2 or 3 different VPS Providers, so that we have Financial and Ops resilience.

## Piping.

Deck pipes, and so we want to keep that and be able to run on terminal and then just have NATS do the same.

Like here: https://github.com/cognos-io/chat.cognos.io/issues/129#issuecomment-2251865589

https://github.com/deliveryhero/pipeline Looks very good:
- Users: https://github.com/deliveryhero/pipeline/network/dependents?package_id=UGFja2FnZS0zMDQ1ODM5Mzgw

- https://github.com/search?q=repo%3ABillieM%2Fdj-management-utils%20pipeline&type=code
- https://github.com/jonahjunwu/sgpu/blob/main/gpuspd.go Looks like a Deck runner to me, and its mindlessly simple.
- https://github.com/darimuri/rod-remote Does Web scapping.

## JSON Schema Registry

So that all code using NATS can use JSONSchema to Validate data.

https://github.com/codegangsta/schema_registry


