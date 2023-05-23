// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract AttendanceSystem {
    
    // Define a struct to store the details of each student
    struct Student {
        string name;
        bool status;
        bool present;
        
    }
    
    // Mapping to store the students' details using their Ethereum addresses as keys
    mapping(address => Student) public students;
    
    // Array to store the Ethereum addresses of all students
    address[] public studentList;
    
    // Address of the teacher who has the authority to add students and mark attendance
    address public teacher;
    
    // Constructor to set the teacher's address when the contract is deployed
    constructor() {
        teacher = msg.sender;
    }
    
    // Function to add a new student to the system
    function Add(string memory _name, address _address) public {
        // Only the teacher is authorized to add students
        require(msg.sender == teacher, "Only teacher can add students");
        
        // Check if the student already exists in the system
        require(students[_address].status == false, "Student already exists");
        // Add the new student to the system
        students[_address] = Student(_name, true,false);//true
        studentList.push(_address);
    }
    
    // Function to mark attendance of a student
    function Present(address _address) public {
        // Only the teacher is authorized to mark attendance
        require(msg.sender == teacher, "Only teacher can mark attendance");
        
        // Check if the student exists in the system
        require(students[_address].status == true, "Student does not exist");
        
        // Mark the student present
        students[_address].present = true;
    }
    
    // Function to get the attendance status of a student
    function Check(address _address) public view returns (bool) {
        return students[_address].present;
    }    
    // Function to get the list of all students in the system
    function Students() public view returns (address[] memory) {
        return studentList;
    }
}
