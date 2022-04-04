//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;


contract BalelecTicketSeller {
    uint public price;
    uint public immutable priceAfterThreshold;
    uint public immutable threshold;
    uint public ticketsCounter = 0; 
    mapping(address => bool) public tickets;
    event Purchase(address buyer);

    
    constructor(
        uint _threshold,
        uint _price,
        uint _priceAfterThreshold) {
        priceAfterThreshold = _priceAfterThreshold;
        price = _price;
        threshold = _threshold;
    }

    function getPrice() public view returns (uint) {
        return ticketsCounter <= threshold ? price : priceAfterThreshold;
    }

    function buyTicket() public payable {
        require(msg.value == getPrice(), "You're not paying the correct amount");
        tickets[msg.sender] = true;
        ++ticketsCounter;
        emit Purchase(msg.sender);
    }
}
