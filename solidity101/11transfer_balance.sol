// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract TransferBanlace{

    constructor() payable {}
    function sendEth(address payable repair, uint256 amount) public {
        require(address(this).balance >= amount, "balance is not enouch");
        repair.transfer(amount);
    }
    function getEth() external view returns(uint256) {
        return  address(this).balance;
    }
    function refund(address url) external {
       (bool success, ) = payable(msg.sender).call{value: address(url).balance}("");
       require(success, "refund failed");
    }
    function refundSelf() external {
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
       require(success, "refund failed");
    }
}