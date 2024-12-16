// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Type {
    uint public number1 = 1;
    uint256 public _number = 20241213; 
    uint256 public _number2 = _number + 1;
    uint256 public _number3 = 2**2;
    bool public _bool = _number2 > _number3;
    address public _address1 = 0xf8e81D47203A594245E36C48e151709F0C19fBe8;
    address public _address2 = payable(_address1);
    bytes32 public _bytes32 = "MiniSolidity";
    bytes1 public _bytes1 = _bytes32[0];
    enum ActionSet { Buy, Hold, Sell }
    ActionSet action = ActionSet.Sell;
    function enumToUint() external view  returns(uint){
        return uint(action);
    }
}