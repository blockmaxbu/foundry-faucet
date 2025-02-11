//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";

struct netConfig {
    uint256 chainId;
}

contract Config is Script {

    constructor() {
        
    }

    function run() public {
        
    }

    function getAnvilConfig() public pure returns (netConfig memory) {
        return netConfig({
            chainId: 137
        });
    }
}