// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./02-PriceConvertor.sol";



contract FundMe {
    // using PriceConverter for uint256;
    uint256 public minUsd = 1 * 1e18;
    uint256 public result;
    address[] public funders;
    mapping(address => uint256) public addressToValue;
    address public owner;
    AggregatorV3Interface public priceFeed;

    constructor(address _priceFeed) {
        owner = msg.sender;
        priceFeed=AggregatorV3Interface(_priceFeed);
        
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function fund() public payable {
        require(
            PriceConverter.getConversionRate(msg.value,priceFeed) > minUsd,
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

        (bool sucess, /** function here  */) = owner.call{value: address(this).balance}("");
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
