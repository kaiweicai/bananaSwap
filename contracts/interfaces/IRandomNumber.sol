// Copyright (C) 2021 Cycan Technologies
// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

interface IRandomNumber {
    function randomNumber(uint salt) external returns (uint);
}