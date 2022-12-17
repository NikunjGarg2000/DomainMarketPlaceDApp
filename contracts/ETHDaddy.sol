// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// importing openzeppelin contracts to use ERC732 protocol which is a standard.
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ETHDaddy is ERC721{

    uint256 public maxSupply;

    // developer of NFT
    address public owner;

    struct Domain {
        string name;
        uint256 cost;
        bool isOwned;
    }

    mapping(uint256 => Domain) public domains;

    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner!");
        _;
    }

    constructor(string memory _name, string memory _symbol) 
        ERC721(_name, _symbol) 
    {
        // msg.sender giving the address of them who is calling constructor
        owner = msg.sender;
    }

    // only listing NFT, they will get mint(created) once someone buys them
    function list(string memory _name, uint256 _cost) public onlyOwner {
        maxSupply++;
        domains[maxSupply] = Domain(_name, _cost, false);
    }
}
