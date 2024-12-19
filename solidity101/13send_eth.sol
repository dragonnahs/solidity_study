//SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SendEth{
    constructor() payable {}
    receive() external payable { }
    function sendEth(address payable _to, uint256 amount) external payable {
        _to.transfer(amount);
    }
}