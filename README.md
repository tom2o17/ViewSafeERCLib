
# Motivation 

Injectable contracts are important in order to efficiently query complex statistics on chain. However current ERC interfaces are not optimized for this practice. In addition ethereums "bubble up" reversions do not lend themselves well for enviroments in which the target contract may return a non-standardized information as well as instances in which target contracts do not exist at a given block. 

This library aims to solve this and make inejcted evm contracts utilizing this library more robust and revert less often. 

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