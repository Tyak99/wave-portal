// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;
  event newWave(address indexed from, uint timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint timestamp;
  }

  Wave[] waves;

  constructor() {
    console.log('Lets gooooo. My first contract');
  }

  function wave(string memory _message) public {
    totalWaves += 1;
    console.log("%s waved", msg.sender, _message);
    Wave memory waver = Wave(msg.sender, _message, block.timestamp);
    waves.push(waver);
    emit newWave(msg.sender, block.timestamp, _message);
  }

  function getTotalWaves() view public returns (uint) {
    console.log('We have %d total waves', totalWaves);
    return totalWaves;
  }

  function getWaves() view public returns (Wave[] memory) {
    return waves;
  }
}