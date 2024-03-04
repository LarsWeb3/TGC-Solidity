pragma solidity ^0.8.0;

contract FixedDepositBox {
    uint256 public investmentAmount;
    uint256 public duration;
    uint256 public interestRatePerHour;

    constructor(uint256 _investmentAmount, uint256 _duration, uint256 _interestRatePerHour) {
        investmentAmount = _investmentAmount;
        duration = _duration;
        interestRatePerHour = _interestRatePerHour;
    }

    function withdrawal() public view returns (uint256) {
        require(block.timestamp > (now() + duration), "Wait for the fixed deposit to mature before withdrawing");

        uint256 interest = (investmentAmount * interestRatePerHour * duration) / 3600;
        uint256 totalAmount = investmentAmount + interest;

        investmentAmount = 0;
        duration = 0;
        interestRatePerHour = 0;

        return totalAmount;
    }
}