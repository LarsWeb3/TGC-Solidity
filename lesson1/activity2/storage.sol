// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2<0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Storage {
    uint256 public unlockTime;
    uint256 public number;
    uint8[10] public dataArray;
     
     constructor(uint256 duration) {
        uint256 currentTime = block.timestamp; // The current time when the smart contract is deployed
        unlockTime = currentTime + duration; // Assigning unlockTime using duration parameter

        uint8 i = 1;
        while(i < 11) {
            dataArray[i-1] = i;
            i++;
        }
    

    // You can add other functions or modify the contract as needed.


    // TODO: Task 1
    // 1. Change the constructor function to take in a parameter of type uint256 called duration
    // 2. Assign the state variable unlockTime to be the addition of currentTime and duration

    // CODE BLOCK //

    // END OF CODE BLOCK //
    }
    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function store(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256) {
        uint256 timeNow = block.timestamp; // The current time when the retrieve function is called

        // Task 2: Check if timeNow is greater than unlockTime
        if (timeNow > unlockTime) {
            return number; // Return number if timeNow is greater than unlockTime
        } else {
            return 0; // Return 0 if timeNow is not greater than unlockTime
        }


        // END OF CODE BLOCK //

        // TODO: Task 2
        // 1. Use a control flow to change the amount code so that it will only return
        //    the state variable number if the timeNow is greater than the unlockTime
        //    if not the function should return 0
    }

    /**
     * @dev Gets the sum of the data array based on the input into the function
     * @param n how many numbers you would like to add up
     * @return sum of the n number of items in the data array
     */
    function getSum(uint256 n) public view returns (uint8) {
        require(n <= 10, "Input should be less than or equal to 10");

        // Task 3: Use a control flow to add up the contents of the dataArray
        uint8 sum = 0;
        for (uint256 i = 0; i < n; i++) {
            sum += dataArray[i]; // Add the value at index i to sum
        }
        return sum;
    }
        // END OF CODE BLOCK //

        // TODO: Task 3
        // 1. Use a control flow to add up the contents of the dataArray from index 0 to
        //    index n (n is a parameter of the function getSum). Output the sum.
    }
