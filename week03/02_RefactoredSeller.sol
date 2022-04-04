//SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

contract BalelecTicketSeller {
    uint public price = 30;
    address public immutable owner;
    mapping(address => bool) public tickets;
    event Purchase(address buyer);

    /*
    * This error appears when ...
    * caller - the address of the users that called the function without being authorized...
    */
    error Unauthorized(address caller);
    error WrongAmount(uint amount);

    constructor(address _owner) {
        owner = _owner;
    }

    function SetPrice(uint newPrice) public onlyOwner {
        if (newPrice >= 100) {
            revert WrongAmount(newPrice);
        }
        price = newPrice;
    }

    //custom modifier
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
        _;
    }

    function BuyTicket() payable public {
        if (msg.value != price) {
            revert WrongAmount(msg.value);
        }
        tickets[msg.sender] = true;
        emit Purchase(msg.sender);
    }
}
