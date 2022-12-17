// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// importing openzeppelin contracts to use ERC732 protocol which is a standard.
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ETHDaddy is ERC721{

    // theoritical no that can be minted
    uint256 public maxSupply;
    // actual no that has been minted
    uint256 public totalSupply;

    // developer of NFT
    address public owner;

    struct Domain {
        string name;
        uint256 cost;
        bool isOwned;
    }

    mapping(uint256 => Domain) domains;

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

    // using payable we can send some ether in while calling this function
    function mint(uint256 _id) public payable {
        require(_id != 0);
        require(_id <= maxSupply);
        require(domains[_id].isOwned == false);
        require(msg.value >= domains[_id].cost);

        domains[_id].isOwned = true;
        totalSupply++;
        // create nft from scratch coming from ERC721
        _safeMint(msg.sender, _id);
    }

    function getDomain(uint256 _id) public view returns (Domain memory) {
        return domains[_id];
    }

    // address(this) gives the address inside which smart contract resides
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function withdraw() public onlyOwner {
        // several ways to transfer ether in solidity
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success);
    }

}
