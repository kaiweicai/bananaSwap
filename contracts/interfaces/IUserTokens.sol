// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IUserTokens {
    function addUserTokenId(address _address, uint _tokenId) external;
    function deleteUserTokenId(address _address, uint _tokenId) external;
}