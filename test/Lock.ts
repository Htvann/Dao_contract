import { ethers } from "hardhat";
import { Contract } from "ethers";

describe("Test Contract", function () {
  let HOMES: Contract;
  let BUSD: Contract;
  let HomeDao: Contract;
  let StakeDao: Contract;
  let ContractSwap: Contract;

  beforeEach(async function () {
    const [owner] = await ethers.getSigners();

    // HOMES token
    const hometoken = await ethers.getContractFactory("HOMES");
    HOMES = await hometoken.deploy();
    await HOMES.deployed();

    // BUSD token
    const busdtoken = await ethers.getContractFactory("BUSD");
    BUSD = await busdtoken.deploy();
    await BUSD.deployed();

    // ContractSwap
    const contractSwap = await ethers.getContractFactory("ContractSwap");
    ContractSwap = await contractSwap.deploy(
      owner.address,
      BUSD.address,
      HOMES.address
    );
    await ContractSwap.deployed();

    // AIHOMESDAO
    const homedao = await ethers.getContractFactory("AIHomesDAO");
    HomeDao = await homedao.deploy(owner.address, owner.address);
    await HomeDao.deployed();

    //StakeDao
    const stakedao = await ethers.getContractFactory("AihomeDaoStaking");
    StakeDao = await stakedao.deploy(owner.address, owner.address);
    await StakeDao.deployed();
  });

  it("Deployment", async function () {
    const [owner, owner2] = await ethers.getSigners();

    await HOMES.approve(ContractSwap.address, ethers.constants.MaxUint256);
    await BUSD.approve(ContractSwap.address, ethers.constants.MaxUint256);

    await HOMES.connect(owner2).approve(
      ContractSwap.address,
      ethers.constants.MaxUint256
    );
    await BUSD.connect(owner2).approve(
      ContractSwap.address,
      ethers.constants.MaxUint256
    );

    console.log(
      "balance busd",
      BUSD.address,
      (await BUSD.balanceOf(owner2.address)).toString()
    );
    console.log(
      "balance homes",
      HOMES.address,
      (await HOMES.balanceOf(owner2.address)).toString()
    );

    await ContractSwap.connect(owner2).faucet();
    console.log("---------faucet-----------");
    console.log(
      "balance busd",
      BUSD.address,
      (await BUSD.balanceOf(owner2.address)).toString()
    );
    console.log(
      "balance homes",
      HOMES.address,
      (await HOMES.balanceOf(owner2.address)).toString()
    );

    await ContractSwap.connect(owner2).swap("100000000000000000000");
    console.log("----------swap----------");
    console.log(
      "balance busd",
      BUSD.address,
      (await BUSD.balanceOf(owner2.address)).toString()
    );
    console.log(
      "balance homes",
      HOMES.address,
      (await HOMES.balanceOf(owner2.address)).toString()
    );

    // console.log("owner", owner.address);
    // console.log("HOMES", HOMES.address);
    // console.log("BUSD", BUSD.address);
    console.log("HomeDao", HomeDao.address);
    // console.log("StakeDao", StakeDao.address);

    await HOMES.grantRole(
      "0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42",
      HomeDao.address
    );

    //owner
    await HOMES.approve(HomeDao.address, ethers.constants.MaxUint256);
    await BUSD.approve(HomeDao.address, ethers.constants.MaxUint256);
    await HOMES.approve(StakeDao.address, ethers.constants.MaxUint256);
    await BUSD.approve(StakeDao.address, ethers.constants.MaxUint256);

    await HomeDao.createDAO("dddd", BUSD.address, 1);
    //owner2
    await BUSD.connect(owner2).approve(
      HomeDao.address,
      ethers.constants.MaxUint256
    );

    await HOMES.connect(owner2).approve(
      StakeDao.address,
      ethers.constants.MaxUint256
    );

    await StakeDao.connect(owner2).joinDao(1, "ddd");
    console.log(await StakeDao.isExistName("ddd"));
    // console.log(await StakeDao.profileDaoById(1));
    await StakeDao.connect(owner2).leaveDao();
    console.log(await StakeDao.getInfoMemberById(1, 1));
    console.log(await StakeDao.isExistName("ddd"));
    // console.log(await StakeDao.profileDaoById(1));
  });
});
