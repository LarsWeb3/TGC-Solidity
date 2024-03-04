// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
contract FixedDepositBox {
    address public owner;
    uint256 public investmentAmount;
    uint256 public duration;
    uint256 public interestRatePerHour;
    uint256 public startTime;
    bool public withdrawn;

    constructor(uint256 _investmentAmount, uint256 _durationMinutes, uint256 _interestRatePerHour) {
        owner = msg.sender;
        investmentAmount = _investmentAmount;
        duration = _durationMinutes * 1 minutes;
        interestRatePerHour = _interestRatePerHour;
        startTime = block.timestamp;
        withdrawn = false;
    }

    function withdrawal() external {
        require(msg.sender == owner, "Only owner can withdraw.");
        require(!withdrawn, "Funds already withdrawn.");

        uint256 elapsedTime = block.timestamp - startTime;

        require(elapsedTime >= duration, "Duration not completed yet.");

        uint256 interestEarned = (investmentAmount * interestRatePerHour * elapsedTime) / (1 hours * 100);
        uint256 totalAmount = investmentAmount + interestEarned;

        withdrawn = true;
        
        payable(owner).transfer(totalAmount);
    }
}
