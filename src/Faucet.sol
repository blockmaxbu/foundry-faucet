//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Faucet {

    error Faucet__amountTooLarge();
    error Faucet__rateLimt();

    event Withdrawal(address indexed to, uint amount);

    mapping(address => uint) private lastAccessTime;

    /**
     * @notice Withdraw ether from faucet
     */
    function withdraw(uint withdraw_amount) public {
        if (withdraw_amount > 0.1 ether) {
            revert Faucet__amountTooLarge();
        }
        if(block.timestamp < lastAccessTime[msg.sender] + 1 days) {
            revert Faucet__rateLimt();
        }
        payable(msg.sender).transfer(withdraw_amount);
        lastAccessTime[msg.sender] = block.timestamp;
        emit Withdrawal(msg.sender, withdraw_amount);
    }

    receive() external payable {}
}
