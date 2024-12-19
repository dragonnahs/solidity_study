// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract OtherContract{
    event Log(uint value, uint gas);
    uint256 private x;
    function setX(uint256 _x) external payable {
        x = _x;
        if(msg.value > 0) {
            emit Log(msg.value, gasleft());
        }
    }
    function getX() external view returns(uint256){
        return x;
    }
    function getBalance() external view  returns(uint256){
        return address(this).balance;
    }
}

contract CallContract{
    constructor() payable {}
    function callSextX(address _address ,uint256 x) external {
        OtherContract(_address).setX(x);
    }
    function callGetX(OtherContract _address) external view returns(uint256){
        return _address.getX();
    }

    function callAndSendEth(address _address, uint256 _x) external  payable {
        OtherContract(_address).setX{value: msg.value}(_x);
    }
}