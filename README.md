
# 🤔 Motivation 🤔

Injectable contracts are important in order to efficiently query complex statistics on chain. However current ERC interfaces are not optimized for this practice. In addition the EVMs "bubble up" reversions do not lend itself well for enviroments in which the target contract: returns non-standardized information, does not exist at a given block, does not expose a standard function selector, or any instance in which the outermost function ought not revert if a sub-view function does.

This library aims to solve this and make inejcted evm contracts utilizing this library more robust and have outermost view function calls revert less often. 

# ⚠️ Disclaimer ⚠️

This library is not intended to be used in deployed contracts dealing with value transfer.
<br>
For these cases the evm "bubble up" reversion is desirable. Use at own risk. 

## Usage
```solidity
contract ToInject {
    using ViewSafeERC for IERC20;
    using ViewSafeERC for IERC20Metadata;

    // Use IERC20 and IERC20 metadata as normal w/ view safe 
    // `safe...(args)` function variants for cases in which 
    // it is non-desirable to have the parent function revert
}
```

### Build
```shell
$ forge build
```

### Test
```shell
$ forge test
```