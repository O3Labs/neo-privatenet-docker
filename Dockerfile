FROM microsoft/dotnet:2.1.4-runtime-bionic

ARG NEO_CLI_VERSION="2.10.2"

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies:
RUN apt-get update && apt-get install -y \
    libleveldb-dev \
    sqlite3 \
    libsqlite3-dev \
    libunwind8-dev \
    wget \
    expect \
    screen \
    zip \
    curl \
    git-core \
    python3.6 \
    python3.6-dev \
    python3.6-venv \
    python3-pip \
    libssl-dev \
    vim \
    man


RUN apt-get install -y apt-transport-https

RUN wget -O /opt/neo-cli.zip "https://github.com/neo-project/neo-cli/releases/download/v$NEO_CLI_VERSION/neo-cli-linux-x64.zip" && unzip -q -d /opt/node /opt/neo-cli.zip && rm /opt/neo-cli.zip

RUN wget -O /opt/ApplicationLogs.zip "https://github.com/neo-project/neo-plugins/releases/download/v$NEO_CLI_VERSION/ApplicationLogs.zip" && unzip -q -d /opt/node/neo-cli /opt/ApplicationLogs.zip && rm /opt/ApplicationLogs.zip

RUN wget -O /opt/RpcSystemAssetTracker.zip "https://github.com/neo-project/neo-plugins/releases/download/v$NEO_CLI_VERSION/RpcSystemAssetTracker.zip" && unzip -q -d /opt/node/neo-cli /opt/RpcSystemAssetTracker.zip && rm /opt/RpcSystemAssetTracker.zip

RUN wget -O /opt/RpcNep5Tracker.zip "https://github.com/O3Labs/o3-explorer-plugins/releases/download/$NEO_CLI_VERSION/RpcNep5Tracker.zip" && unzip -q -d /opt/node/neo-cli /opt/RpcNep5Tracker.zip && rm /opt/RpcNep5Tracker.zip

RUN wget -O /opt/ExplorerRPC.zip "https://github.com/O3Labs/o3-explorer-plugins/releases/download/$NEO_CLI_VERSION/ExplorerRPC.zip" && unzip -q -d /opt/node/neo-cli /opt/ExplorerRPC.zip && rm /opt/ExplorerRPC.zip


RUN wget -O /opt/o3explorer.zip "https://github.com/O3Labs/neo-privatenet-docker/releases/download/v0.1/o3explorer.zip" && unzip -q -d /opt/node /opt/o3explorer.zip && rm /opt/o3explorer.zip

RUN wget -O /opt/neo-python.zip "https://github.com/CityOfZion/neo-python/archive/v0.8.4.zip" && unzip -q -d /opt/node /opt/neo-python.zip && rm /opt/neo-python.zip

RUN mv /opt/node/neo-python-0.8.4 /opt/node/neo-python
WORKDIR /opt/node/neo-python
RUN pip3 install -e .

ADD ./configs/protocol.privatenet.json /opt/node/neo-python/neo/data
RUN mv /opt/node/neo-python/neo/data/protocol.privatenet.json /opt/node/neo-python/neo/data/protocol.privnet.json

ADD ./configs/* /opt/node/neo-cli/

ADD ./wallets/* /opt/node/neo-cli/

ADD ./wallets/privnet.wallet /opt/node/neo-python/wallets/

ADD ./scripts/run.sh /opt/

CMD ["/bin/bash", "/opt/run.sh"]
