// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

  event MinterChanged(address indexed from, address to);

  constructor() public payable ERC20("Decentralized Bank Currency", "DBC"){
    minter = msg.sender;
  }

  function  passMinterRole(address dbank) public returns (bool) {
    require(msg.sender == minter, 'Error Not owner');
    minter = dbank;

    emit MinterChanged(msg.sender, dbank);
    return true;
  }
  function mint(address account, uint256 amount) public {
    require(msg.sender == minter, 'Error, minter and sender NOT MATCH');

    _mint(account, amount);
  }
}