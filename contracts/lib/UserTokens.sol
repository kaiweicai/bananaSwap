// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "../interfaces/IUserTokens.sol";
import "../interfaces/INFTFactory.sol";

contract UserTokens is OwnableUpgradeable, IUserTokens {
    // Mapping from address to is internal caller or not
    mapping(address => bool) public isInternalCaller;

    // NFT token instance
    INFTFactory public token1155;

    struct TokenInfo {
        // user token id array
        uint256[] tokenIds;
        // mapping from token id to index
        mapping(uint256 => uint256) tokenIdIndex;
        // mapping from token id to is exist or not
        mapping(uint256 => bool) isTokenIdExist;
    }

    // Mapping from user address to user token info
    mapping(address => TokenInfo) internal userTokenInfo;

    // Restrict internal call
    modifier onlyInternal() {
        require(
            isInternalCaller[_msgSender()],
            "caller is not a internal caller"
        );
        _;
    }

    function initialize(INFTFactory _token1155) public initializer {
        __Ownable_init();

        token1155 = _token1155;
    }

    // set internal call address
    function setInternalCaller(address _internal, bool _set) public onlyOwner {
        isInternalCaller[_internal] = _set;
    }

    /**
     * @dev Add user token id
     */
    function addUserTokenId(address _address, uint256 _tokenId)
        external
        override
        onlyInternal
    {
        TokenInfo storage tokenInfo = userTokenInfo[_address];
        if (!tokenInfo.isTokenIdExist[_tokenId]) {
            tokenInfo.tokenIds.push(_tokenId);
            tokenInfo.tokenIdIndex[_tokenId] = tokenInfo.tokenIds.length;
            tokenInfo.isTokenIdExist[_tokenId] = true;
        }
    }

    /**
     * @dev Delete user token id
     */
    function deleteUserTokenId(address _address, uint256 _tokenId)
        external
        override
        onlyInternal
    {
        TokenInfo storage tokenInfo = userTokenInfo[_address];

        uint256 lastTokenId = tokenInfo.tokenIds[tokenInfo.tokenIds.length - 1];
        tokenInfo.tokenIds[tokenInfo.tokenIdIndex[_tokenId] - 1] = lastTokenId;
        tokenInfo.tokenIdIndex[lastTokenId] = tokenInfo.tokenIdIndex[_tokenId];
        delete tokenInfo.tokenIds[tokenInfo.tokenIds.length - 1];
        delete tokenInfo.tokenIdIndex[_tokenId];
        tokenInfo.tokenIds.pop();
        tokenInfo.isTokenIdExist[_tokenId] = false;
    }

    function getTokenIdsLength(address _address) public view returns (uint256) {
        return userTokenInfo[_address].tokenIds.length;
    }

    function getUserTokenInfo(address _address, uint256 _index)
        public
        view
        returns (
            uint256,
            string memory,
            uint256,
            bool,
            uint256
        )
    {
        uint256 tokenId = userTokenInfo[_address].tokenIds[_index];
        (, string memory uri, , uint256 tokenIndex, bool isFragment) = token1155
            .getTokenInfo(tokenId);
        uint256 balance = token1155.balanceOf(_address, tokenId);

        return (tokenId, uri, tokenIndex, isFragment, balance);
    }
}
