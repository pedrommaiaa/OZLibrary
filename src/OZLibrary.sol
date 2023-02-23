// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IERC20} from "openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract OZLibrary {
    using SafeERC20 for IERC20;

    function doTransfer(IERC20 asset, address to, uint256 value) external {
        asset.transfer(to, value);
    }

    function doSafeTransfer(IERC20 asset, address to, uint256 value) external {
        asset.safeTransfer(to, value);
    }

    function doTransferFrom(IERC20 asset, address from, address to, uint256 value) external {
        asset.transferFrom(from, to, value);
    }

    function doSafeTransferFrom(IERC20 asset, address from, address to, uint256 value) external {
        asset.safeTransferFrom(from, to, value);
    }
}
