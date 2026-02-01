
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract BankStablecoin {
  address public bank;
  mapping(address => uint256) public tokenizedBalance;
  mapping(address => uint256) public stablecoinBalance;

  event Minted(address indexed user, uint256 amount);
  event Burned(address indexed user, uint256 amount);
  event Converted(address indexed user, uint256 amount);
	event StablecoinTransferred(
        address indexed from,
        address indexed to,
        uint256 amount
    );
  constructor() { bank = msg.sender; }

  modifier onlyBank() { require(msg.sender == bank); _; }

  function mint(address user, uint256 amount) external onlyBank {
    tokenizedBalance[user] += amount;
    emit Minted(user, amount);
  }

  function burn(address user, uint256 amount) external onlyBank {
    require(tokenizedBalance[user] >= amount);
    stablecoinBalance[user] -= amount;
    tokenizedBalance[user] -= amount;
    emit Burned(user, amount);
  }

  function convertToStablecoin(address user, uint256 amount) external onlyBank {
    require(tokenizedBalance[user] >= amount);
    tokenizedBalance[user] -= amount;
    stablecoinBalance[user] += amount;
    emit Converted(user, amount);
  }
   function transferStablecoin(
        address from,
        address to,
        uint256 amount) external onlyBank {
        require(from != address(0), "Invalid from address");
        require(to != address(0), "Invalid to address");
        require(from != to, "From and to cannot be same");
        require(
            stablecoinBalance[from] >= amount,
            "Insufficient stablecoin balance"
        );

        stablecoinBalance[from] -= amount;
        stablecoinBalance[to] += amount;

        emit StablecoinTransferred(from, to, amount);
    }
}
