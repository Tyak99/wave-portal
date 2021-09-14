// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;
  struct Waver {
    address addr;
    uint waved_at;
  }
  Waver[] wavers;

  mapping(address => Waver) public hmm;

  constructor() {
    console.log('Lets gooooo. My first contract');
  }

  function wave() public {
    totalWaves += 1;
    Waver memory waver = Waver(msg.sender, block.timestamp);
    wavers.push(waver);
    hmm[msg.sender] = waver;
    console.log("%s waved", msg.sender);
  }

  function getTotalWaves() view public returns (uint) {
    console.log('We have %d total waves', totalWaves);
    return totalWaves;
  }
}