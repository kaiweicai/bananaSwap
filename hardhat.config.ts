import { task } from "hardhat/config";
import("@nomiclabs/hardhat-waffle");
import { HardhatUserConfig } from "hardhat/config";
import * as setting from "./scripts/setting";
import "@nomiclabs/hardhat-ethers";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-gas-reporter";
import "solidity-coverage";
//import "hardhat-contract-sizer";
// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  contractSizer: {
    alphaSort: true,
    disambiguatePaths: false,
    runOnCompile: true,
    //strict: true,
  },
  gasReporter: {
    enabled: true,
    //currency: "CHF",
    gasPrice: 21,
    currency: "USD",
    //outputFile: "gas-report.txt",
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      gas: 40000000,
      blockGasLimit: 40000000,
      allowUnlimitedContractSize: true,
      timeout: 1800000,
      gasPrice: 875000000,
    },
    bsc_test: {
      chainId: 97,
      gas: 12000000,
      blockGasLimit: 13000000,
      allowUnlimitedContractSize: true,
      timeout: 1800000,
      gasPrice: 10000000000,
      url: "https://data-seed-prebsc-2-s2.binance.org:8545",
      accounts: [setting.priKey01,setting.priKey02],
    },
    Matic_test:{
      chainId:80001,
      gas: 12000000,
      blockGasLimit: 13000000,
      allowUnlimitedContractSize: true,
      timeout: 1800000,
      gasPrice: 31000000000,
      //'https://matic-mainnet.chainstacklabs.com'////https://rpc-mumbai.maticvigil.com
      url: "https://matic-mumbai.chainstacklabs.com",
      accounts: [setting.priKey01,setting.priKey02]
    },
    kovan: {
      url: "https://kovan.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161",
      accounts: [setting.priKey01,setting.priKey02],
    },
  },
  //solidity: "0.8.0",
  solidity: {
    compilers: [
      {
        version: "0.8.4",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
          outputSelection: {
            "*": {
              "*": ["storageLayout"],
            },
          },
        },
      },
      {
        version: "0.6.12",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200,
          },
          outputSelection: {
            "*": {
              "*": ["storageLayout"],
            },
          },
        },
      },
    ],
  },
};
