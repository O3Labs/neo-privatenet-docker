# NEO private net with Docker
Aiming to make it easier for developers to run NEO blockchain network locally for local developments or learning purposes.

# What does it do?
It will spin up a RPC-enabled node in a single-node consensus mode.

## Build
> docker build -t neo-privatenet .

## Run
> docker run -it -p 30333:30333 neo-privatenet:latest

### Address contains all 100,000,000 NEO
> AVFobKv2y7i66gbGPAGDT67zv1RMQQj9GB

### JSON-RPC endpoint
> http://localhost:30333
