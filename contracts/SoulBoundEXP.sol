//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract SoulBoundEXP is Ownable, ERC20 {
    error invalidMinter(address _minter);
    error isSoulBound();
    error lowBalance();

    /// @notice stores whether an address is an approved minter
    mapping(address => bool) public approvedMinters;

    constructor() ERC20("SoulBound", "SOUL") {}

    /// @notice sets Addresses which are approved to mint
    /// @param _minter Minter address which is able to mint the tokens
    /// @param isApproved Whether address is approved to mint
    function setApprovedMinter(address _minter, bool isApproved) public onlyOwner {
        require(_minter != address(0), "Should not be zero address");
        approvedMinters[_minter] = isApproved;
    }

    function mint(address to, uint256 amount) public {
        if (!approvedMinters[msg.sender]) revert invalidMinter(msg.sender);
        _mint(to, amount);
    }

     function burn(uint256 amount) public {
        // Only burners can burn
        if(balanceOf(msg.sender) > 0) revert lowBalance();
       _burn(msg.sender, amount);
    }

    function approve(address spender, uint256 amount) public virtual override returns(bool) {
        revert isSoulBound();
    }

    function transfer(address recipient, uint256 amount) public virtual override returns(bool) {
        revert isSoulBound();
    }

    function transferFrom(address sender, address recipient, uint256 amount) 
        public 
        virtual 
        override 
        returns(bool) {
            revert isSoulBound();
    }
}