// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title ViewSafeERC
 */
library ViewSafeERC {

    /*
    <*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
    <*>                      CORE                            <*>
    <*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
    */

    /// @notice Non Reverting view Function to return the `decimals()` of a contract else `0`
    /// @param token Target token address to fetch decimals of
    function safeDecimals(IERC20 token) internal view returns (uint256 decimals) {
        if (address(token) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
            return 18;
        }
        if (!isContract(address(token))) return 0;
        (bool success, bytes memory ret) = address(token).staticcall(abi.encodeWithSignature("decimals()"));
        if (ret.length > 0 && success) {
            decimals = abi.decode(ret, (uint8));
        } else {
            decimals = 0;
        }
    }


    /// @notice Non Reverting view function to return `symbol()` of a contract else `""`
    /// @param token Target token address to fetch the symbol of 
    function safeSymbol(IERC20 token) internal view returns(string memory sy) {
        if (address(token) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
            return "ETH";
        }
        if (!isContract(address(token))) return "";
        (bool success, bytes memory ret) = address(token).staticcall(abi.encodeWithSignature("symbol()"));
        if (ret.length > 0 && success) {
            sy = trimPadding(ret);
        } else {
            sy = "";
        }
    }

    /// @notice Non Reverting view Function to return the `balanceOf(address)` of a contract
    /// @param token Target token address to fetch decimals of
    /// @param user  The address of the user to fetch the balance of
    function safeBalanceOf(IERC20 token, address user) internal view returns (uint256 balance) {
        if (address(token) == 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE) {
            return user.balance;
        }
        if (!isContract(address(token))) return 0;
        (bool success, bytes memory ret) = address(token).staticcall(abi.encodeWithSignature("balanceOf(address)", user));
        if (ret.length > 0 && success) {
            balance = abi.decode(ret, (uint256));
        } else {
            balance = 0;
        }
    }

    /*
    <*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
    <*>                   HELPERS                            <*>
    <*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
    */

   /// @notice Helper function to determine if an address has a !0 codesize
   function isContract(address addr) internal view returns (bool) {
        uint size;
        assembly { size := extcodesize(addr) }
        return size > 0;
    }

    /// @notice Helper Function to trim leading padding on bytes
    function trimPadding(bytes memory data) internal pure returns (string memory) {
        uint256 length = data.length;

        // Find the length of the non-zero data
        while (length > 0 && data[length - 1] == 0) {
            length--;
        }

        // Create a new bytes array without the trailing zeros
        bytes memory trimmedData = new bytes(length);
        for (uint256 i = 0; i < length; i++) {
            trimmedData[i] = data[i];
        }

        return string(trimmedData);
    }
}