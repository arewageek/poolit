// SPDX-License-Identifier: MIT

/// @title Poolit Smart contract for creating lottery dApps
/// @author @arewageek

pragma solidity ^0.8.19;

contract Poolit {
    address owner;
    address payable[] participants;
    address payable winner;
    
    constructor () {
        owner = msg.sender;
    }

    function joinDraw () public payable {
        require(msg.value >= 1, "You need at least one ether to join this draw");
        participants.push(payable(msg.sender));
    }

    function randomNumGenerator () internal view returns(uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.timestamp, participants.length)));
    }

    function pickWinner() public {
        return (participants.length >= 3, "Three participants are required to execute");

        uint r = randomNumGenerator();
        uint winnerIndex = r % participants.length;

        winner = participants[winnerIndex];
        
        winner.transfer(address(this).balance);

        participants = new address payable[](0);
    }
}