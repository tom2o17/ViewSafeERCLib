// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test, console } from "forge-std/Test.sol";
import { ViewSafeERC } from "src/ViewSafeERC.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

contract TestViewSafeERC is Test {
    address user = 0x59564B6646317cC73437a2b810494BA7E61C0d11;

    using ViewSafeERC for IERC20;
    using ViewSafeERC for IERC20Metadata;

    function setUp() public {
        vm.createSelectFork(vm.envString("MAINNET_URL"), 20656825);
    }

    function testFail_decimals_erc721() public {
        IERC20Metadata(0xBd3531dA5CF5857e7CfAA92426877b022e612cf8).decimals();
    }

    function test_safeDecimals_erc721() public {
        uint ret = IERC20Metadata(0xBd3531dA5CF5857e7CfAA92426877b022e612cf8).safeDecimals();
        assertEq(0, ret);
    }

    function testFail_symbol_nonstandardSymbol() public {
        IERC20Metadata(0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359).symbol();
    }

    function test_safeSymbol() public {
        string memory symbol = IERC20Metadata(0x89d24A6b4CcB1B6fAA2625fE562bDD9a23260359).safeSymbol();
        assertEq(symbol, "DAI");
    }

    function test_safeBalaneOf_eip7528() public {
        uint val = IERC20(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE).safeBalanceOf(user);
        assertEq(val, 6.953991976730537459 ether);
    }

    function testFail_balanceOf_eip7528() public {
        IERC20(0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE).balanceOf(user);
    }

    function test_safeBalanceOf_contractDoesNotExist() public {
        uint bal = IERC20(address(0)).safeBalanceOf(user);
        assertEq(bal, 0);
    }

    function test_safeDecimals_contractDoesNotExist() public {
        uint dec = IERC20Metadata(address(0)).safeDecimals();
        assertEq(dec, 0);
    }

    function test_safeSymbol_contractDoesNotExist() public {
        string memory sy = IERC20Metadata(address(0)).safeSymbol();
        assertEq(sy, "");
    }

    function testFail_balanceOf_contractDoesNotExist() public {
        IERC20(address(0)).balanceOf(user);
    }

    function testFail_decimals_contractDoesNotExist() public {
        IERC20Metadata(address(0)).decimals();
    }

    function testFail_symbol_contractDoesNotExist() public {
        IERC20Metadata(address(0)).symbol();
    }


}