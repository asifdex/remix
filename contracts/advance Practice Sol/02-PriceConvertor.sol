// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
  //if you use library make it public => internal
  function getPrice(AggregatorV3Interface priceFeed) internal view returns (uint256) {
    // ABI
    // address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
    (, int256 price, , , ) = priceFeed.latestRoundData();
    return uint256(price * 1e10);
  }



  function getConversionRate(
    uint256 ethamount , AggregatorV3Interface priceFeed
  ) internal view returns (uint256) {
    uint256 ethPrice = getPrice(priceFeed);
    uint256 ethAmmountInUsd = (ethPrice * ethamount) / 1e18;
    return ethAmmountInUsd;
  }
}
