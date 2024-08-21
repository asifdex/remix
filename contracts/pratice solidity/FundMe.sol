// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
import "./PriceConverter.sol";

error fundme();

contract FundMe {
    uint256 public minUsd = 1 * 1e18;
    uint256 public result;
    address[] public funders;
    mapping(address => uint256) public addressToValue;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function fund() public payable {
        require(
            PriceConverter.getConversionRate(msg.value) > minUsd,
            "don't have enogh gas"
        );
        funders.push(msg.sender);
        addressToValue[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 fundIdx = 0; fundIdx < funders.length; fundIdx++) {
            address funder = funders[fundIdx];
            addressToValue[funder] = 0;
        }
        // reset array
        funders = new address[](0);

        (bool sucess, ) = owner.call{value: address(this).balance}("");
        require(sucess, "failed withdraw");
    }

    receive() external payable {
        fund();
        result = 1;
    }

    fallback() external payable {
        fund();
        result = 2;
    }
}
