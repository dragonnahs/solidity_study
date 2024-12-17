// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract Control{
    function sortArr(uint[] memory a) external pure  returns(uint[] memory) {
        for(uint i = 0;i<a.length;i++) {
            uint j = i + 1;
            while (j < a.length && a[i] > a[j]){
                uint temp = a[i];
                a[i] = a[j];
                a[j] = temp;
                j++;
            } 
        }
        return (a);
    }
}