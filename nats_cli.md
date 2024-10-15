# NATS CLI


## dep

# If we are already inside .dep, we want to use a NATS BUCKET as a file system.

# 0. Fix the copy over itself problem.
# 1. Need a nats-obj-pushlist, to push to NATS Obj
# 2. Need a nats-obj-pull, to once only update local
# 3. Need a nats-obj-watch, to constanlty update.

# Lets play with nats cli, and see if we can wrap our current .mk files to magically use nats.
