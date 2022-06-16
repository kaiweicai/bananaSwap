//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';

contract TokenManager is OwnableUpgradeable {
    // class A mapping
    mapping(address => bool) public classAMapping;
    //class B mapping
    mapping(address => bool) public classBMapping;

    //class USDT Mapping
    mapping(address => bool) public UsdtMapping;

    mapping(address => bool) private isManager;

    modifier onlyManager() {
        require(isManager[_msgSender()], "Not manager");
        _;
    }

    function initialize(address _tokenB,address _usdt) public initializer {
        __Ownable_init();
        classBMapping[_tokenB] = true;
        UsdtMapping[_usdt] = true;
    }

    
    function addTokenAList(address tokenAAddress,bool add)public onlyManager{
        if (add) {
            classAMapping[tokenAAddress] = true;
        }else{
            delete classAMapping[tokenAAddress];
        }
    }

    function isTokenA(address tokenAddress) public view returns (bool) {
        return classAMapping[tokenAddress];
    }

    function isTokenB(address tokenAddress) public view returns (bool) {
        return classBMapping[tokenAddress];
    }

    function isUsdt(address tokenAddress) public view returns (bool) {
        return UsdtMapping[tokenAddress];
    }

    function setManager(address _manager, bool _flag) public onlyOwner {
        isManager[_manager] = _flag;
    }
    
}
