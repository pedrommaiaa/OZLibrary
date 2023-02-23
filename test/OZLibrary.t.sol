// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {OZLibrary} from "../src/OZLibrary.sol";
import {IERC20} from "openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20Mock} from "openzeppelin/contracts/mocks/ERC20Mock.sol";
import {ReturnsFalseToken} from "solmate/test/utils/weird-tokens/ReturnsFalseToken.sol";

contract OZLibraryTest is Test {
    OZLibrary public oz;
    ERC20Mock public token;
    ReturnsFalseToken public falseToken;

    function setUp() public {
        oz = new OZLibrary();
        falseToken = new ReturnsFalseToken();
        token = new ERC20Mock("ERC20Mock", "E20M", address(0xABCD), 0);
    }

    function testDoTransfer() external {
        vm.expectRevert(bytes("ERC20: transfer amount exceeds balance"));
        oz.doTransfer(token, address(0xBEEF), 1e18);
    }

    function testDoSafeTransfer() external {
        oz.doSafeTransfer(token, address(0xBEEF), 1e18);
    }

    function testDoSafeTransferFalseToken() external {
        vm.expectRevert(bytes("SafeERC20: ERC20 operation did not succeed"));
        oz.doSafeTransfer(IERC20(address(falseToken)), address(0xBEEF), 1e18);
    }

    function testDoTransferFrom() external {
        vm.expectRevert(bytes("ERC20: insufficient allowance"));
        oz.doTransferFrom(token, address(0xBEEF), address(this), 1e18);
    }

    function testDoSafeTransferFrom() external {
        oz.doSafeTransferFrom(token, address(0xBEEF), address(this), 1e18);
    }

    function testDoSafeTransferFromFalseToken() external {
        vm.expectRevert(bytes("SafeERC20: ERC20 operation did not succeed"));
        oz.doSafeTransferFrom(IERC20(address(falseToken)), address(0xBEEF), address(this), 1e18);
    }
}
