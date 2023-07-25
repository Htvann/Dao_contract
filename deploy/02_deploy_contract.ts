import { DeployFunction } from "hardhat-deploy/types";
import { getNamedAccounts, deployments, ethers } from "hardhat";

const deployFunction: DeployFunction = async () => {
  // const BUSD = await ethers.getContractFactory("BUSD");

  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  /* await deploy("AIHomesDAO", {
    contract: "AIHomesDAO",
    from: deployer,
    args: [deployer, deployer],
    log: true,
  }); */

  // console.log(BUSD);
  console.log("---------------------get name token----------------------");
};

export default deployFunction;
deployFunction.tags = [`AIHomesDAO`, `deploy`];
