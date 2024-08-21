// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "./SimpleStorage.sol";


contract NewSimpleStorage {
  
    SimpleStorages[] public simpleStorageArray; 

    function newContract ()public {
        SimpleStorages simpleStorages =new SimpleStorages();
        simpleStorageArray.push(simpleStorages);

    }
 
    function storeContract (uint256 _idx , uint256 _number ) public { 
       return SimpleStorages(simpleStorageArray[_idx]).store(_idx + _number );//1,7
    }

    function getStore (uint256 _idx) public view returns(uint256){
            return SimpleStorages(simpleStorageArray[_idx]).readOnly();

    }

}