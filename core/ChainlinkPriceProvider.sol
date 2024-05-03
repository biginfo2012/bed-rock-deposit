// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import { IPriceProvider } from "../interfaces/IPriceProvider.sol";
import { IChainlinkAggregator } from "../interfaces/IChainlinkAggregator.sol";

contract ChainlinkPriceProvider is IPriceProvider {
    uint256 _price;
    IChainlinkAggregator aggregator;
    uint8 constant STANDARD_DECIMALS = 18;

    constructor(address _aggregator) {
        aggregator = IChainlinkAggregator(_aggregator);
    }

    function setPrice(uint256 price) external {
        _price = price;
    }

    function getPrice() external view returns (uint256 price) {
        uint8 decimals = aggregator.decimals();
        int256 signedPrice = aggregator.latestAnswer();
        require(signedPrice >= 0, "Aggregator returns negative price");
        price = uint256(signedPrice);
        if (decimals < STANDARD_DECIMALS) price = price * 10**(STANDARD_DECIMALS - decimals);
        else if (decimals > STANDARD_DECIMALS) price = price / 10**(STANDARD_DECIMALS - decimals);
    }
}
