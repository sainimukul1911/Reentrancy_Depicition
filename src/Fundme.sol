//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Fundme {

    mapping (address => uint256) private balancee;

    function fund() external payable{
        if(msg.value == 0){
            revert("msgval is 0");
        }
        balancee[msg.sender] += msg.value;
    }

    function withdraw() external{
        if(balancee[msg.sender] == 0){
            revert("zero balance");
        }
        (bool success,) = msg.sender.call{value: balancee[msg.sender]}("");
        if(!success){
            revert("Transaction Failed");
        }
        balancee[msg.sender] = 0;
    } 
}