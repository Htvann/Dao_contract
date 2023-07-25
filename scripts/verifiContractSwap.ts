import { ethers, run } from "hardhat";

async function main() {
  const [owner] = await ethers.getSigners();
  const StorageFactory = await ethers.getContractFactory("SwapPPP");
  const Storage = await StorageFactory.deploy(owner.address);
  await Storage.deployTransaction.wait(5);

  await run("verify:verify", {
    address: Storage.address,
    constructorAgruments: ["0x3d9f658cE3cC3c4575bdb89E4f0970f08b9d1354"],
  });
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
