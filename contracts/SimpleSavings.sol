//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract SimpleSavings {
    address public owner;
    mapping(address => uint256) public balances;
    uint256 public totalDeposits;

    constructor() {
        owner = msg.sender;
    }

    event Deposited(address indexed user, uint256 amount, uint256 timestamp);
    event Withdrawn(address indexed user, uint256 amount, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    modifier validAmount(uint256 amount) {
        require(amount > 0, "Amount must be greater than 0");
        _;
    }

    function deposit() external payable validAmount(msg.value) {
        balances[msg.sender] += msg.value;
        totalDeposits += msg.value;
        
        emit Deposited(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) external validAmount(amount) {
        balances[msg.sender] -= amount;
        totalDeposits -= amount;

        (bool success, ) = payable(msg.sender).call{value: amount}("");

        require(success, "Transfer failed");

        emit Withdrawn(msg.sender, amount, block.timestamp);
    }

    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getTotalDeposits() public view returns (uint256) {
        return totalDeposits;
    }

    function emergencyWithdraw() external onlyOwner {
        uint256 contracBalance = address(this).balance;
        
        (bool success, ) = payable(owner).call{value: contracBalance}("");

        require(success, "Transfer failed");
    }
}
