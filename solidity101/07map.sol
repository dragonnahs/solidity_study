// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract MapType {
    mapping (uint => uint) public  _map;
    function writeMapping(uint key, uint _value) external {
        _map[key] = _value;
    }
}