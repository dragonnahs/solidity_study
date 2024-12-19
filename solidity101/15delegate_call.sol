// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract CContract{
    uint256 public x;
    address public _add;
    function setX(uint256 _x) external {
        x = _x;
        _add = msg.sender;
    }
}
contract DelegateCall{
    uint256 public x;
    address public _add;
    function callSetX(address _address, uint256 _x) external payable  {
        (bool success, bytes memory data) = _address.call(
            abi.encodeWithSignature("setX(uint256)", _x)
        );
    }
    function delegateCallSetX(address _address, uint256 _x) external payable {
        (bool success, bytes memory data) = _address.delegatecall(
            abi.encodeWithSignature("setX(uint256)", _x)
        );
    }
}