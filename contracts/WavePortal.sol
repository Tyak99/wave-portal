// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;
  uint private seed;
  event newWave(address indexed from, uint timestamp, uint amountEarned, string message);

  struct Wave {
    address waver;
    string message;
    uint amountEarned;
    uint timestamp;
  }

  Wave[] waves;

  mapping(address => uint) public lastWavedAt;

  constructor() payable {
    console.log('Contract has been initialized');
  }

  function wave(string memory _message) public {
    require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "Wait 30 seconds before another wave");
    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves += 1;
    console.log("%s waved", msg.sender, _message);
    

    uint amountEarned = 0 ether;
    uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
    seed = randomNumber;

    if (randomNumber < 50) {
      console.log("%s won", msg.sender);
      uint prizeAmount = 0.0001 ether;

      require(prizeAmount <= address(this).balance, 'You are trying to withdraw more than you have');
      (bool success,) = (msg.sender).call{value: prizeAmount}("");
      require(success, 'Failed to withdraw money from the contract');

      amountEarned = prizeAmount;
    }
    console.log("I earned", amountEarned);

    Wave memory waver = Wave(msg.sender, _message, amountEarned, block.timestamp);
    waves.push(waver);
    emit newWave(msg.sender, block.timestamp, amountEarned, _message);

  }

  function getTotalWaves() view public returns (uint) {
    console.log('We have %d total waves', totalWaves);
    return totalWaves;
  }

  function getWaves() view public returns (Wave[] memory) {
    return waves;
  }
}