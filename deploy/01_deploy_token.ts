import { DeployFunction } from "hardhat-deploy/types";
import { getNamedAccounts, deployments } from "hardhat";

const deployFunction: DeployFunction = async () => {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();

  /* await deploy("BUSD", {
    contract: "BUSD",
    from: deployer,
    log: true,
  }); */

  /* await deploy("PPP", {
    contract: "Contract",
    from: deployer,
    log: true,
    args: ["PPP", "ppp"],
  }); */

  console.log("---------------------deploy token----------------------");
};

export default deployFunction;
deployFunction.tags = [`BUSD`, "HOMES"];
