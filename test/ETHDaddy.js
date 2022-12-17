// using chai and mocha for testing.
// mocha comes with hardhat and chat is imported below.
const { expect } = require("chai")
const { ethers } = require("hardhat")

const tokens = (n) => {
  return ethers.utils.parseUnits(n.toString(), 'ether')
}

describe("ETHDaddy", () => {

  let ethDaddy
  let deployer, owner1

  const NAME = 'ETH Daddy'
  const SYMBOL = 'ETHD'

  beforeEach(async () => {
    // Signers is an object that contain wallets of users.
    // Setup accounts
    [deployer, owner1] = await ethers.getSigners()
    
    // Deploy contract
    // getting javascript version of our contract using ethers.js library
    const ETHDaddy = await ethers.getContractFactory('ETHDaddy')
    ethDaddy = await ETHDaddy.deploy('ETH Daddy', 'ETHD')
  })

  describe('Deployment', () => {
    it('has a name', async() => {
      const result = await ethDaddy.name()
      expect(result).to.equal(NAME)
    })
  
    it('has a symbol', async() => {
      const result = await ethDaddy.symbol()
      expect(result).to.equal(SYMBOL)
    })

    it('Sets the owner', async() => {
      const result = await ethDaddy.owner()
      expect(result).to.equal(deployer.address)
    })
  })
})  
