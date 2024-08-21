// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public _name;
    string public _symbol;
    uint256 public Totalsupply=40*10**18;
    uint8 public _decimals = 18;

    mapping(address => uint256) balences;
    mapping(address => mapping(address => uint256)) allowence;

    event TransFer (address indexed  from , address indexed to ,uint256 ammount);
    event Approved (address indexed  owner , address indexed sender ,uint256 value);

    constructor(string memory name_, string memory symbol_) {
        balences[msg.sender] = Totalsupply;
          _name = name_;
        _symbol = symbol_;
    }

    function name() public view virtual returns (string memory) {
            return _name;
        }

    function symbol() public view virtual returns (string memory) {
            return _symbol;
        }
    function balenceof (address owner) public view returns(uint256) { 
        return balences[owner];
    }
    function transfer (address to,uint256 value) public returns(bool){
        require(balences[msg.sender] > value ,"Balence is too Low");
        balences[to] +=value;
        balences[msg.sender] -= value;
        emit TransFer(msg.sender, to, value);
        return true;
    }
    function transeferFrom (address from,address to,uint256 value) public returns(bool){ 
        require(balences[from] > value ,"Balence is too Low");
        require(allowence[from][to] >= value,"allownce too low");
        balences[to] +=value;
        balences[from] -= value;
        emit TransFer(from, to, value);
        return true;
   }
    function approved (address spender ,uint256 value ) public returns(bool) {
        allowence[msg.sender] [spender]=value;
        emit Approved (msg.sender,spender,value);
        return true;
    }


}
