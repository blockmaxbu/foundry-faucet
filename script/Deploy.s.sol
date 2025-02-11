//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Faucet} from "src/Faucet.sol";

contract Deploy is Script {

    constructor() {
        
    }

    function run() public returns (Faucet) {
        vm.startBroadcast();

        Faucet faucet = new Faucet();

        vm.stopBroadcast();
        return faucet;
    }

}