import { task } from "hardhat/config";
import { HardhatRuntimeEnvironment, TaskArguments } from "hardhat/types";

task("join", "Prints an account's balance")
  // .addParam("account", "The account's address")
  .setAction(
    async (taskArgs: TaskArguments, hre: HardhatRuntimeEnvironment) => {
      // const contract = await ethers.getContractFactory("AihomeDaoStaking");
      const contract = await hre.ethers.getContractAt(
        "AihomeDaoStaking",
        "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0"
      );
      console.log(await contract.joinDao(1));
    }
  );

task("stake", "stake").setAction(
  async (taskArgs: TaskArguments, hre: HardhatRuntimeEnvironment) => {
    // const contract = await ethers.getContractFactory("AihomeDaoStaking");
    const contract = await hre.ethers.getContractAt(
      "AihomeDaoStaking",
      "0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0"
    );
    console.log(await contract.stake(100 * 10 ** 18));
  }
);
