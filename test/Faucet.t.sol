//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Faucet} from "src/Faucet.sol";
import {Deploy} from "script/Deploy.s.sol";

contract FaucetTest is Test {
    Faucet faucet;

    address testUser = makeAddr("testUser");

    function setup() public {
        Deploy deploy = new Deploy();
        faucet = deploy.run();

        //transfer some funds to the faucet
        //put it here, so for the production, we can fund the faucet manually, for security reasons.
        vm.startBroadcast();
        vm.deal(address(faucet), 100 ether);
        vm.stopBroadcast();
    }

    function test_withdrawTooLarge() public {
        vm.prank(testUser);
        vm.expectRevert(Faucet.Faucet__amountTooLarge.selector);
        faucet.withdraw(10 ether);
    }

    function test_withdraw(uint amount) public {
        vm.prank(testUser);
        uint _amount = amount % 0.1 ether;
        faucet.withdraw(_amount);
        assertEq(address(testUser).balance, _amount);
    }

    function test_rateLimit() public {
        vm.prank(testUser);
        faucet.withdraw(0.01 ether);
        vm.expectRevert(Faucet.Faucet__rateLimit.selector);
        faucet.withdraw(0.01 ether);
    }
}