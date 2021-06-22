// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //은행의 주인의 계좌를 받는다.
  address public minter;

  //토큰의 보유자가 바뀔 시 생길 이벤트를 일으킴
  event MinterChanged(address indexed from, address to);

  //토큰을 발급할 사람은 현재 컨트랙트를 실행하는 사람이다
  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
    minter = msg.sender; //only initially
  }

  function passMinterRole(address dBank) public returns (bool) {
    //constructer error check
  	require(msg.sender==minter, 'Error, only owner can change pass minter role');
  	minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  function mint(address account, uint256 amount) public {
		require(msg.sender==minter, 'Error, msg.sender does not have minter role'); //dBank
		_mint(account, amount);
	}
}