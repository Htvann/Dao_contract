import { ethers } from "hardhat";

async function main() {
  const [owner] = await ethers.getSigners();
  const Lock = await ethers.getContractFactory("AihomeDaoStaking");
  const lock = await Lock.deploy(owner.address, owner.address);
  await lock.deployed();
  console.log(`${lock.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
