//SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ReceiveEth{
    event Log(uint amount, uint gas);
    receive() external payable {
        emit Log(msg.value, gasleft());
    }
    function getBanlance() external view returns(uint256){
        return address(this).balance;
    }
}