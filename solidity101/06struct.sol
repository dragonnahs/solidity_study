// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;
contract StructType {
    struct Student{
        uint256 id;
        uint256 score;
    }
    Student student;
    function initStudent1() external {
        Student storage _student = student;
        _student.id = 10;
        _student.score = 100;
    }
    function initStudent2() external {
        student.id = 11;
        student.score = 101;
    }
    function initStudent3() external {
        student = Student(12,102);
    }
    function initStudent4() external {
        student = Student({id: 13, score: 103});
    }
}