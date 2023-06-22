// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract ContractSwap is PausableUpgradeable, OwnableUpgradeable {

    address public BUSD;
    address public HOMES;

    address public accountSendingToken;

    event Faucet(address by, uint256 amount,  uint256 timeStamp);
    event Swap(address by,address token, uint256 amount, uint256 timeStamp);

    constructor( address _accountReceiveSendingToken, address _BUSD, address _HOMES) {
        _disableInitializers();
        accountSendingToken = _accountReceiveSendingToken;
        BUSD= _BUSD;
        HOMES= _HOMES;
    }

    function pause() public onlyOwner {
       _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function faucet() public whenNotPaused {
        IERC20 erc20A = IERC20(BUSD);
        require(erc20A.balanceOf(accountSendingToken) >=100 ether, "Not enough balance");
        SafeERC20.safeTransferFrom(erc20A, accountSendingToken,msg.sender,100 ether);

        emit Faucet(msg.sender, 100 ether, block.timestamp);
    }

    function swap(uint256 _amount) public whenNotPaused {
        IERC20 erc20_BUSD = IERC20(BUSD);
        IERC20 erc20_HOMES = IERC20(HOMES);

        require(erc20_BUSD.balanceOf(msg.sender) >=_amount, "Not enough balance BUSD");
        require(erc20_HOMES.balanceOf(accountSendingToken) >=_amount, "Not enough balance HOMES");
        
        SafeERC20.safeTransferFrom(erc20_BUSD,msg.sender,accountSendingToken,_amount);
        SafeERC20.safeTransferFrom(erc20_HOMES,accountSendingToken,msg.sender,_amount);

        emit Swap(msg.sender,BUSD, _amount, block.timestamp);
    }
}
