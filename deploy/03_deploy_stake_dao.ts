import { DeployFunction } from "hardhat-deploy/types";
import { getNamedAccounts, deployments } from "hardhat";

const deployFunction: DeployFunction = async () => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  await deploy("AihomeDaoStaking", {
    contract: "AihomeDaoStaking",
    from: deployer,
    args: [deployer, deployer],
    log: true,
  });

  console.log("---------------------get name token----------------------");
};

export default deployFunction;
deployFunction.tags = [`stakingAiHomesDao`, `deploy`];
