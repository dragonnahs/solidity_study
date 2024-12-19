// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Pair{
    address public factory;
    address public token0;
    address public token1;

    constructor() payable {
        factory = msg.sender;
    }

    function initialize(address _token0, address _token1) external {
        require(factory == msg.sender, "unswapV1: error not same");
        token0 = _token0;
        token1 = _token1;
    }
}

contract PairFactory2{
    mapping(address => mapping (address => address)) public  getPair;
    address[] public  allPairs;

    function createPair2(address tokenA, address tokenB) external payable returns(address pairAdd){
        require(tokenA != tokenB, "not same token");
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));

        Pair pair = new Pair{salt: salt}();
        pair.initialize(tokenA, tokenB);

        pairAdd = address(pair);
        allPairs.push(pairAdd);
        getPair[tokenA][tokenB] = pairAdd;
        getPair[tokenB][tokenA] = pairAdd;
    }

    // calculate address is or not same createPair address
    function calculateAdd(address tokenA, address tokenB) external view  returns(address prediectedAdd) {
        require(tokenA != tokenB, "same token is not allow");
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));

        prediectedAdd = address(uint160(uint(keccak256(abi.encodePacked(
            bytes1(0xff),
            address(this),
            salt,
            keccak256(type(Pair).creationCode)
            // if create pair using Pair pair = new Pair{salt: salt}(params), then calculate address add a arg params like blew this:
            //  keccak256(type(Pair).creationCode, abi.encode(params))
        )))));
    }
}