// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

// mapping balenceof
// set _transfer by add to,and minus from
// create transferFrom fuction

contract ManualToken {
    string private _name="asifDex";
    string private _symbol = "asd";
    uint8 private _decimals = 18;
    uint256 public totalSupply;

    // mapping
    mapping(address => uint256) balanceOf;
    mapping(address => mapping(address => uint256)) allowance; //checking allownce

    //    EVENT
    event transfer(
        address indexed from,
        address indexed to,
        uint256 ammount
    );
 
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
// CONSTRACTOR 
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * 10 ** uint256(_decimals);
        balanceOf[msg.sender] = totalSupply;
    }
//fUNCTION
function name() public view returns (string memory){
    return _name;
}
function symbol() public view returns (string memory){
return  _symbol;
}
function decimals() public view returns (uint8){
    return  _decimals;
}
    function _transfer(
        address _to,
        uint256 _ammount
    ) internal {
        require(_to !=address(0) ,"invelid adress");
         require(balanceOf[msg.sender] >= _ammount, "Insufficient balance");
        balanceOf[msg.sender] -= _ammount;
        balanceOf[_to] += _ammount;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool sucessed) {
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        emit transfer(_from, _to, _value);
        return true;
    }
    function approval(address _spender, uint256 _value) public returns (bool sucessed){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender, _value);
        return true;
    }
}
