// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Mytoken is ERC20{
    uint256 public initialSupply = 2*10**18;
    constructor( ) ERC20("MyToken", "MT") {
        _mint(msg.sender, initialSupply);
    }
}