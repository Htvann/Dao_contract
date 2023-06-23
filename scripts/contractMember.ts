import { ethers } from "hardhat";

async function main() {
  const [owner] = await ethers.getSigners();
  const Lock = await ethers.getContractFactory("AihomeDaoStaking");
  const lock = await Lock.deploy(owner.address, owner.address);
  await lock.deployed();
  /* const HOMES = "0x8402c360a9c1c9214d870c00835450899bc4f318";
  const contract = await ethers.getContractFactory("ContractSwap");
  const Contract = await contract.deploy(
    owner.address,
    "0xdfF17F3a10Cb79ac474F7c7a8f41fc53E4142cEe",
    "0x8402c360a9C1C9214D870c00835450899bC4F318"
  );
  await Contract.deployed(); */
  console.log(`${lock.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
