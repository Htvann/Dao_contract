import { ethers, run } from "hardhat";

async function main() {
  const StorageFactory = await ethers.getContractFactory("PPP");
  const Storage = await StorageFactory.deploy();

  console.log(`address: ${Storage.address}`);

  await Storage.deployTransaction.wait(5);
  await run("verify:verify", {
    address: Storage.address,
    constructorAgruments: ["PPP", "PPP"],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
