// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// importing openzeppelin contracts to use ERC732 protocol which is a standard.
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ETHDaddy is ERC721{

    // developer of NFT
    address public owner;

    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) 
    {
        // msg.sender giving the address of them who is calling constructor
        owner = msg.sender;
    }
}
