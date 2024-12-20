// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./17ERC20.sol"; // 引入已创建的 MyToken 合约erc

contract TokenFaucet {
    MyToken public token; // MyToken 合约的实例
    uint256 public amountAllowed = 100 * 10 ** 18; // 每个用户允许领取的代币数量，单位是最小单位
    mapping(address => bool) public hasClaimed; // 记录用户是否已经领取过代币

    // 构造函数，接受一个 MyToken 合约地址
    constructor(address tokenAddress) {
        token = MyToken(tokenAddress); // 初始化 MyToken 合约实例
    }

    // 请求代币的函数
    function requestTokens() external {
        // 检查用户是否已经领取过代币
        require(!hasClaimed[msg.sender], "You have already claimed your tokens.");

        // 检查水龙头合约中是否有足够的代币
        require(token.balanceOf(address(this)) >= amountAllowed, "Faucet has insufficient tokens.");

        // 发送代币给请求的用户
        token.transfer(msg.sender, amountAllowed);

        // 标记该用户已经领取过代币
        hasClaimed[msg.sender] = true;
    }

    // 获取水龙头合约中的代币余额
    function faucetBalance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    // 管理员可以向水龙头合约转账代币，确保水龙头有足够的代币可供分发
    function deposit(uint256 amount) external {
        token.transferFrom(msg.sender, address(this), amount);
    }
}
