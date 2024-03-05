pragma solidity 0.8.24;

contract FixedDepositBox {
    address owner;
    mapping(address => string) passwords;
    uint256 balance;
    uint256 unlockTime;
    uint256 initialInvestment;
    uint256 duration; // in seconds
    uint256 interestRatePerHour;
    bool withdrawn;

    constructor(uint256 _initialInvestment, uint256 _durationMinutes, uint256 _interestRatePerHour) {
        owner = msg.sender;
        initialInvestment = _initialInvestment;
        duration = _durationMinutes * 1 minutes; // Convert duration from minutes to seconds
        interestRatePerHour = _interestRatePerHour;
        withdrawn = false;
        unlockTime = block.timestamp + duration;
    }

    function deposit(uint256 _amount, uint256 _durationMinutes, uint256 _interestRatePerHour, string memory _password) public {
        require(msg.sender != owner, "Owner cannot deposit funds");
        
        passwords[msg.sender] = _password;
        
        balance += _amount;
        
        // Update contract parameters if new values are provided
        if (_durationMinutes != 0) {
            duration = _durationMinutes * 1 minutes;
            unlockTime = block.timestamp + duration;
        }
        if (_interestRatePerHour != 0) {
            interestRatePerHour = _interestRatePerHour;
        }
    }

    function withdrawal(string memory _password) public returns (uint256) {
        require(msg.sender == owner, "Only owner can withdraw");
        require(!withdrawn, "Already withdrawn");
        require(keccak256(bytes(passwords[msg.sender])) == keccak256(bytes(_password)), "Invalid password");

        if (block.timestamp >= unlockTime) {
            uint256 elapsedTime = block.timestamp - (unlockTime - duration);
            uint256 interestEarned = (initialInvestment * interestRatePerHour * elapsedTime) / (100 * 3600); // Calculate interest earned
            uint256 totalAmount = initialInvestment + interestEarned;
            withdrawn = true;
            balance -= totalAmount;
            payable(msg.sender).transfer(totalAmount);
            return totalAmount;
        } else {
            revert("Withdrawal is not yet available");
        }
    }

    receive() external payable {
        balance += msg.value;
    }
}
