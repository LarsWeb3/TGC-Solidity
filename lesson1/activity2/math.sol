// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Math
 * @dev Does Math for you
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
contract Math {

    function add(uint8 x, uint8 y) public pure returns (uint8) {
        return  x + y;
    }

    // TODO: Task 1
    // 1. Declare a function called subtract that takes in a uint8 variable
    //    named whatever you wish and return the value of the variable minus 2

    // TODO: Task 2
    // 1. Declare a function called multiple that takes in two uint8 variables
    //    named whatever you wish and return the value of the variables multipled
    //    by each other

    // TODO: Task 3
    // 1. Declare a state variabled of type uint8 called z with a value of 2
    // 1. Declare a function called divide that takes in one uint8 variable
    //    named whatever you wish and return the value of the variable divided
    //    by the value of z
}