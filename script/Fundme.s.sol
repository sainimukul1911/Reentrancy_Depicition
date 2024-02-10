//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Fundme} from "../src/Fundme.sol";

contract FundmeScript is Script {
    function run() external returns (Fundme){
        vm.startBroadcast();
        Fundme fund = new Fundme();
        vm.stopBroadcast();
        return fund;
    }
}