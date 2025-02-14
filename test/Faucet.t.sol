//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Faucet} from "src/Faucet.sol";
import {Deploy} from "script/Deploy.s.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract FaucetTest is Test {
    using Strings for uint;

    Faucet faucet;

    address testUser = makeAddr("testUser");
    address testUser2 = makeAddr("testUser2");

    mapping(address => bool) prankList;

    function setUp() public {
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
        address raddomUser = makeAddr(amount.toString());
        vm.prank(raddomUser);
        uint _amount = amount % 0.1 ether;
        if(prankList[raddomUser]) {
            vm.expectRevert(Faucet.Faucet__rateLimit.selector);
        }
        faucet.withdraw(_amount);
        prankList[raddomUser] = true;
        assertEq(address(raddomUser).balance, _amount);
    }

    // function test_rateLimit() public {
    //     vm.prank(testUser);
    //     faucet.withdraw(0.01 ether);
    //     assertEq(address(testUser).balance, 0.01 ether);

    //     vm.warp(block.timestamp + 2 days);
    //     faucet.withdraw(0.01 ether);

    //     vm.expectRevert(Faucet.Faucet__rateLimit.selector);
    //     faucet.withdraw(0.01 ether);
    // }
}