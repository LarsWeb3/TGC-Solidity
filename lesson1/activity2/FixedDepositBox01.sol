// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**

contract FixedDepositBox {
    address owner;
    uint256 initialInvestment;
    uint256 duration; // in seconds
    uint256 interestRatePerHour;
    uint256 withdrawTimestamp;
    bool withdrawn;

    constructor(uint256 _initialInvestment, uint256 _durationMinutes, uint256 _interestRatePerHour) {
        owner = msg.sender;
        initialInvestment = _initialInvestment;
        duration = _durationMinutes * 1 minutes; // Convert duration from minutes to seconds
        interestRatePerHour = _interestRatePerHour;
        withdrawn = false;
        withdrawTimestamp = block.timestamp + duration;
    }

    function withdrawal() public returns (uint256) {
        require(msg.sender == owner, "Only owner can withdraw");
        require(!withdrawn, "Already withdrawn");

        if (block.timestamp >= withdrawTimestamp) {
            uint256 elapsedTime = block.timestamp - (withdrawTimestamp - duration);
            uint256 interestEarned = (initialInvestment * interestRatePerHour * elapsedTime) / (100 * 3600); // Calculate interest earned
            uint256 totalAmount = initialInvestment + interestEarned;
            withdrawn = true;
            payable(msg.sender).transfer(totalAmount);
            return totalAmount;
        } else {
            revert("Withdrawal is not yet available");
        }
    }

    receive() external payable {
        revert("This contract does not accept Ether directly");
    }
}
