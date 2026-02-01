
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract InterbankSettlement {
  address public operator;
  mapping(address => uint256) public balances;

  event BankSettled(address indexed fromBank, address indexed toBank, uint256 amount);

  constructor() { operator = msg.sender; }

  modifier onlyOperator() { require(msg.sender == operator); _; }

  function settle(address fromBank, address toBank, uint256 amount)
    external onlyOperator {
    require(balances[fromBank] >= amount);
    balances[fromBank] -= amount;
    balances[toBank] += amount;
    emit BankSettled(fromBank, toBank, amount);
  }
}
