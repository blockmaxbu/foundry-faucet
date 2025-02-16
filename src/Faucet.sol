//SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Faucet {

    error Faucet__amountTooLarge();
    error Faucet__rateLimit();

    event Withdrawal(address indexed to, uint amount);

    mapping(address => uint) private lastAccessTime;

    /**
     * @notice Withdraw ether from faucet
     */
    function withdraw(uint withdraw_amount) public {
        if (withdraw_amount > 0.1 ether) {
            revert Faucet__amountTooLarge();
        }
        // once per day
        if(block.timestamp > lastAccessTime[msg.sender] + 1 days) {
            revert Faucet__rateLimit();
        }
        lastAccessTime[msg.sender] = block.timestamp;
        payable(msg.sender).transfer(withdraw_amount);
        emit Withdrawal(msg.sender, withdraw_amount);
    }

    /**
     * @notice Receive ether， people can send ether that they are not gonna use to this contract
     */
    receive() external payable {}
}
