#!/bin/bash

mv /opt/node/neo-cli/config.privatenet.json /opt/node/neo-cli/config.json
mv /opt/node/neo-cli/protocol.privatenet.json /opt/node/neo-cli/protocol.json
cd /opt/node/neo-cli/
screen -dmS node dotnet neo-cli.dll --log --rpc
screen -dmS o3explorer /opt/node/./o3explorer -node=http://localhost:30333
#wait 5 seconds
sleep 10

#Send all 100,000,000 from IssueTransaction to AVFobKv2y7i66gbGPAGDT67zv1RMQQj9GB
curl --request POST \
  --url http://localhost:30333/ \
  --header 'content-type: application/json' \
  --data '{
  "jsonrpc": "2.0",
  "method": "sendrawtransaction",
  "params": ["800000018f030a0f5948e1b8f33f3cbd0eda0a7e1fb0bcf9b3a2fe3b85ec027996b5e7160000019b7cffdaa674beae0f930ebe6085af9093e5fe56b34a5c220ccdcf6efc336fc50000c16ff286230093e1e5bed9159684ac8c2ee40d2077fbcfacf70a014140045c4f485ea102964e09afacebab3b8ddc295f63c4fda38972492a0a7d68fc1945ecacc8f8f6d0147b12f52732ed2ee3be8628f483f4abd170fed0bb1d61de29255121020ef8767aeb514780a8fb0a21f2568c521eb1e633a161dcdc39e78745762cb84351ae"],
  "id": 1
}'

cd /opt/node/neo-python/
np-prompt -p

sleep infinity
