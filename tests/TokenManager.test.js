const {ethers} = require("hardhat");
const { expect } = require("chai");
const { BigNumber } = ethers;
const {BN} = require('@openzeppelin/test-helpers');
const { time } = require("./utilities")
const { ADDRESS_ZERO } = require("./utilities");


let owner, user, alice;
let tokenManager;

const usdtAddress = "0x6B175474E89094C44Da98b954EedeAC495271d0F";
const token1Address = "0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
const token2Address = "0x8dAEBADE922dF735c38C80C7eBD708Af50815fAa";
const token3Address = "0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599";
const tokenBddress = "0xdAC17F958D2ee523a2206206994597C13D831ec7";

async function withDecimals(amount) {
    return new BN(amount).mul(new BN(10).pow(new BN(18))).toString();
}

describe("Base user func", async function() {
    before(async function() {
        this.signers = await ethers.getSigners();
        owner = this.signers[0];
        user = this.signers[1];
        alice = this.signers[2];
        this.TokenManager = await ethers.getContractFactory("TokenManager");
    });

    beforeEach(async function() {
        tokenManager = await this.TokenManager.deploy();
        await tokenManager.deployed();
    });

    it("initialize", async function() {

        expect(await tokenManager.isTokenB(tokenBddress)).to.be.equal(false);
        expect(await tokenManager.isUsdt(usdtAddress)).to.be.equal(false);
        await tokenManager.initialize(
            tokenBddress,usdtAddress
        );
        expect(await tokenManager.isTokenB(tokenBddress)).to.be.equal(true);
        expect(await tokenManager.isUsdt(usdtAddress)).to.be.equal(true);
        expect(await tokenManager.isTokenA(token1Address)).to.be.equal(false);
    });

    it("add tokenAList", async function() {
        await expect(tokenManager.addTokenAList(token1Address,true)).to.be.revertedWith("Not manager");
        expect(await tokenManager.isTokenB(tokenBddress)).to.be.equal(false);
        expect(await tokenManager.isUsdt(usdtAddress)).to.be.equal(false);
        await tokenManager.initialize(
            tokenBddress,usdtAddress
        );
        expect(await tokenManager.isTokenB(tokenBddress)).to.be.equal(true);
        expect(await tokenManager.isUsdt(usdtAddress)).to.be.equal(true);
        expect(await tokenManager.isTokenA(token1Address)).to.be.equal(false);
        await tokenManager.setManager(owner.address,true);
        await expect(tokenManager.connect(user).addTokenAList(token1Address,true,{from:user.address})).to.be.revertedWith("Not manager");
        await tokenManager.addTokenAList(token1Address,true);
        expect(await tokenManager.isTokenA(token1Address)).to.be.equal(true);
        expect(await tokenManager.isTokenA(token2Address)).to.be.equal(false);
        await tokenManager.addTokenAList(token2Address,true);
        expect(await tokenManager.isTokenA(token2Address)).to.be.equal(true);
        await tokenManager.addTokenAList(token3Address,true);
        expect(await tokenManager.isTokenA(token3Address)).to.be.equal(true);
        await tokenManager.addTokenAList(token2Address,false);
        expect(await tokenManager.isTokenA(token2Address)).to.be.equal(false);
    });

});
