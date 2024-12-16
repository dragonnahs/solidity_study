// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract VarStorage{
    uint[] _arr = [1,2,3];

    function fStorage() external {
        uint[] storage _arr2 = _arr;
        _arr2[0] = 100;
    }
}