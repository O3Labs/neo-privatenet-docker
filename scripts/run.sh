#!/bin/bash

mv /opt/node/neo-cli/config.privatenet.json /opt/node/neo-cli/config.json
mv /opt/node/neo-cli/protocol.privatenet.json /opt/node/neo-cli/protocol.json
cd /opt/node/neo-cli/
dotnet neo-cli.dll --log --rpc