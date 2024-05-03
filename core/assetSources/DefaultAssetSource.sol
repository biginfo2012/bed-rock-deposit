// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

import { IAssetSourcer } from "../../interfaces/IAssetSourcer.sol";

contract DefaultAssetSourcer is IAssetSourcer, Ownable {
    using SafeERC20 for IERC20;

    bool public initialized;

    constructor() {}

    function initialize() external {
        require(!initialized, "Already initialized");
        initialized = true;
        _transferOwnership(msg.sender);
    }

    function onDeposit(address token, uint256 amount) external onlyOwner {
        IERC20(token).safeTransferFrom(msg.sender, address(this), amount);
    }

    function onWithdraw(address token, uint256 amount) external onlyOwner {
        IERC20(token).safeTransfer(msg.sender, amount);
    }
}
