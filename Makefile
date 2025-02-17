-include .env

.PHONY: all test clean deploy fund help install snapshot format anvil 

help:
	@echo "Usage:"
	@echo "  make deploy [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""
	@echo ""
	@echo "  make fund [ARGS=...]\n    example: make deploy ARGS=\"--network sepolia\""

# Update Dependencies
update:; forge update

build:; forge build

test:; forge test

coverage :; forge coverage --report debug > coverage-report

snapshot :; forge snapshot

format :; forge fmt

deploy:
	@echo "Deploying..."
	@echo $(TESTNET_RPC_URL)
	@forge script script/Deploy.s.sol --rpc-url $(TESTNET_RPC_URL) --private-key $(PRIVATE_KEY) --broadcast