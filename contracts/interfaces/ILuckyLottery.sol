// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface ILuckyLottery {
    function addRewardToken(address _tokenAddress) external;
    function addLotteryData(uint _poolId, address _address, uint _quantity, address _token20Address, uint _amount) external;
}
