// using chai and mocha for testing.
// mocha comes with hardhat and chat is imported below.
const { expect } = require("chai")
const { ethers } = require("hardhat")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe("ETHDaddy", () => {
  it('has a name', async() => {
    // getting javascript version of our contract using ethers.js library
    const ETHDaddy = await ethers.getContractFactory('ETHDaddy')
    let ethDaddy = await ETHDaddy.deploy()
    const result = await ethDaddy.name()
    expect(result).to.equal('ETH Daddy')
  })
})  
