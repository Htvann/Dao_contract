import { task } from "hardhat/config";
import { HardhatRuntimeEnvironment, TaskArguments } from "hardhat/types";

task("getbalance", "Prints an account's balance")
  // .addParam("address", "The account's address")
  .setAction(
    async (taskArgs: TaskArguments, hre: HardhatRuntimeEnvironment) => {
      const accounts = await hre.ethers.getSigners();
      const contractAddress = "0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512";
      const myContract = await hre.ethers.getContractAt(
        "HOMES",
        contractAddress
      );

      console.log(myContract.address);
      console.log(accounts[0].address);
    }
  );
