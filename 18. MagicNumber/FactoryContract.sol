pragma solidity ^0.8.0;


interface IMagicNum{
    function setSolver(address _solver) external;
}

contract Factory{

    IMagicNum public magicNum;

    constructor (IMagicNum challenge){
        magicNum = challenge;
    }

    function deploy() external {
        bytes memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";
        bytes32 salt = 0;
        address solver;

        assembly {
            solver := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }

        magicNum.setSolver(solver);
    }
}