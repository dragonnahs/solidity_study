// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract ModifierCon{
    address public  owner;
    constructor(address initOwner){
        owner = initOwner;
    }
    modifier OnlyOwner{
        require(msg.sender == owner);
        _;
    }
    function changeOwner(address otherOwner) external OnlyOwner{
        owner = otherOwner;
    }
}