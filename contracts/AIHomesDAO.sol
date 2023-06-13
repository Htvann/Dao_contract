// SPDX-License-Identifier: MIT
/**
 *Submitted for verification at BscScan.com on 2023-05-24
*/

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;


/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/security/Pausable.sol


// OpenZeppelin Contracts (last updated v4.7.0) (security/Pausable.sol)

pragma solidity ^0.8.0;


/**
 * @dev Contract module which allows children to implement an emergency stop
 * mechanism that can be triggered by an authorized account.
 *
 * This module is used through inheritance. It will make available the
 * modifiers `whenNotPaused` and `whenPaused`, which can be applied to
 * the functions of your contract. Note that they will not be pausable by
 * simply including this module, only once the modifiers are put in place.
 */
abstract contract Pausable is Context {
    /**
     * @dev Emitted when the pause is triggered by `account`.
     */
    event Paused(address account);

    /**
     * @dev Emitted when the pause is lifted by `account`.
     */
    event Unpaused(address account);

    bool private _paused;

    /**
     * @dev Initializes the contract in unpaused state.
     */
    constructor() {
        _paused = false;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not paused.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    modifier whenNotPaused() {
        _requireNotPaused();
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is paused.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    modifier whenPaused() {
        _requirePaused();
        _;
    }

    /**
     * @dev Returns true if the contract is paused, and false otherwise.
     */
    function paused() public view virtual returns (bool) {
        return _paused;
    }

    /**
     * @dev Throws if the contract is paused.
     */
    function _requireNotPaused() internal view virtual {
        require(!paused(), "Pausable: paused");
    }

    /**
     * @dev Throws if the contract is not paused.
     */
    function _requirePaused() internal view virtual {
        require(paused(), "Pausable: not paused");
    }

    /**
     * @dev Triggers stopped state.
     *
     * Requirements:
     *
     * - The contract must not be paused.
     */
    function _pause() internal virtual whenNotPaused {
        _paused = true;
        emit Paused(_msgSender());
    }

    /**
     * @dev Returns to normal state.
     *
     * Requirements:
     *
     * - The contract must be paused.
     */
    function _unpause() internal virtual whenPaused {
        _paused = false;
        emit Unpaused(_msgSender());
    }
}

// File: contracts/CreateDao.sol


pragma solidity ^0.8.9;




pragma solidity >=0.6.0 <0.9.0;

interface IBEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the token decimals.
     */
    function decimals() external view returns (uint8);

    /**
     * @dev Returns the token symbol.
     */
    function symbol() external view returns (string memory);

    /**
     * @dev Returns the token name.
     */
    function name() external view returns (string memory);

    /**
     * @dev Returns the bep token owner.
     */
    function getOwner() external view returns (address);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(
        address _owner,
        address spender
    ) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    function lockAddress(address account, uint256 amount) external;

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}
// File: contracts/LotteryOwnable.sol


contract AIHomesDAO is Pausable, Ownable {
    struct DA0Info {
        uint256 id;
        string name;
        address owner;
        uint256 option;
        uint256 createdAt;
        uint256 amount;
        address buyToken;
    }

    address constant BUSD = 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512;
    address constant USDT = 0x250b0Ae6Ec23805508E31714e3578b8B4Cbe5A3e;
    address constant AIHomesToken = 0x5FbDB2315678afecb367f032d93F642f64180aa3;

    address public receiveUSDAddress;
    address public sendHomesTokenAddress;

    uint256 public option1 = 5000 ether; // 5000 usd
    uint256 public option2 = 10000 ether; // 10000 usd
    uint256 public option3 = 15000 ether; // 15000 usd

    uint256 public profilesLength = 0;
    mapping(address => bool) public isOwnDao;
    mapping(address => DA0Info) public profiles;
    mapping(uint256 => DA0Info) public profilesById;
    mapping(string => bool) public isExistName;

    event CreateDAO(address owner,uint256 id, uint256 option, string name, uint256 amount, address buyToken, uint256 createdAt);

    constructor(address _receiveUSDAddress, address _sendHomesTokenAddress) {
        receiveUSDAddress = _receiveUSDAddress;
        sendHomesTokenAddress = _sendHomesTokenAddress;
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function updateReceiveUSDAddress(address _receiveUSDAddress) public onlyOwner {
        require(_receiveUSDAddress != address(0), "Can not set address 0");
        receiveUSDAddress = _receiveUSDAddress;
    }

    function updateSentHomesTokenAddress(address _sendHomesTokenAddress) public onlyOwner {
        require(_sendHomesTokenAddress != address(0), "Can not set address 0");
        sendHomesTokenAddress = _sendHomesTokenAddress;
    }

    function updateOption(uint256 _option, uint256 _amount) public onlyOwner {
        require(_option > 0 && _option < 4, "Invalid option");
        if (_option == 1) option1 = _amount;
        if (_option == 2) option2 = _amount;
        if (_option == 3) option3 = _amount;
    }

    function createDAO(string memory _name, address _buyToken, uint256 _option) whenNotPaused public {
        require(_option > 0 && _option < 4, "Invalid option");
        require(_buyToken == BUSD || _buyToken == USDT, "Invalid buy token");
        require(bytes(_name).length > 0, "Invalid name");
        require(isOwnDao[msg.sender] == false, "Address already has DAO");
        require(isExistName[_name] == false, "Name already exist");

        // Amount send, receive token
        uint256 amount = 0;
        if (_option == 1) amount = option1;
        if (_option == 2) amount = option2;
        if (_option == 3) amount = option3;
        // Do transfer token
        transferToken(msg.sender, _buyToken, amount);
        IBEP20(AIHomesToken).lockAddress(msg.sender, amount);

        // Create new profile
        DA0Info memory info;
        info.owner = msg.sender;
        info.option = _option;
        info.name = _name;
        info.createdAt = block.timestamp;
        info.amount = amount;
        info.buyToken = _buyToken;

        // Increase profile ID
        profilesLength++;
        info.id = profilesLength;

        // Add to list
        profiles[msg.sender] = info;
        profilesById[info.id] = info;

        // Update address created DAO
        isOwnDao[msg.sender] = true;
        isExistName[_name] = true;

        emit CreateDAO(msg.sender, info.id, _option, _name, amount, _buyToken, block.timestamp);
    }

    function transferToken(address _sender, address _buyToken, uint256 amount) private {
        IBEP20(_buyToken).transferFrom(_sender, receiveUSDAddress, amount);
        IBEP20(AIHomesToken).transferFrom(sendHomesTokenAddress, _sender, amount);
    }

}
