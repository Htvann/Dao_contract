import { ethers } from "hardhat";
import { Contract } from "ethers";

describe("Test Contract", function () {
  let PPP: Contract;
  let SwapPPP: Contract;

  beforeEach(async function () {
    const [owner] = await ethers.getSigners();

    const StorageFactory = await ethers.getContractFactory("PPP");
    PPP = await StorageFactory.deploy();
    await PPP.deployed();

    const ContractSwap = await ethers.getContractFactory("SwapPPP");
    SwapPPP = await ContractSwap.deploy(owner.address);
    await SwapPPP.deployed();
  });

  it("Deployment", async function () {
    const [owner, owner2] = await ethers.getSigners();
    await PPP.approve(SwapPPP.address, ethers.constants.MaxUint256);

    console.log(
      "balance PPP 1:",
      (await PPP.balanceOf(owner.address)).toString()
    );

    console.log("address", SwapPPP.address);

    await PPP.grantRole(
      "0x07f43ac6ee24425b996253fe6b8df1552b31a8c2b0f2c135f7bbaf1c09645029",
      SwapPPP.address
    );

    console.log(
      "balance PPP 2:",
      (await PPP.balanceOf(owner2.address)).toString()
    );

    await SwapPPP.swap("100000000000000000000", owner2.address);

    console.log(
      "balance PPP 2:",
      (await PPP.balanceOf(owner2.address)).toString()
    );
    console.log("locker:", (await PPP.lockedAmount(owner2.address)).toString());
  });
});
