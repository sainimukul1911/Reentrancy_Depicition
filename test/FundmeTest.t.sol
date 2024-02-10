//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {console , Test} from "forge-std/Test.sol";
import {Fundme} from "../src/Fundme.sol";
import {FundmeScript} from "../script/Fundme.s.sol";
import {attacker} from "./Reentrancyattacker.sol";

contract FundmeTest is Test {
    Fundme fundme;
    address attackerr;
    address victim;
    attacker att;

    function setUp() public {
        FundmeScript script = new FundmeScript();
        fundme = script.run();
        attackerr = makeAddr("attacker");
        victim = makeAddr("victim");
        vm.deal(victim , 10 ether);
        att = new attacker();
        vm.deal(address(att) , 1 ether);
    }

    function testReentrancy() public{
        vm.prank(victim);
        fundme.fund{value: 10 ether}();
        vm.startPrank(attackerr);
        att.withdraw(address(fundme));
        att.withdrawFromContract(attackerr);
        vm.stopPrank();
        console.log(attackerr.balance);
        if(attackerr.balance!=11 ether){
            fail("Reentrancy failed");
        }
    }
}