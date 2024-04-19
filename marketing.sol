/**
 *
 *
   Reb Marketing Splitter Contract
   https://WillieClub.org
   https://x.com/WillieClub
   https://t.me/WillieClub
 */

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

// pragma solidity ^0.8.0;

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

// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

// pragma solidity ^0.8.0;

// import "../utils/Context.sol";

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

    string websiteLink = "https://github.com/roberts/reb";

    /**
     * @dev Updates the websiteLink string with a new value
     */
    function updateWebsiteLink(string calldata newLink) external onlyOwner {
        websiteLink = newLink;
    }

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

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
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
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

contract Marketing is Ownable {
    address payable public GorillaTeam =
        payable(0x907D8B91a49765A4A7d054e1878D8B063e685fdB);
    address payable public CutieTeam =
        payable(0x54c4AA27686BE6F9a0161a4929FA44D5d641d947);
    address payable public HustlerTeam =
        payable(0xC84c8B7A1F5924395CcCB190D9EC81eE17982EDC);

    constructor() {}

    function setGorillaTeamWallet(address payable _gorillaWallet) external onlyOwner {
        GorillaTeam = _gorillaWallet;
    }

    function setCutieTeamWallet(address payable _cutieWallet) external onlyOwner {
        CutieTeam = _cutieWallet;
    }

    function setHustlerTeamWallet(address payable _hustlerWallet) external onlyOwner {
        HustlerTeam = _hustlerWallet;
    }

    function sendStuckETH() external onlyOwner {
        (bool success, ) = owner().call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }

    receive() external payable {
        require(msg.value > 0, "No ether sent");

        uint wallet1Share = (msg.value * 50) / 100;
        uint wallet2Share = (msg.value * 25) / 100;
        uint wallet3Share = msg.value - wallet1Share - wallet2Share;

        GorillaTeam.transfer(wallet1Share);
        CutieTeam.transfer(wallet2Share);
        HustlerTeam.transfer(wallet3Share);
    }
}
