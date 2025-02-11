//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Faucet} from "src/Faucet.sol";

contract FaucetTest is Test {

    function test_withdraw() public {
        Faucet faucet = new Faucet();
        faucet.deposit{value: 1 ether}();
    }

}