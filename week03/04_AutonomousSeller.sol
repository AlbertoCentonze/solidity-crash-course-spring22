//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract BalelecTicketSeller {
    uint public immutable price;
    uint public immutable priceAfterThreshold;
    uint public immutable threshold;
    uint public ticketsCounter = 0; 
    mapping(address => bool) public tickets;
    event Purchase(address buyer);

    /*
    * This error appears when ...
    * caller - the address of the users that called the function without being authorized...
    */
    error Unauthorized(address caller);
    error WrongAmount(uint amount);

    constructor(
        uint _threshold,
        uint _price,
        uint _priceAfterThreshold)
    {
        priceAfterThreshold = _priceAfterThreshold;
        price = _price;
        threshold = _threshold;
    }


    function getPrice() public view returns (uint) {
        return ticketsCounter <= threshold ? price : priceAfterThreshold;
    }

    function BuyTicket() payable public {
        if (msg.value != getPrice()) {
            revert WrongAmount(msg.value);
        }
        tickets[msg.sender] = true;
        emit Purchase(msg.sender);
        ++ticketsCounter;
    }
}
