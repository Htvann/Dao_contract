import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import "@nomiclabs/hardhat-ethers";
import "./task";
// import "hardhat-deploy-ethers";

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.18",
    /* settings: {
      optimizer: {
        enabled:false,
        runs: 200,
      },
    }, */
  },
  defaultNetwork: "hardhat",
  networks: {
    hardhat: {
      chainId: 1337,
    },
    bscTestnet: {
      url: "https://bsc-testnet.nodereal.io/v1/69632b6b34cb4da4844f63a19e275363",
      accounts: [
        "a25c3b12cbb70745dd34bf9c0fc0290a539ff6f6f580eda1c5b5348278fd2687",
      ],
      chainId: 97,
    },
    poolsChain: {
      url: "https://rpc-testnet.poolsmobility.com/",
      accounts: [
        "a25c3b12cbb70745dd34bf9c0fc0290a539ff6f6f580eda1c5b5348278fd2687",
      ],
      chainId: 12345,
    },
  },
  namedAccounts: {
    deployer: 0,
    simpleERC20Beneficiary: 1,
  },
  etherscan: {
    apiKey: "QE3ZQ792TTY9RQYQQT4YR3UD8Q442IR412",
    customChains: [
      {
        network: "poolsChain",
        chainId: 12345,
        urls: {
          apiURL: "https://rpc-testnet.poolsmobility.com/",
          browserURL: "https://scan-testnet.poolsmobility.com/",
        },
      },
    ],
  },
  typechain: {
    outDir: "typechain",
    target: "ethers-v5",
  },
};

export default config;
