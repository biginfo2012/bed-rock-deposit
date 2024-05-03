// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

interface IChainlinkAggregator {
    function latestAnswer() external view returns (int256);

    function decimals() external view returns (uint8);
}
