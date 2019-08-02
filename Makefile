DEFAULT: start

build:
	docker build -t neo-privatenet .

run:
	docker run --name neo-privatenet -it -p 30333:30333 -p 3333:3333 -v $(shell pwd)/smartContracts:/opt/node/neo-python/smartContracts neo-privatenet:latest

start: build run
