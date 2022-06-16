// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/IRandomNumber.sol";

contract RandomNumber is IRandomNumber{
	uint private randomNow;
	function randomNumber(uint salt) public override returns(uint)
	{
		randomNow = uint(keccak256(abi.encode(randomNow, salt, block.timestamp, block.number)));
		return randomNow;
	}
}