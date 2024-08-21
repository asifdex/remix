// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import "./SimpleStorage.sol";

contract ExtraStore is SimpleStorages {
//virtual,override 
function store (uint256 _favnum) override public{
    myFavNum=_favnum+5;
}
}