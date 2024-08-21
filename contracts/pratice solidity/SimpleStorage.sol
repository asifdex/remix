// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SimpleStorages {
    uint256 public myFavNum;

// create an data structure 
    struct People{
        string name;
        uint256 favouriteNum;
    }
    // mapping over number to data 
    mapping (uint256 => string ) public mappingovervalue;

// create an array

    People[] public person;

    function store (uint256 _myfavNum)public virtual { 
        myFavNum=_myfavNum;
    }
    // view and pure function ,when caller alone ,don't spend gas 
    function readOnly() public view returns (uint256){
        return myFavNum ;
        
    }
    function addPerson  (string memory _name, uint256 _favouriteNum) public{
        person.push(People(_name,_favouriteNum));
        mappingovervalue[ _favouriteNum]=_name;
    }
    
}