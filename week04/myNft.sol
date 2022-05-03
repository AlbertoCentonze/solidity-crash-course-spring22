// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BalelecTickets is ERC721, Ownable {
    constructor(address newOwner) ERC721("BalelecTickets", "BTK") {
        _transferOwnership(newOwner);
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}
