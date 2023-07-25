import { ethers, run } from "hardhat";

async function main() {
  const [owner] = await ethers.getSigners();
  const StorageFactory = await ethers.getContractFactory("AihomeDaoStaking");
  const Storage = await StorageFactory.deploy(owner.address, owner.address);
  console.log("address", Storage.address);

  /* await Storage.deployTransaction.wait(3);
  await run("verify:verify", {
    address: Storage.address,
    constructorAgruments: [owner.address, owner.address],
  }); */
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
