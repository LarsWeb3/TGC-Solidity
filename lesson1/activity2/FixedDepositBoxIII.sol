pragma solidity ^0.8.0;

import "./IERC20.sol"; // Assuming you have an ERC20 interface

contract FixedDepositBox {
    address public owner;
    uint256 public balance;
    mapping(address => uint256) public deposits;
    mapping(address => uint256) public depositTimestamps;

    constructor() {
        owner = msg.sender;
        balance = 0; // Initialize balance with zero
    }

    function deposit(address _token, uint256 _amount) external {
        require(_amount > 0, "Amount must be greater than zero");
        
        // Transfer tokens from user to contract
        IERC20 token = IERC20(_token);
        require(token.transferFrom(msg.sender, address(this), _amount), "Token transfer failed");
        
        // Update user's deposit information
        deposits[msg.sender] += _amount;
        depositTimestamps[msg.sender] = block.timestamp;
        
        // Update contract balance
        balance += _amount;
    }

    function withdrawal(address _token) external payable {
        require(msg.sender == owner, "Only owner can withdraw");
        
        // Transfer contract balance to owner
        if (_token == address(0)) {
            // If withdrawing ETH
            payable(owner).transfer(address(this).balance);
        } else {
            // If withdrawing tokens
            IERC20 token = IERC20(_token);
            token.transfer(owner, token.balanceOf(address(this)));
        }
        
        // Reset contract balance
        balance = 0;
    }

    // Fallback function to allow receiving ETH
    receive() external payable {
        balance += msg.value;
    }
}