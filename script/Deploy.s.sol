//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Faucet} from "src/Faucet.sol";

contract Deploy is Script {

    constructor() {
        
    }

    function run() public returns (Faucet) {
        // string memory privateKey = vm.envString("PRIVATE_KEY"); // load private_key from .env file

        // vm.startBroadcast(privateKey);
        vm.startBroadcast();

        Faucet faucet = new Faucet();

        vm.stopBroadcast();
        return faucet;
    }

}