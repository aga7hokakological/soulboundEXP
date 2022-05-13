import { expect } from "chai";
import { ethers } from "hardhat";

describe("SoulBoundEXP", function () {
  it("Should return the new greeting once it's changed", async function () {
    const SoulBoundEXP = await ethers.getContractFactory("SoulBoundEXP");
    const soulBoundExp = await SoulBoundEXP.deploy();
    await soulBoundExp.deployed();

    expect(await soulBoundExp.greet()).to.equal("Hello, world!");

    const setGreetingTx = await soulBoundExp.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    await setGreetingTx.wait();

    expect(await soulBoundExp.greet()).to.equal("Hola, mundo!");
  });
});
